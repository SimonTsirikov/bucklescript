--[['use strict';]]


function f(x) do
  return do
          THIS_IS_NOT_EXPRESSIBLE_IN_BUCKLE: x
        end;
end end

function set(x) do
  x.THIS_IS_NOT_EXPRESSIBLE_IN_BUCKLE = 3;
  return (x.THIS_IS_NOT_EXPRESSIBLE_IN_BUCKLE << 1);
end end

function f1(u) do
  return u.x.x.x.y;
end end

function f2(x) do
  x["x'"] = x["x'"] + 3 | 0;
  return do
          "x'": x["x'"] + 3 | 0
        end;
end end

function f3(x) do
  x.in = x.in + 3 | 0;
  return do
          in: x.in + 3 | 0
        end;
end end

function f4(param) do
  return (((param.EXACT_MAPPING_TO_JS_LABEL + param.EXACT_2 | 0) + param.z.hello | 0) << 1);
end end

exports.f = f;
exports.set = set;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
--[[ No side effect ]]
