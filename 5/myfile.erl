-module(myfile).
-export([read/1]).


%read(File) ->
%    case file:read_file(File) of
%        {ok,A} ->
%            A;
%        {error,B} ->
%            {B,"error when open file"}
%    end.

read(File) ->
    try 
        file:read_file(File)
    catch
        error:X ->
            {X,"error when open"}
    end.
