-module(echo).
-export([start/0, print/1, stop/0, loop/0]).

start() -> register(?MODULE, spawn(echo, loop, [])), ok.

print(Term) -> ?MODULE ! {print, Term}, ok.
stop()      -> ?MODULE ! stop         , ok.

loop() ->
  receive
    {print, Msg} -> io:format("Msg: ~w~n",[Msg]), loop();
    stop         -> ok
  end.
