-module(lib_misc).
-export([unconsult/2]).

unconsult(File,L) ->
    {ok,S} = file:open(File,write),
    lists:foreach(fun(X) -> 
        io:format(S,"~p.~n",[X])
        end,L),
    file:close(S).
