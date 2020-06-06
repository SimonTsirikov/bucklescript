console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_array = require "../../lib/js/caml_array";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, param) do
  y = param[1];
  x = param[0];
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

v = {
  1,
  2,
  3,
  3
};

eq("File \"array_subtle_test.ml\", line 12, characters 5-12", --[[ tuple ]]{
      4,
      #v
    });

eq("File \"array_subtle_test.ml\", line 15, characters 5-12", --[[ tuple ]]{
      5,
      v.push(3)
    });

eq("File \"array_subtle_test.ml\", line 16, characters 5-12", --[[ tuple ]]{
      5,
      #v
    });

eq("File \"array_subtle_test.ml\", line 17, characters 5-12", --[[ tuple ]]{
      5,
      v.length
    });

eq("File \"array_subtle_test.ml\", line 21, characters 5-12", --[[ tuple ]]{
      3,
      Caml_array.caml_array_get(v, 2)
    });

Caml_array.caml_array_set(v, 2, 4);

eq("File \"array_subtle_test.ml\", line 23, characters 5-12", --[[ tuple ]]{
      4,
      Caml_array.caml_array_get(v, 2)
    });

while(v.length > 0) do
  v.pop();
end;

eq("File \"array_subtle_test.ml\", line 29, characters 5-12", --[[ tuple ]]{
      0,
      v.length
    });

function f(v) do
  match = v.pop();
  if (match ~= undefined) then do
    console.log("hi");
  end else do
    console.log("hi2");
  end end 
  console.log((v.pop(), --[[ () ]]0));
  return --[[ () ]]0;
end end

function fff(x) do
  return true;
end end

function fff2(x) do
  if (#x >= 10) then do
    console.log("hi");
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function fff3(x) do
  return 1;
end end

function fff4(x) do
  if (#x ~= 0) then do
    return 1;
  end else do
    return 2;
  end end 
end end

eq("File \"array_subtle_test.ml\", line 51, characters 6-13", --[[ tuple ]]{
      fff3({}),
      1
    });

eq("File \"array_subtle_test.ml\", line 52, characters 6-13", --[[ tuple ]]{
      fff4({}),
      2
    });

eq("File \"array_subtle_test.ml\", line 53, characters 6-13", --[[ tuple ]]{
      fff4({1}),
      1
    });

Mt.from_pair_suites("Array_subtle_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.f = f;
exports.fff = fff;
exports.fff2 = fff2;
exports.fff3 = fff3;
exports.fff4 = fff4;
--[[  Not a pure module ]]
