-module(figure).
-export([circumference/1, area/1, perimeter/1]).
-export([circle/1, rectangle/2]).

%% 円
-record(circle, {radius=0}).
circle(Radius) when Radius > 0 -> #circle{radius=Radius};
circle(_Radius)                -> {error, wrong_arguments}.

%% 長方形
-record(rectangle, {width=0, length=0}).
rectangle(Width, Length) when Width > 0, Length > 0 -> #rectangle{width=Width, length=Length};
rectangle(_Width, _Length)                          -> {error, wrong_arguments}.

%% 外周
circumference(Circle)                             -> perimeter(Circle).
perimeter(#circle{radius=Radius})                 -> Radius * 2 * math:pi();
perimeter(#rectangle{width=Width, length=Length}) -> (Width + Length) * 2.

%% 面積
area(#circle{radius=Radius})                 -> Radius * Radius * math:pi();
area(#rectangle{width=Width, length=Length}) -> Width * Length.
