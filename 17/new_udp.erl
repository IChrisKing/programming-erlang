%%%-------------------------------------------------------------------
%%% @author jinwh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 五月 2015 下午3:22
%%%-------------------------------------------------------------------
-module(new_udp).
-author("jinwh").

%% API
-compile(export_all).

start_server() ->
  spawn(fun() -> server(4000) end).

%%服务器
server(Port) ->
  {ok,Socket} = gen_udp:open(Port,[binary]),
  io:format("server opened socket:~p~n",[Socket]),
  loop(Socket).

loop(Socket) ->
  receive
    {udp,Socket,Host,Port,Bin} = Msg ->
      io:format("server receiveed:~p~n",[Msg]),
      {Mod,Func,Args} = binary_to_term(Bin),
      io:format("server (unpacked) ~p~n",[{Mod,Func,Args}]),
      Reply = apply(Mod,Func,Args),
      io:format("Server replying = ~p~n",[Reply]),
      gen_udp:send(Socket,Host,Port,term_to_binary(Reply)),
      loop(Socket)
  end.

%Client
client({Mod,Func,Args}) ->
  {ok,Socket} = gen_udp:open(0,[binary]),
  io:format("client opened socket=~p~n",[Socket]),
  ok = gen_udp:send(Socket,"localhost",4000,term_to_binary({Mod,Func,Args})),
  Value = receive
            {udp,Socket,_,_,Bin} = Msg ->
              io:format("client received:~p~n",[Msg]),
              binary_to_term(Bin)
          after 2000 ->
            0
          end,
  gen_udp:close(Socket),
  Value.
