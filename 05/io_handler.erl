-module(io_handler).
-export([init/1, terminate/1, handle_event/2]).

init(Count) -> parse_integer(Count).

terminate(Count) -> {count, parse_integer(Count)}.

handle_event({raise_alarm, Id, Alarm}, Count) ->
  print(alarm, Id, Alarm, Count),
  parse_integer(Count)+1;
handle_event({clear_alarm, Id, Alarm}, Count) ->
  print(clear, Id, Alarm, Count),
  parse_integer(Count)+1;
handle_event(Event, Count) ->
  parse_integer(Count).

print(Type, Id, Alarm, Count) ->
  Date = fmt(date()), Time = fmt(time()),
  io:format("#~w,~s,~s,~w,~w,~p~n",
            [parse_integer(Count), Date, Time, Type, Id, Alarm]).

fmt({AInt,BInt,CInt}) ->
  AStr = pad(integer_to_list(AInt)),
  BStr = pad(integer_to_list(BInt)),
  CStr = pad(integer_to_list(CInt)),
  [AStr,$:,BStr,$:,CStr].

pad([M1])  -> [$0,M1];
pad(Other) -> Other.

parse_integer(Count) when is_integer(Count) -> Count;
parse_integer(Count) ->
  io:format("parse integer: ~w to 0~n", [Count]),
  0.
