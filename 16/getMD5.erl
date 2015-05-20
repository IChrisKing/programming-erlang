-module(getMD5).
-export([getMD5/1]).

getMD5(FileName) ->
    case file:read_file(FileName) of
        {ok,DATA} ->
            erlang:md5(DATA);
        {error,_} ->
            io:format("failed when read file ~p~n",[FileName])
    end.
