--[['use strict';]]


a = do
  x: 3,
  y: --[[ :: ]]{
    1,
    --[[ :: ]]{
      2,
      --[[ :: ]]{
        3,
        --[[ [] ]]0
      }
    }
  }
end;

exports.a = a;
--[[ No side effect ]]
