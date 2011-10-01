-module(db).
-export([new/0, destroy/1]).
-export([write/3, delete/2, read/2, match/2]).

new() -> [].
destroy(_Db) -> ok.

write(Key, Element, Db) -> [{Key, Element} | Db].

delete(_Key, []) -> [];
delete(Key, [{K,_E}|Tail]) when Key =:= K -> delete(Key, Tail);
delete(Key, [Head|Tail]) -> [Head | delete(Key, Tail)].

read(_Key, []) -> {error, instance};
read(Key, [{K,E}|_Tail]) when Key =:= K -> {ok, E};
read(Key, [_Head|Tail]) -> read(Key, Tail).

match(_Element, []) -> [];
match(Element, [{K,E}|Tail]) when Element =:= E -> [K | match(Element, Tail)];
match(Element, [_Head|Tail]) -> match(Element, Tail).
