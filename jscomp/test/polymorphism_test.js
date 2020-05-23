'use strict';


function map(f, param) do
  if (param) do
    var r = f(param[0]);
    return --[ :: ]--[
            r,
            map(f, param[1])
          ];
  end else do
    return --[ [] ]--0;
  end
end

exports.map = map;
--[ No side effect ]--
