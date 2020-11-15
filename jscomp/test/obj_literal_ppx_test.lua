__console = {log = print};


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

exports = {};
exports.a = a;
return exports;
--[[ No side effect ]]
