-module(frequency).
-export([start/0, stop/0, allocate/0, deallocate/1]).
-export([init/0]).

start() ->
  register(frequency, spawn(frequency, init, [])).

init() ->
  Frequencies = {get_frequencies(), []},
  loop(Frequencies).

get_frequencies() -> [10,11,12,13,14,15].

stop()           -> call(stop).
allocate()       -> call(allocate).
deallocate(Freq) -> call({deallocate, Freq}).

call(Message) ->
  frequency ! {request, self(), Message},
  receive
    {reply, Reply} -> Reply
  end.

loop(Frequencies) ->
  {_Free, Allocated} = Frequencies,
  receive
    {request, Pid, allocate} ->
      {NewFrequencies, Reply} = allocate(Frequencies, Pid),
      reply(Pid, Reply),
      loop(NewFrequencies);
    {request, Pid , {deallocate, Freq}} ->
      {NewFrequencies, Reply} = deallocate(Frequencies, Freq, Pid),
      reply(Pid, Reply),
      loop(NewFrequencies);
    {request, Pid, stop} when length(Allocated) =:= 0 ->
      reply(Pid, ok);
    {request, Pid, stop} ->
      reply(Pid, allocated),
      loop(Frequencies)
  end.

reply(Pid, Reply) ->
  Pid ! {reply, Reply}.

allocate({[], Allocated}, _Pid) ->
  {{[], Allocated}, {error, no_frequency}};
allocate({[Freq|Free], Allocated}, Pid) ->
  AllocatedByPid = keyselect(Pid, 2, Allocated),
  % io:format("~w~n", [AllocatedByPid]),
  case length(AllocatedByPid) =< 2 of
    true ->
      {{Free, [{Freq, Pid}|Allocated]}, {ok, Freq}};
    false ->
      {{Free, Allocated}, {error, limit_to_over_3}}
  end.

% 条件に当てはまるタプルリストを返す
keyselect(Key, N, TupleList) ->
  keyselect_acc(Key, N, TupleList, []).
keyselect_acc(Key, N, TupleList, Acc) ->
  case Result = lists:keyfind(Key, N, TupleList) of
    false -> Acc;
    _ -> keyselect_acc(Key, N, lists:keydelete(Key, N, TupleList), [Result | Acc])
  end.

deallocate({Free, Allocated}, Freq, Pid) ->
  case {Freq, Pid} =:= lists:keyfind(Freq, 1, Allocated) of
    true ->
      NewAllocated=lists:keydelete(Freq, 1, Allocated),
      {{[Freq|Free],  NewAllocated}, ok};
    false ->
      {{Free, Allocated}, {error, frequency_is_not_found}}
  end.
% こんなカンジでしたかったけどコンパイルできない…。
%deallocate({Free, Allocated}, Freq, Pid) when {Freq, Pid} =:= lists:keyfind(Freq, 1, Allocated) ->
%  NewAllocated=lists:keydelete(Freq, 1, Allocated),
%  {{[Freq|Free],  NewAllocated}, ok};
%deallocate({Free, Allocated}, _Freq, _Pid) ->
%  {{Free, Allocated}, {error, no_frequency}}.
