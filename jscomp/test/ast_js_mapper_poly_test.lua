console = {log = print};

Mt = require "./mt";
__Array = require "../../lib/js/array";
Block = require "../../lib/js/block";
Js_mapperRt = require "../../lib/js/js_mapperRt";

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

jsMapperConstantArray = {
  --[[ tuple ]]{
    67,
    "C"
  },
  --[[ tuple ]]{
    68,
    "D"
  },
  --[[ tuple ]]{
    102,
    "x"
  }
};

function uToJs(param) do
  return Js_mapperRt.binarySearch(3, param, jsMapperConstantArray);
end end

function uFromJs(param) do
  return Js_mapperRt.revSearch(3, jsMapperConstantArray, param);
end end

function eqU(x, y) do
  return x == y;
end end

function eqUOpt(x, y) do
  if (x ~= nil) then do
    if (y ~= nil) then do
      return x == y;
    end else do
      return false;
    end end 
  end else do
    return y == nil;
  end end 
end end

eq("File \"ast_js_mapper_poly_test.ml\", line 25, characters 5-12", eqUOpt(uFromJs("x"), --[[ f ]]102), true);

eq("File \"ast_js_mapper_poly_test.ml\", line 26, characters 5-12", eqUOpt(uFromJs("D"), --[[ D ]]68), true);

eq("File \"ast_js_mapper_poly_test.ml\", line 27, characters 5-12", eqUOpt(uFromJs("C"), --[[ C ]]67), true);

eq("File \"ast_js_mapper_poly_test.ml\", line 28, characters 5-12", eqUOpt(uFromJs("f"), nil), true);

eq("File \"ast_js_mapper_poly_test.ml\", line 29, characters 5-12", __Array.map(uToJs, {
          --[[ D ]]68,
          --[[ C ]]67,
          --[[ f ]]102
        }), {
      "D",
      "C",
      "x"
    });

jsMapperConstantArray_1 = {
  0,
  3,
  4,
  5
};

function vToJs(param) do
  return jsMapperConstantArray_1[param];
end end

function vFromJs(param) do
  return Js_mapperRt.fromInt(4, jsMapperConstantArray_1, param);
end end

function eqV(x, y) do
  return x == y;
end end

function eqVOpt(x, y) do
  if (x ~= nil) then do
    if (y ~= nil) then do
      return x == y;
    end else do
      return false;
    end end 
  end else do
    return y == nil;
  end end 
end end

function s(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == 0--[[ A0 ]] then do
        return "A0"; end end 
     if ___conditional___ == 1--[[ A1 ]] then do
        return "A1"; end end 
     if ___conditional___ == 2--[[ A2 ]] then do
        return "A2"; end end 
     if ___conditional___ == 3--[[ A3 ]] then do
        return "A3"; end end 
    
  end
end end

eq("File \"ast_js_mapper_poly_test.ml\", line 54, characters 5-12", __Array.map(vToJs, {
          --[[ A0 ]]0,
          --[[ A1 ]]1,
          --[[ A2 ]]2,
          --[[ A3 ]]3
        }), {
      0,
      3,
      4,
      5
    });

eq("File \"ast_js_mapper_poly_test.ml\", line 55, characters 5-12", __Array.map(vFromJs, {
          0,
          1,
          2,
          3,
          4,
          5,
          6
        }), {
      --[[ A0 ]]0,
      nil,
      nil,
      --[[ A1 ]]1,
      --[[ A2 ]]2,
      --[[ A3 ]]3,
      nil
    });

function v1ToJs(param) do
  return param + 0 | 0;
end end

function v1FromJs(param) do
  if (param <= 5 and 0 <= param) then do
    return param - 0 | 0;
  end
   end 
end end

eq("File \"ast_js_mapper_poly_test.ml\", line 68, characters 5-12", __Array.map(v1ToJs, {
          --[[ B0 ]]0,
          --[[ B1 ]]1,
          --[[ B2 ]]2,
          --[[ B3 ]]3,
          --[[ B4 ]]4,
          --[[ B5 ]]5
        }), {
      0,
      1,
      2,
      3,
      4,
      5
    });

eq("File \"ast_js_mapper_poly_test.ml\", line 69, characters 5-12", __Array.map(v1FromJs, {
          -1,
          0,
          1,
          2,
          3,
          4,
          5,
          6
        }), {
      nil,
      --[[ B0 ]]0,
      --[[ B1 ]]1,
      --[[ B2 ]]2,
      --[[ B3 ]]3,
      --[[ B4 ]]4,
      --[[ B5 ]]5,
      nil
    });

function v2ToJs(param) do
  return param + 2 | 0;
end end

function v2FromJs(param) do
  if (param <= 7 and 2 <= param) then do
    return param - 2 | 0;
  end
   end 
end end

eq("File \"ast_js_mapper_poly_test.ml\", line 86, characters 5-12", __Array.map(v2ToJs, {
          --[[ C0 ]]0,
          --[[ C1 ]]1,
          --[[ C2 ]]2,
          --[[ C3 ]]3,
          --[[ C4 ]]4,
          --[[ C5 ]]5
        }), {
      2,
      3,
      4,
      5,
      6,
      7
    });

eq("File \"ast_js_mapper_poly_test.ml\", line 89, characters 5-12", __Array.map(v2FromJs, {
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8
        }), __Array.append(__Array.append({
              nil,
              nil
            }, __Array.map((function(x) do
                    return x;
                  end end), {
                  --[[ C0 ]]0,
                  --[[ C1 ]]1,
                  --[[ C2 ]]2,
                  --[[ C3 ]]3,
                  --[[ C4 ]]4,
                  --[[ C5 ]]5
                })), {nil}));

Mt.from_pair_suites("Ast_js_mapper_poly_test", suites.contents);

$plus$great = __Array.append;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.uToJs = uToJs;
exports.uFromJs = uFromJs;
exports.eqU = eqU;
exports.eqUOpt = eqUOpt;
exports.vToJs = vToJs;
exports.vFromJs = vFromJs;
exports.eqV = eqV;
exports.eqVOpt = eqVOpt;
exports.s = s;
exports.v1ToJs = v1ToJs;
exports.v1FromJs = v1FromJs;
exports.v2ToJs = v2ToJs;
exports.v2FromJs = v2FromJs;
exports.$plus$great = $plus$great;
--[[  Not a pure module ]]
