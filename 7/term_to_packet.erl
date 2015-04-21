-module(term_to_packet).
-export([term_to_packet/1]).

term_to_packet(Term) ->
    A = term_to_binary(Term),
    Size = 8 * (byte_size(A) - 4),
    <<First:32,Body:Size>> = A,
    <<First>>.
    %<<Body:40>>.
    
