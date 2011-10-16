-module(binary_tree).
-export([sum/1]).

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
%     left =#binary_tree{value=3},
%     right=#binary_tree{value=4}
%   },
%   left=#binary_tree{value=3}
% }
