'use strict';


function treeHeight(n) do
  if (n ~= undefined) then do
    return n.height;
  end else do
    return 0;
  end end 
end

function copy(n) do
  if (n ~= undefined) then do
    match = n;
    v = match.value;
    h = match.height;
    l = match.left;
    r = match.right;
    return do
            value: v,
            height: h,
            left: copy(l),
            right: copy(r)
          end;
  end else do
    return n;
  end end 
end

exports.treeHeight = treeHeight;
exports.copy = copy;
--[ No side effect ]--
