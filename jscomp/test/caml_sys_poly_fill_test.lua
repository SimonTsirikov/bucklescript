console = {log = print};

Mt = require "./mt";
Sys = require "../../lib/js/sys";
Block = require "../../lib/js/block";
Caml_sys = require "../../lib/js/caml_sys";
Node_process = require "../../lib/js/node_process";
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

Node_process.putEnvVar("Caml_sys_poly_fill_test", "X");

v = Caml_sys.caml_sys_getenv("Caml_sys_poly_fill_test");

eq("File \"caml_sys_poly_fill_test.ml\", line 11, characters 5-12", "X", (Node_process.deleteEnvVar("Caml_sys_poly_fill_test"), v));

Node_process.putEnvVar("Caml_sys_poly_fill_test", "Y");

v_1 = Caml_sys.caml_sys_getenv("Caml_sys_poly_fill_test");

eq("File \"caml_sys_poly_fill_test.ml\", line 17, characters 5-12", "Y", (Node_process.deleteEnvVar("Caml_sys_poly_fill_test"), v_1));

Node_process.deleteEnvVar("Caml_sys_poly_fill_test");

tmp;

xpcall(function() do
  tmp = Caml_sys.caml_sys_getenv("Caml_sys_poly_fill_test");
end end,function(exn) do
  if (exn == Caml_builtin_exceptions.not_found) then do
    tmp = "Z";
  end else do
    error(exn)
  end end 
end end)

eq("File \"caml_sys_poly_fill_test.ml\", line 23, characters 5-12", "Z", tmp);

console.log(--[[ tuple ]]{
      Caml_sys.caml_sys_getcwd(--[[ () ]]0),
      Caml_sys.caml_sys_time(--[[ () ]]0),
      Sys.argv,
      Sys.executable_name
    });

Mt.from_pair_suites("Caml_sys_poly_fill_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
