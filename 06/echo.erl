-module(echo).
-export([start/0, print/1, stop/0, loop/0]).

start()     -> register(echo, spawn_link(?MODULE, loop, [])), ok.

print(Term) -> echo ! {print, Term}, ok.
stop()      -> exit(normal).

loop() ->
  receive
    {print, Term} -> io:format("Term: ~w~n",[Term]), loop()
  end.
