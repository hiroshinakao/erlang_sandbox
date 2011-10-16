-module(binary_tree).
-export([sum/1, max/1]).
-export([is_ordered/1]).
-export([new/0]).

-record(binary_tree, {value=0, left=[], right=[]}).
%          |- 5
%    |- 4 -|
%    |     |- 3
% 3 -|
%    |- 2
%
% #binary_tree{
%   value=3,
%   right=#binary_tree{
%     value=4,
%     right=#binary_tree{value=5},
%     left =#binary_tree{value=3}},
%   left=#binary_tree{value=2}}

new() -> #binary_tree{
    value=3,
    right=#binary_tree{
      value=4,
      right=#binary_tree{value=5},
      left =#binary_tree{value=3}},
    left=#binary_tree{value=2}}.

% sum
sum([]) -> 0;
sum(#binary_tree{value=Value, left=Left, right=Right}) -> Value + sum(Left) + sum(Right).

% max
max([]) -> 0;
max(#binary_tree{value=Value, left=Left, right=Right}) -> lists:max([Value, max(Left), max(Right)]).

% is_ordered
is_ordered([]) -> true;
is_ordered(#binary_tree{value=Value, left=Left, right=Right}) ->
  io:format("val:~w, left:~w, right:~w~n", [Value, value(Left), value(Right)]),
  LeftResult = case is_record(Left, binary_tree) of
    true  -> value(Left) =< Value;
    false -> true
  end,
  RightResult = case is_record(Right, binary_tree) of
    true  -> Value =< value(Right);
    false -> true
  end,
  case LeftResult and RightResult of
    true  -> is_ordered(Left) and is_ordered(Right);
    false -> false
  end.

value([]) -> 0;
value(#binary_tree{value=Value, left=_Left, right=_Right}) -> Value.
