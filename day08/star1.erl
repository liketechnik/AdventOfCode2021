-mode(compile).

read_file(File) -> 
    read_file(File, file:read_line(File), []). 
read_file(File, {ok, NextLine}, Lines) ->
    read_file(File, file:read_line(File), Lines ++ [string:chomp(NextLine)]);
read_file(_, _, Lines) -> 
    Lines.

parse_digit(String) ->
    Length = string:length(String),
    if
        Length == 2 ->
            {true, 1};
        Length == 4 ->
            {true, 4};
        Length == 3 ->
            {true, 7};
        Length == 7 ->
            {true, 8};
        true -> 
            false
    end.

split_inputs_outputs(Line) ->
    [Inputs | Outputs] = string:lexemes(Line, "|"),
    { string:lexemes(Inputs, " "), string:lexemes(Outputs, " ") }.

flatten([]) -> 
    [];
flatten([Current | Rest]) ->
    Current ++ flatten(Rest);
flatten(Elem) ->
    [Elem].

main([Filename]) ->
    % let's ignore results for now... the underscore contains a possible error...
    {_, File} = file:open(Filename, [read]),
    Lines = read_file(File),
    InputsOutputs = lists:map(fun split_inputs_outputs/1, Lines),
    Outputs = flatten(lists:map(fun({_, Outputs}) -> 
                                Outputs end, InputsOutputs)),
    Digits = lists:filtermap(fun parse_digit/1, Outputs),
    io:fwrite("File content: '~p'~n", [Digits]),
    io:fwrite("Result: ~p~n", [length(Digits)]);
main(_) -> 
    usage().

usage() ->
    io:format("usage: <input file>"),
    halt(1).
