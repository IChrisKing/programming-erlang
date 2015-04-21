-module(7-1).
-export([fanzhuan/1]).

fanzhuan(A) ->
    B = binary_to_list(A).
    C = lists:reserve(B).
    D = list_to_binary(C).
    D.
