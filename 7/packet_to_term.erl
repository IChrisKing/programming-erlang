-module(packet_to_term).
-export([packet_to_term/1]).

packet_to_term(Packet) ->
    Size = 8 * (byte_size(Packet) - 4),
    <<First:32,Body:Size>> = Packet,
    %<<Body:40>>.
    Term = binary_to_term(Packet),
    Term.
