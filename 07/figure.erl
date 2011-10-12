-module(figure).
-export([circumference/1, area/1]).
-export([circle/1]).

%% 円
-record(circle, {radius=0}).
circle(Radius)                        -> #circle{radius=Radius}.
circumference(#circle{radius=Radius}) -> Radius * 2 * math:pi().
area(#circle{radius=Radius})          -> Radius * Radius * math:pi().
