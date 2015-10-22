-module(csv_gen_tests).
-include_lib("eunit/include/eunit.hrl").

write_csv_test() ->
  {ok, File} = file:open("temp.csv", [write]),
  csv_gen:row(File, ["Header 1", "Header 2"]),
  csv_gen:row(File, [1, "hello", <<"good bye">>, "with \" quote","with \n newline", "with , comma", 2.0, "and the atom", hydrogen]),
  file:close(File),

  {ok, Contents} = file:read_file("temp.csv"),
  io:format("wrote ~p~n",[Contents]),
  ?assertEqual(<<"Header 1,Header 2\n1,hello,good bye,\"with \"\" quote\",\"with \n newline\",\"with , comma\",2.000000,and the atom,hydrogen\n">>, Contents).
