-module(fanzhuan).
-export([fanzhuan/1]).

fanzhuan(A) ->
    B = binary_to_list(A),
    C = lists:reverse(B),
    D = list_to_binary(C),
    D.
