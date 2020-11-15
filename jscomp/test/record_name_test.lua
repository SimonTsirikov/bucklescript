__console = {log = print};


function f(x) do
  return {
          THIS_IS_NOT_EXPRESSIBLE_IN_BUCKLE = x
        };
end end

function set(x) do
  x.THIS_IS_NOT_EXPRESSIBLE_IN_BUCKLE = 3;
  return (x.THIS_IS_NOT_EXPRESSIBLE_IN_BUCKLE << 1);
end end

function f1(u) do
  return u.x.x.x.y;
end end

function f2(x) do
  x["x'"] = x.x_prime + 3 | 0;
  return {
          "x'" = x.x_prime + 3 | 0
        };
end end

function f3(x) do
  x.__in = x.__in + 3 | 0;
  return {
          in = x.__in + 3 | 0
        };
end end

function f4(param) do
  return (((param.EXACT_MAPPING_TO_JS_LABEL + param.EXACT_2 | 0) + param.z.hello | 0) << 1);
end end

exports = {};
exports.f = f;
exports.set = set;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
return exports;
--[[ No side effect ]]
