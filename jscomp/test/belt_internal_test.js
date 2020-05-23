'use strict';


function treeHeight(n) do
  if (n ~= undefined) do
    return n.height;
  end else do
    return 0;
  end
end

function copy(n) do
  if (n ~= undefined) do
    var match = n;
    var v = match.value;
    var h = match.height;
    var l = match.left;
    var r = match.right;
    return do
            value: v,
            height: h,
            left: copy(l),
            right: copy(r)
          end;
  end else do
    return n;
  end
end

exports.treeHeight = treeHeight;
exports.copy = copy;
--[ No side effect ]--
