console = {log = print};


function treeHeight(n) do
  if (n ~= nil) then do
    return n.height;
  end else do
    return 0;
  end end 
end end

function copy(n) do
  if (n ~= nil) then do
    match = n;
    v = match.value;
    h = match.height;
    l = match.left;
    r = match.right;
    return {
            value = v,
            height = h,
            left = copy(l),
            right = copy(r)
          };
  end else do
    return n;
  end end 
end end

exports = {}
exports.treeHeight = treeHeight;
exports.copy = copy;
--[[ No side effect ]]
