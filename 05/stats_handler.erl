-module(stats_handler).

-export([init/1, terminate/1, handle_event/2]).

init(Stats) -> Stats.

terminate(Stats) -> {stats, Stats}.

handle_event({Type, _Id, Description}, Stats) ->
  case lists:keyfind({Type, Description}, 1, Stats) of
    {{_T,_D}, Count} ->
      NewStats =  lists:keydelete({Type, Description}, 1, Stats),
      [{{Type, Description}, Count+1} | NewStats];
    _ ->
      [{{Type, Description}, 1} | Stats]
  end;
handle_event(_Event, Stats) -> Stats.
