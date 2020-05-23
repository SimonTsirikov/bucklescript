'use strict';


function fff(x) do
  x.height = 2;
  return --[ () ]--0;
end

function ff(x, z) do
  return --[ :: ]--[
          x.height,
          --[ :: ]--[
            z.height,
            --[ [] ]--0
          ]
        ];
end

exports.fff = fff;
exports.ff = ff;
--[ No side effect ]--
