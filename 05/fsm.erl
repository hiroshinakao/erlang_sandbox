-module(fsm).
-export([idle/0,ringing/1, dial/0, connected/1]).

idle() ->
  receive
    {Number, incoming} ->
      start_ringing(),
      ringing(Number);
    off_hook ->
      start_tone(),
      dial()
  end.

ringing(Number) ->
  receive
    {Number, other_on_hook} ->
      stop_ringing(),
      idle();
    {Number, off_hook} ->
      stop_ringing(),
      connected(Number)
  end.

dial() ->
  receive
    on_hook ->
      stop_dial(),
      idle()
  end.

connected(Number) ->
  receive
    {Number, on_hook} ->
      disconnect(),
      idle()
  end.

start_ringing() -> ok.
start_tone()    -> ok.
stop_ringing()  -> ok.

stop_dial()     -> ok.
disconnect()    -> ok.
