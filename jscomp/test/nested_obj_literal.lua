__console = {log = print};


structural_obj = {
  x = {
    y = {
      z = 3
    }
  }
};

f_record = {
  x = {
    y = {
      z = 3
    }
  }
};

exports = {};
exports.structural_obj = structural_obj;
exports.f_record = f_record;
return exports;
--[[ No side effect ]]
