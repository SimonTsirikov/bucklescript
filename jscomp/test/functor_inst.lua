__console = {log = print};


function say(x, y) do
  return x + y | 0;
end end

exports = {};
exports.say = say;
return exports;
--[[ No side effect ]]
