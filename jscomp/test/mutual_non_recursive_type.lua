console = {log = print};


function f(x) do
  return x;
end end

U = do
  f: f
end;

v = --[[ H ]]{--[[ OT ]]0};

exports = {}
exports.U = U;
exports.v = v;
--[[ No side effect ]]
