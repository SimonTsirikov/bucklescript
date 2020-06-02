console = {log = print};


function make(f) do
  return f;
end end

function from(t) do
  return t;
end end

exports = {}
exports.make = make;
exports.from = from;
--[[ No side effect ]]
