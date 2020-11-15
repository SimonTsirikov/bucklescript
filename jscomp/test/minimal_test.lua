__console = {log = print};


fake_y = --[[ :: ]]{
  2,
  --[[ :: ]]{
    3,
    --[[ [] ]]0
  }
};

fake_z = --[[ :: ]]{
  1,
  fake_y
};

exports = {};
exports.fake_y = fake_y;
exports.fake_z = fake_z;
return exports;
--[[ No side effect ]]
