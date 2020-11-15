__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Caml_obj = require "......lib.js.caml_obj";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
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

called = {
  contents = 0
};

function g(param) do
  v = { };
  next = function(i, b) do
    called.contents = called.contents + 1 | 0;
    if (b) then do
      Curry._2(v.contents, i, false);
    end
     end 
    return i + 1 | 0;
  end end;
  Caml_obj.caml_update_dummy(v, {
        contents = next
      });
  __console.log(__String(next(0, true)));
  return --[[ () ]]0;
end end

g(--[[ () ]]0);

x = {};

y = {};

Caml_obj.caml_update_dummy(x, --[[ :: ]]{
      1,
      y
    });

Caml_obj.caml_update_dummy(y, --[[ :: ]]{
      2,
      x
    });

eq("File \"rec_fun_test.ml\", line 27, characters 6-13", called.contents, 2);

Mt.from_pair_suites("Rec_fun_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.called = called;
exports.g = g;
exports.x = x;
exports.y = y;
return exports;
--[[  Not a pure module ]]
