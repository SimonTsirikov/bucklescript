console = {log = print};


function __(tag, block) do
  block.tag = tag;
  return block;
end end

exports = {}
exports.__ = __;
--[[ No side effect ]]
