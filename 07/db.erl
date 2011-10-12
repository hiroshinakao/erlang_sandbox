-module(db).
-export([new/0, destroy/1]).
-export([write/3, delete/2, read/2, match/2]).

-record(data, {key, data}).

new() -> [].
destroy(_Db) -> ok.

write(Key, Element, Db) -> [#data{key=Key, data=Element} | Db].

delete(_Key, []) -> [];
delete(Key, [#data{key=Key}|Tail]) -> delete(Key, Tail);
delete(Key, [Head|Tail]) -> [Head | delete(Key, Tail)].

read(_Key, []) -> {error, instance};
read(Key, [#data{key=Key,data=E}|_Tail]) -> {ok, E};
read(Key, [_Head|Tail]) -> read(Key, Tail).

match(_Element, []) -> [];
match(Element, [#data{key=K,data=Element}|Tail]) -> [K | match(Element, Tail)];
match(Element, [_Head|Tail]) -> match(Element, Tail).
