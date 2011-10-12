-module(figure).
-export([circumference/1, area/1, perimeter/1]).
-export([circle/1, rectangle/2, triangle/3]).

%% 円
-record(circle, {radius=0}).
circle(Radius) when Radius > 0 -> #circle{radius=Radius};
circle(_Radius)                -> {error, wrong_arguments}.

%% 長方形
-record(rectangle, {width=0, length=0}).
rectangle(Width, Length) when Width > 0, Length > 0 -> #rectangle{width=Width, length=Length};
rectangle(_Width, _Length)                          -> {error, wrong_arguments}.

%% 三角形
-record(triangle, {side_a=0, side_b=0, side_c=0}).
triangle(SideA, SideB, SideC) when SideA > 0, SideB > 0, SideC >0 -> #triangle{side_a=SideA, side_b=SideB, side_c=SideC};
triangle(_SideA, _SideB, _SideC)                                  -> {error, wrong_arguments}.

%% 外周
circumference(Circle)                                          -> perimeter(Circle).
perimeter(#circle{radius=Radius})                              -> Radius * 2 * math:pi();
perimeter(#rectangle{width=Width, length=Length})              -> (Width + Length) * 2;
perimeter(#triangle{side_a=SideA, side_b=SideB, side_c=SideC}) -> SideA + SideB + SideC.

%% 面積
area(#circle{radius=Radius})                               -> Radius * Radius * math:pi();
area(#rectangle{width=Width, length=Length})               -> Width * Length;
%%% ヘロンの公式
%%% http://ja.wikipedia.org/wiki/%E3%83%98%E3%83%AD%E3%83%B3%E3%81%AE%E5%85%AC%E5%BC%8F
area(#triangle{side_a=SideA, side_b=SideB, side_c=SideC}) ->
  S = (SideA + SideB + SideC)/2,
  math:sqrt(S * (S-SideA) * (S-SideB) * (S-SideC)).