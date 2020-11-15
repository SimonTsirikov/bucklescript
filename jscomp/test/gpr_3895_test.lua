__console = {log = print};


function f(re) do
  re.exec("banana");
  return 3;
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
