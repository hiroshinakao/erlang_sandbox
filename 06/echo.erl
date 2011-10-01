-module(echo).
-export([start/0, print/1, stop/0, loop/0]).

start() ->
  register(echo, spawn(echo, loop, [])),
  echo ! start
.

print(Term) ->
  echo ! {print, Term}
.

stop() ->
  echo ! stop
.

loop() ->
  receive
    {print, Msg} ->
      io:format("Msg: ~w~n",[Msg]),
      loop();
    start ->
      io:format("[start]echo server ~n", []),
      loop();
    stop ->
      io:format("[stop]echo server ~n", []),
      true
  end
.
