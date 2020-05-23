'use strict';


function tailcall(x) do
  while(true) do
    continue ;
  end;
end

function non_length(x) do
  if (x) do
    return 1 + non_length(x[1]) | 0;
  end else do
    return 0;
  end
end

function length(_acc, _x) do
  while(true) do
    var x = _x;
    var acc = _acc;
    if (x) do
      var tl = x[1];
      if (tl) do
        return 1 + length(acc + 1 | 0, tl[1]) | 0;
      end else do
        _x = tl;
        _acc = acc + 1 | 0;
        continue ;
      end
    end else do
      return acc;
    end
  end;
end

exports.tailcall = tailcall;
exports.non_length = non_length;
exports.length = length;
--[ No side effect ]--
