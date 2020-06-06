console = {log = print};


a = {
  x = 3,
  y = --[[ :: ]]{
    1,
    --[[ :: ]]{
      2,
      --[[ :: ]]{
        3,
        --[[ [] ]]0
      }
    }
  }
};

exports = {}
exports.a = a;
--[[ No side effect ]]
