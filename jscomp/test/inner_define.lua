console = {log = print};


function add(x, y) do
  return x + y | 0;
end end

N = do
  add: add
end;

function f1(param) do
  return --[[ () ]]0;
end end

function f2(param, param_1) do
  return --[[ () ]]0;
end end

function f3(param, param_1, param_2) do
  return --[[ () ]]0;
end end

N0 = do
  f1: f1,
  f2: f2,
  f3: f3
end;

function f2_1(param, param_1) do
  return --[[ () ]]0;
end end

function f3_1(param, param_1, param_2) do
  return --[[ () ]]0;
end end

N1 = do
  f2: f2_1,
  f3: f3_1
end;

exports = {}
exports.N = N;
exports.N0 = N0;
exports.N1 = N1;
--[[ No side effect ]]
