-module(renew).
-export([renew/1,file_time/1]).
-include_lib("kernel/include/file.hrl").

renew(FileName) -> 
    ErlTime = file_time(FileName ++ ".erl"),
%    io:format("erl time is ~p~n",[ErlTime]),
    BeamTime = file_time(FileName ++ ".beam"),
%    io:format("beam time is ~p~n",[BeamTime]),
    
    {Day,{_,_,_}} = calendar:time_difference(ErlTime,BeamTime),
    case Day < 0 of
        true ->
            io:format("renew it~n"),
            CMD = "erlc " ++ FileName ++ ".erl",
%            io:format("cmd is ~p~n",[CMD]),
            os:cmd(CMD);
        _ ->
            io:format("not need renew~n")
    end.
    
file_time(FullName) ->
    case file:read_file_info(FullName) of
        {ok,Facts} ->
            Facts#file_info.atime;
        _ ->
            error
    end.
