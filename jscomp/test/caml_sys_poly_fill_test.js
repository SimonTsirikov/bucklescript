'use strict';

var Mt = require("./mt.js");
var Sys = require("../../lib/js/sys.js");
var Block = require("../../lib/js/block.js");
var Caml_sys = require("../../lib/js/caml_sys.js");
var Node_process = require("../../lib/js/node_process.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

Node_process.putEnvVar("Caml_sys_poly_fill_test", "X");

var v = Caml_sys.caml_sys_getenv("Caml_sys_poly_fill_test");

eq("File \"caml_sys_poly_fill_test.ml\", line 11, characters 5-12", "X", (Node_process.deleteEnvVar("Caml_sys_poly_fill_test"), v));

Node_process.putEnvVar("Caml_sys_poly_fill_test", "Y");

var v$1 = Caml_sys.caml_sys_getenv("Caml_sys_poly_fill_test");

eq("File \"caml_sys_poly_fill_test.ml\", line 17, characters 5-12", "Y", (Node_process.deleteEnvVar("Caml_sys_poly_fill_test"), v$1));

Node_process.deleteEnvVar("Caml_sys_poly_fill_test");

var tmp;

try do
  tmp = Caml_sys.caml_sys_getenv("Caml_sys_poly_fill_test");
end
catch (exn)do
  if (exn == Caml_builtin_exceptions.not_found) do
    tmp = "Z";
  end else do
    throw exn;
  end
end

eq("File \"caml_sys_poly_fill_test.ml\", line 23, characters 5-12", "Z", tmp);

console.log(--[ tuple ]--[
      Caml_sys.caml_sys_getcwd(--[ () ]--0),
      Caml_sys.caml_sys_time(--[ () ]--0),
      Sys.argv,
      Sys.executable_name
    ]);

Mt.from_pair_suites("Caml_sys_poly_fill_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
