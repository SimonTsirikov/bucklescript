console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

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

y;

xpcall(function() do
  error({
    Caml_builtin_exceptions.failure,
    "boo"
  })
end end,function(raw_exn) do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.failure) then do
    y = exn[1];
  end else do
    error(exn)
  end end 
end end)

x;

exit = 0;

xpcall(function() do
  error({
    Caml_builtin_exceptions.failure,
    "boo"
  })
end end,function(raw_exn_1) do
  exn_1 = Caml_js_exceptions.internalToOCamlException(raw_exn_1);
  if (exn_1[0] == Caml_builtin_exceptions.failure) then do
    x = exn_1[1];
  end else do
    error(exn_1)
  end end 
end end)

if (exit == 1) then do
  console.log("ok");
  x = undefined;
end
 end 

eq("File \"gpr_2316_test.ml\", line 20, characters 5-12", y, "boo");

eq("File \"gpr_2316_test.ml\", line 21, characters 5-12", x, "boo");

Mt.from_pair_suites("Gpr_2316_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.y = y;
exports.x = x;
--[[ y Not a pure module ]]
