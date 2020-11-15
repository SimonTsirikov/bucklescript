__console = {log = print};


function fromString(i) do
  i_1 = __parseFloat(i);
  if (__isNaN(i_1)) then do
    return ;
  end else do
    return i_1;
  end end 
end end

exports = {};
exports.fromString = fromString;
return exports;
--[[ No side effect ]]
