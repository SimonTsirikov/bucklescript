console = {log = print};


function f(resp) do
  resp.statusCode = 200;
  resp.hi = "hi";
  return --[[ () ]]0;
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
