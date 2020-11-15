__console = {log = print};


function __(tag, block) do
  block.tag = tag;
  return block;
end end

exports = {};
exports.__ = __;
return exports;
--[[ No side effect ]]
