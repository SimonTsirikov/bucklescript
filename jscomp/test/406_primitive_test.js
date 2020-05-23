'use strict';

var Mt = require("./mt.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

eq("File \"406_primitive_test.ml\", line 18, characters 6-13", 32, 32);

var backend_type = --[ Other ]--["BS"];

eq("File \"406_primitive_test.ml\", line 29, characters 6-13", backend_type, --[ Other ]--["BS"]);

function f(param) do
  var A = Caml_exceptions.create("A");
  try do
    for(var i = 0; i <= 200; ++i)do
      if (i == 10) do
        throw [
              A,
              0
            ];
      end
      
    end
    return --[ () ]--0;
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == A) do
      return --[ () ]--0;
    end else do
      throw exn;
    end
  end
end

Mt.from_pair_suites("406_primitive_test", suites.contents);

var v = 32;

var max_array_length = 2147483647;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.backend_type = backend_type;
exports.max_array_length = max_array_length;
exports.f = f;
--[  Not a pure module ]--
