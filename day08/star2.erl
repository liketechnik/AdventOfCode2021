-mode(compile).

read_file(File) -> 
    read_file(File, file:read_line(File), []). 
read_file(File, {ok, NextLine}, Lines) ->
    read_file(File, file:read_line(File), Lines ++ [string:chomp(NextLine)]);
read_file(_, _, Lines) -> 
    Lines.

parse_known_digit(String) ->
    Length = string:length(String),
    if
        Length == 2 ->
            {true, {1, sets:from_list(String)}};
        Length == 4 ->
            {true, {4, sets:from_list(String)}};
        Length == 3 ->
            {true, {7, sets:from_list(String)}};
        Length == 7 ->
            {true, {8, sets:from_list(String)}};
        true -> 
            false
    end.

split_inputs_outputs(Line) ->
    [Inputs | Outputs] = string:lexemes(Line, "|"),
    { string:lexemes(Inputs, " "), string:lexemes(Outputs, " ") }.

extract_single(LineIn, Both) ->
    {value, S1AndOthers} = lists:search(fun (Value) ->
                                                sets:size(sets:intersection(Both, sets:from_list(Value))) == 1 end, LineIn),
    S1 = lists:last(sets:to_list(sets:intersection(sets:from_list(S1AndOthers), Both))),
    {value, S2} = lists:search(fun (Value) -> 
                                       false == (Value == S1) end, sets:to_list(Both)),
    {S1, S2}.

extract_single(LineIn, Both, Length) ->
    {value, S1AndOthers} = lists:search(fun (Value) ->
                                                sets:size(sets:intersection(Both, sets:from_list(Value))) == 1 andalso length(Value) == Length end, LineIn),
    S1 = lists:last(sets:to_list(sets:intersection(sets:from_list(S1AndOthers), Both))),
    {value, S2} = lists:search(fun (Value) -> 
                                       false == (Value == S1) end, sets:to_list(Both)),
    {S1, S2}.

output_value({LineIn, LineOut}) ->
    KnownDigits = dict:from_list(lists:filtermap(fun parse_known_digit/1, LineIn)),
    Z = sets:subtract(dict:fetch(7, KnownDigits), dict:fetch(1, KnownDigits)),
    W = sets:subtract(sets:subtract(dict:fetch(8, KnownDigits), Z), dict:fetch(4, KnownDigits)),
    X = sets:intersection(dict:fetch(7, KnownDigits), dict:fetch(4, KnownDigits)),
    Y = sets:subtract(sets:subtract(sets:subtract(dict:fetch(8, KnownDigits), X), W), Z),

    {X1, X2} = extract_single(LineIn, X, 6),
    {W2, W1} = extract_single(LineIn, W),
    {Y1, Y2} = extract_single(LineIn, Y, 6),

    % io:fwrite("z=~p;w=~p;x=~p;y~p;x1=~c;x2=~c;w1=~c;w2=~c;y1=~c;y2=~c~n", [sets:to_list(Z), sets:to_list(W), sets:to_list(X), sets:to_list(Y), X1, X2, W1, W2, Y1, Y2]),

    Digits = dict:from_list([{lists:sort(sets:to_list(Z) ++ [Y1] ++ [W1] ++ [W2] ++ [X1] ++ [X2]), 0},
                             {lists:sort([X1] ++ [X2]), 1},
                             {lists:sort(sets:to_list(Z) ++ [X2] ++ [Y2] ++ [W1] ++ [W2]), 2},
                             {lists:sort(sets:to_list(Z) ++ [X2] ++ [Y2] ++ [X1] ++ [W2]), 3},
                             {lists:sort([Y1] ++ [Y2] ++ [X2] ++ [X1]), 4},
                             {lists:sort(sets:to_list(Z) ++ [Y1] ++ [Y2] ++ [X1] ++ [W2]), 5},
                             {lists:sort(sets:to_list(Z) ++ [Y1] ++ [Y2] ++ [W1] ++ [W2] ++ [X1]), 6},
                             {lists:sort(sets:to_list(Z) ++ [X2] ++ [X1]), 7},
                             {lists:sort(sets:to_list(Z) ++ [X1] ++ [X2] ++ [Y1] ++ [Y2] ++ [W1] ++ [W2]), 8},
                             {lists:sort(sets:to_list(Z) ++ [Y1] ++ [X2] ++ [Y2] ++ [X1] ++ [W2]), 9}
                            ]),

    Highest = dict:fetch(lists:sort(lists:nth(1, LineOut)), Digits),
    Higher = dict:fetch(lists:sort(lists:nth(2, LineOut)), Digits),
    Lower = dict:fetch(lists:sort(lists:nth(3, LineOut)), Digits),
    Lowest = dict:fetch(lists:sort(lists:nth(4, LineOut)), Digits),
    Result = Highest * 1000 + Higher * 100 + Lower * 10 + Lowest,
    % io:fwrite("Result: ~p~n", [Result]),
    Result.

main([Filename]) ->
    % let's ignore results for now... the underscore contains a possible error...
    {_, File} = file:open(Filename, [read]),
    Lines = read_file(File),
    InputsOutputs = lists:map(fun split_inputs_outputs/1, Lines),
    Result = lists:sum(lists:map(fun output_value/1, InputsOutputs)),
    io:fwrite("Result: ~p~n", [Result]);
main(_) -> 
    usage().

usage() ->
    io:format("usage: <input file>"),
    halt(1).
