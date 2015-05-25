%%%-------------------------------------------------------------------
%%% @author jinwh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 五月 2015 下午3:22
%%%-------------------------------------------------------------------
-module(udp_test).
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
      N = binary_to_term(Bin),
      Fac = fac(N),
      gen_udp:send(Socket,Host,Port,term_to_binary(Fac)),
      loop(Socket)
  end.

fac(0) -> 1;
fac(N) -> N * fac(N-1).

%Client
client(N) ->
  {ok,Socket} = gen_udp:open(0,[binary]),
  io:format("client opened socket=~p~n",[Socket]),
  ok = gen_udp:send(Socket,"localhost",4000,term_to_binary(N)),
  Value = receive
            {udp,Socket,_,_,Bin} = Msg ->
              io:format("client received:~p~n",[Msg]),
              binary_to_term(Bin)
          after 2000 ->
            0
          end,
  gen_udp:close(Socket),
  Value.
