-module(csv_gen).

-export([newline/1, comma/1, field/2, row/2]).

newline(File) ->
  file:write(File, "\n").

comma(File) ->
  file:write(File, ",").

field(File, Value) when is_binary(Value) ->
  Match = binary:match(Value, [<<",">>, <<"\n">>, <<"\"">>]),
  case Match of
    nomatch ->
      file:write(File, Value);
    _ ->
      file:write(File, "\""),
      file:write(File, binary:replace(Value, <<"\"">>, <<"\"\"">>)),
      file:write(File, "\"")
  end;
field(File, Value) when is_list(Value) ->
  field(File, list_to_binary(Value));
field(File, Value) when is_integer(Value) ->
  file:write(File, integer_to_list(Value));
field(File, Value) when is_atom(Value) ->
  file:write(File, io_lib:write_atom(Value));
field(File, Value) when is_float(Value) ->
  file:write(File, float_to_list(Value)).

row(File, []) ->
  newline(File);
row(File, [Value]) ->
  field(File, Value),
  newline(File);
row(File, [Value | Rest]) ->
  field(File, Value),
  comma(File),
  row(File, Rest).
