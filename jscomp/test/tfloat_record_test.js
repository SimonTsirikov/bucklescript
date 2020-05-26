'use strict';

Mt = require("./mt.js");
$$Array = require("../../lib/js/array.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
$$Buffer = require("../../lib/js/buffer.js");
Format = require("../../lib/js/format.js");
Mt_global = require("./mt_global.js");
Pervasives = require("../../lib/js/pervasives.js");
Float_array = require("./float_array.js");

buf = $$Buffer.create(50);

fmt = Format.formatter_of_buffer(buf);

function print_float(f) do
  return Curry._1(Format.fprintf(fmt, --[ Format ]--[
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ]),
                  "%s"
                ]), Pervasives.string_of_float(f));
end

function print_newline(param) do
  return Format.fprintf(fmt, --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ "\n" ]--10,
                  --[ End_of_format ]--0
                ]),
              "\n"
            ]);
end

s = do
  f: 1.0
end;

print_float(1.0);

print_newline(--[ () ]--0);

b = Float_array.small_float_array(12);

c = Float_array.longer_float_array(34);

function print_array(a) do
  $$Array.iter((function (f) do
          print_float(f);
          return print_newline(--[ () ]--0);
        end), a);
  return print_newline(--[ () ]--0);
end

print_array(b[0]);

print_array(c[0]);

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(f, a, b) do
  return Mt_global.collect_eq(test_id, suites, f, a, b);
end

eq("File \"tfloat_record_test.ml\", line 43, characters 5-12", $$Buffer.contents(buf), "1.\n1.\n2.\n3.\n\n1.\n2.\n3.\n4.\n5.\n6.\n7.\n8.\n9.\n0.\n1.\n2.\n3.\n4.\n5.\n6.\n7.\n8.\n9.\n0.\n1.\n2.\n3.\n4.\n5.\n6.\n7.\n8.\n9.\n0.\n1.\n2.\n3.\n4.\n5.\n6.\n7.\n8.\n9.\n0.\n\n");

Mt.from_pair_suites("Tfloat_record_test", suites.contents);

exports.buf = buf;
exports.fmt = fmt;
exports.print_float = print_float;
exports.print_newline = print_newline;
exports.s = s;
exports.b = b;
exports.c = c;
exports.print_array = print_array;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[ buf Not a pure module ]--
