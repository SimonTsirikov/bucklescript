--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

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
      (function (param) do
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

y;

try do
  throw {
        Caml_builtin_exceptions.failure,
        "boo"
      };
end
catch (raw_exn)do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.failure) then do
    y = exn[1];
  end else do
    throw exn;
  end end 
end

x;

exit = 0;

try do
  throw {
        Caml_builtin_exceptions.failure,
        "boo"
      };
end
catch (raw_exn$1)do
  exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
  if (exn$1[0] == Caml_builtin_exceptions.failure) then do
    x = exn$1[1];
  end else do
    throw exn$1;
  end end 
end

if (exit == 1) then do
  console.log("ok");
  x = undefined;
end
 end 

eq("File \"gpr_2316_test.ml\", line 20, characters 5-12", y, "boo");

eq("File \"gpr_2316_test.ml\", line 21, characters 5-12", x, "boo");

Mt.from_pair_suites("Gpr_2316_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.y = y;
exports.x = x;
--[[ y Not a pure module ]]
