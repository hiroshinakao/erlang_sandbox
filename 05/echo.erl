-module(echo).
-export([start/0, print/1, stop/0, loop/0]).

start() -> register(echo, spawn(echo, loop, [])).

print(Term) -> echo ! {print, Term}.

stop() -> echo ! stop.

loop() ->
  receive
    {print, Msg} ->
      io:format("received : ~w~n",[Msg]),
      loop();
    stop -> true
  end.
