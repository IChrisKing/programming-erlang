%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 五月 2015 16:23
%%%-------------------------------------------------------------------
-module(socket_examples).
-author("Administrator").

%% API
-export([nano_get_url/0]).
-import(lists,[reverse/1]).

nano_get_url() ->
  nano_get_url("www.baidu.com").

nano_get_url(Host) ->
  {ok,Socket} = gen_tcp:connect(Host,80,[binary,{packet,0}]),
  ok = gen_tcp:send(Socket,"GET / HTTP/1.0\r\n\r\n"),
  receive_data(Socket,[]).

receive_data(Socket,SoFar) ->
  receive
    {tcp,Socket,Bin} ->
      receive_data(Socket,[Bin|SoFar]);
    {tcp_closed,Socket} ->
      list_to_binary(reverse(SoFar))
  end.
