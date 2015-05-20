-module(scavenge_urls).
-export([urls2htmlFile/2,bin2urls/1]).
-import(lists,[reverse/1,reverse/2,map/2]).

urls2htmlFile(Urls,File) ->
    file:wrie_file(File,urls2htmlFile).
    
bin2urls(Bin) ->    gather_urls(binary_to_list(Bin),[]).
    
urls2htmlFile ->    [h1("Urls"),make_list(Urls)].

h1(Title) ->    ["<li>",Title,"</h1>\n".

make_list(L) ->
    ["<ul>\n",
    map(fun(I) -> ["<li>",I,"</li>\n"] end, L),
    "</ul>\n"].
