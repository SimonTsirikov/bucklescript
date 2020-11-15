__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Caml_int32 = require "......lib.js.caml_int32";
Caml_int64 = require "......lib.js.caml_int64";

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

a0;

xpcall(function() do
  Caml_int32.div(0, 0);
  a0 = 0;
end end,function(exn) do
  a0 = 1;
end end)

a1;

xpcall(function() do
  Caml_int32.mod_(0, 0);
  a1 = 0;
end end,function(exn_1) do
  a1 = 1;
end end)

a4;

xpcall(function() do
  Caml_int32.div(0, 0);
  a4 = 0;
end end,function(exn_2) do
  a4 = 1;
end end)

a5;

xpcall(function() do
  Caml_int32.mod_(0, 0);
  a5 = 0;
end end,function(exn_3) do
  a5 = 1;
end end)

a6;

xpcall(function() do
  Caml_int64.div(--[[ int64 ]]{
        --[[ hi ]]0,
        --[[ lo ]]0
      }, --[[ int64 ]]{
        --[[ hi ]]0,
        --[[ lo ]]0
      });
  a6 = 0;
end end,function(exn_4) do
  a6 = 1;
end end)

a7;

xpcall(function() do
  Caml_int64.mod_(--[[ int64 ]]{
        --[[ hi ]]0,
        --[[ lo ]]0
      }, --[[ int64 ]]{
        --[[ hi ]]0,
        --[[ lo ]]0
      });
  a7 = 0;
end end,function(exn_5) do
  a7 = 1;
end end)

eq("File \"gpr_1760_test.ml\", line 30, characters 5-12", --[[ tuple ]]{
      a0,
      a1,
      a4,
      a5,
      a6,
      a7
    }, --[[ tuple ]]{
      1,
      1,
      1,
      1,
      1,
      1
    });

Mt.from_pair_suites("Gpr_1760_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.a0 = a0;
exports.a1 = a1;
exports.a4 = a4;
exports.a5 = a5;
exports.a6 = a6;
exports.a7 = a7;
return exports;
--[[ a0 Not a pure module ]]
