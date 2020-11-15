__console = {log = print};


function v(u) do
  __console.log(u);
  return u;
end end

exports = {};
exports.v = v;
return exports;
--[[ No side effect ]]
