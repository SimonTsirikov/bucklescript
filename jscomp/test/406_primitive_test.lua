__console = {log = print};

Mt = require "..mt";
Caml_exceptions = require "......lib.js.caml_exceptions";
Caml_js_exceptions = require "......lib.js.caml_js_exceptions";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

eq("File \"406_primitive_test.ml\", line 18, characters 6-13", 32, 32);

backend_type = --[[ Other ]]{"BS"};

eq("File \"406_primitive_test.ml\", line 29, characters 6-13", backend_type, --[[ Other ]]{"BS"});

function f(param) do
  A = Caml_exceptions.create("A");
  xpcall(function() do
    for i = 0 , 200 , 1 do
      if (i == 10) then do
        error({
          A,
          0
        })
      end
       end 
    end
    return --[[ () ]]0;
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[1] == A) then do
      return --[[ () ]]0;
    end else do
      error(exn)
    end end 
  end end)
end end

Mt.from_pair_suites("406_primitive_test", suites.contents);

v = 32;

max_array_length = 2147483647;

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.backend_type = backend_type;
exports.max_array_length = max_array_length;
exports.f = f;
return exports;
--[[  Not a pure module ]]
