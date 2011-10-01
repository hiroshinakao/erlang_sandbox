-module(my_db).
-import(db).
-export([start/0, init/0, stop/0]).
-export([write/2, delete/1, read/1, match/1]).
-export([loop/1]).

start() ->
  register(?MODULE, spawn(my_db, init, [])),
  ok.

init() ->
  Db = db:new(),
  loop(Db).

stop()              -> call(stop).
write(Key, Element) -> call({write, Key, Element}).
delete(Key)         -> call({delete, Key}).
read(Key)           -> call({read, Key}).
match(Element)      -> call({match, Element}) .

call(Message) ->
  my_db ! {request, self(), Message},
  receive
    {reply, Reply} -> Reply
  end.

loop(Db) ->
  receive
    {request, Pid, {write, Key, Element}} ->
      NewDb = db:write(Key, Element, Db),
      Pid ! {reply, ok},
      loop(NewDb);
    {request, Pid, {delete, Key}} ->
      NewDb = db:delete(Key, Db),
      Pid ! {reply, ok},
      loop(NewDb);
    {request, Pid, {read, Key}} ->
      Result = db:read(Key, Db),
      Pid ! {reply, Result},
      loop(Db);
    {request, Pid, {match, Element}} ->
      Results = db:match(Element, Db),
      Pid ! {reply, Results},
      loop(Db);
    {request, Pid, stop} ->
      Pid ! {reply, ok}
  end.
