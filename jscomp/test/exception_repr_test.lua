console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Format = require "../../lib/js/format";
Printexc = require "../../lib/js/printexc";
Exception_def = require "./exception_def";
Caml_exceptions = require "../../lib/js/caml_exceptions";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

Hi = Caml_exceptions.create("Exception_repr_test.Hi");

Hello = Caml_exceptions.create("Exception_repr_test.Hello");

A = Caml_exceptions.create("Exception_repr_test.A");

Printexc.register_printer((function(param) do
        if (param == Hi) then do
          return "hey";
        end else if (param[0] == A) then do
          return Curry._1(Format.asprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "A(",
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ ")" ]]41,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            }),
                          "A(%d)"
                        }), param[1]);
        end else do
          return ;
        end end  end 
      end end));

eq("File \"exception_repr_test.ml\", line 24, characters 7-14", "hey", Printexc.to_string(Hi));

eq("File \"exception_repr_test.ml\", line 25, characters 7-14", "A(1)", Printexc.to_string({
          A,
          1
        }));

eq("File \"exception_repr_test.ml\", line 26, characters 7-14", "Exception_repr_test.Hello", Printexc.to_string(Hello));

eq("File \"exception_repr_test.ml\", line 27, characters 7-14", "A", Printexc.to_string({
          Exception_def.A,
          3
        }));

Mt.from_pair_suites("Exception_repr_test", suites.contents);

AAA = Exception_def.A;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.Hi = Hi;
exports.Hello = Hello;
exports.A = A;
exports.AAA = AAA;
--[[  Not a pure module ]]