console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

Str = Caml_exceptions.create("Extensible_variant_test.Str");

Int = Caml_exceptions.create("Extensible_variant_test.N.Int");

N = do
  Int: Int
end;

Int_1 = Caml_exceptions.create("Extensible_variant_test.Int");

function to_int(x) do
  if (x[0] == Str) then do
    return -1;
  end else if (x[0] == Int) then do
    return x[1];
  end else if (x[0] == Int_1) then do
    return x[2];
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "extensible_variant_test.ml",
        16,
        9
      }
    })
  end end  end  end 
end end

suites_000 = --[[ tuple ]]{
  "test_int",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                3,
                to_int({
                      Int,
                      3,
                      0
                    })
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "test_int2",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  0,
                  to_int({
                        Int_1,
                        3,
                        0
                      })
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "test_string",
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    -1,
                    to_int({
                          Str,
                          "x"
                        })
                  });
        end end)
    },
    --[[ [] ]]0
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Extensible_variant_test", suites);

exports = {}
exports.Str = Str;
exports.N = N;
exports.Int = Int_1;
exports.to_int = to_int;
exports.suites = suites;
--[[  Not a pure module ]]
