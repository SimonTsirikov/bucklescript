--[['use strict';]]

Mt = require "./mt.lua";
Caml_exceptions = require "../../lib/js/caml_exceptions.lua";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

eq("File \"406_primitive_test.ml\", line 18, characters 6-13", 32, 32);

backend_type = --[[ Other ]]{"BS"};

eq("File \"406_primitive_test.ml\", line 29, characters 6-13", backend_type, --[[ Other ]]{"BS"});

function f(param) do
  A = Caml_exceptions.create("A");
  try do
    for i = 0 , 200 , 1 do
      if (i == 10) then do
        throw {
              A,
              0
            };
      end
       end 
    end
    return --[[ () ]]0;
  end
  catch (raw_exn)do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == A) then do
      return --[[ () ]]0;
    end else do
      throw exn;
    end end 
  end
end end

Mt.from_pair_suites("406_primitive_test", suites.contents);

v = 32;

max_array_length = 2147483647;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.backend_type = backend_type;
exports.max_array_length = max_array_length;
exports.f = f;
--[[  Not a pure module ]]
