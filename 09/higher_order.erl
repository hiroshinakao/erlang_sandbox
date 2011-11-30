-module(higher_order).
-export([print/1, le/2]).

print(N) when N > 0 ->
 PRINT=fun(X)->io:format("~p~n",[X]) end,
 lists:map(PRINT, lists:seq(1,N)), ok;
print(N) -> {error, N}.

le(List, N) ->
  LE=fun(X)-> X =< N end,
  lists:filter(LE, List).

