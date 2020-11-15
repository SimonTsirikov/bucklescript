__console = {log = print};


function Make(M) do
  return M;
end end

exports = {};
exports.Make = Make;
return exports;
--[[ No side effect ]]
