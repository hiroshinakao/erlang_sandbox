-module(binary_tree).
-export([sum/1, max/1]).
-export([new/0]).

-record(binary_tree, {value=0, left=[], right=[]}).
%          |- 4
%    |- 2 -|
%    |     |- 5
% 1 -|
%    |- 3
%
% #binary_tree{
%   value=1,
%   right=#binary_tree{
%     value=2,
%     left =#binary_tree{value=4},
%     right=#binary_tree{value=5}},
%   left=#binary_tree{value=3}}

new() -> #binary_tree{
    value=1,
    right=#binary_tree{
      value=2,
      left =#binary_tree{value=4},
      right=#binary_tree{value=5}},
    left=#binary_tree{value=3}}.

% sum
sum([]) -> 0;
sum(#binary_tree{value=Value, left=Left, right=Right}) -> Value + sum(Left) + sum(Right).

% max
max([]) -> 0;
max(#binary_tree{value=Value, left=Left, right=Right}) -> lists:max([Value, max(Left), max(Right)]).
