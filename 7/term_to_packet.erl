-module(term_to_packet).
-export([term_to_packet/1]).

term_to_packet(Term) ->
    A = term_to_binary(Term),
    {N,T} = split_binary(A,4),
    Packet = {N,T},
    Packet.
    
