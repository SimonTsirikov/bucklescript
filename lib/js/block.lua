console.log = print;


function __(tag, block) do
  block.tag = tag;
  return block;
end end

exports.__ = __;
--[[ No side effect ]]
