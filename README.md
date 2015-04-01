# erl_csv_generator

[![Build Status](https://travis-ci.org/manastech/erl_csv_generator.svg?branch=master)](https://travis-ci.org/manastech/erl_csv_generator)

This erlang module allows you to generate CSV files in an easy way.

## Installation

In your `rebar.config`:

```erlang
{deps, [
  {erl_csv_generator, ".*", {git, "https://github.com/manastech/erl_csv_generator.git"}}
]}.
```

## Usage

This module provides some functions to write CSV data to an `IoDevice`. An `IoDevice` is what you get
by, for example, calling [file:open](http://www.erlang.org/doc/man/file.html#open-2).

The main interface to the CSV generation is `csv_gen:row`:

```erlang
{ok, File} = file:open("test.csv", [write]),
csv_gen:row(File, ["Product", "Quantity"]),
csv_gen:row(File, ["Coffee", 10]),
csv_gen:row(File, ["Tea \"Cha\" extra strong", 20]),
file:close(File).
```

The above code will put this in `test.csv`:

```
Product,Quantity
Coffee,10
"Tea ""Cha"" extra strong",20
```

This library will make sure to put quotes when appropriate (when there's a double quote, comma or newline) and to escape double quotes.

The valid values for a row are integers, lists (strings) and binaries. You should convert other types to binary before invoking `csv_gen:row`.

### Generating compressed files

Erlang's `file:open` accepts a compressed option:

```erlang
{ok, File} = file:open("test.csv.zip", [write, compressed]),
csv_gen:row(File, ["Compressed", "File"]),
file:close(File).
```

### Lower-level API

You can use `csv_gen:field`, `csv_gen:comma` and `csv_gen:newline` to generate a CSV cell by cell:

```erlang
{ok, File} = file:open("test.csv", [write]),

csv_gen:field(File, "Product"),
csv_gen:comma(File),
csv_gen:field(File, "Quantity"),
csv_gen:newline()

csv_gen:field(File, "Coffee"),
csv_gen:comma(File),
csv_gen:field(File, 10),

file:close(File).
```

## Contributing

1. Fork it ( https://github.com/manastech/erl_csv_generator/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
