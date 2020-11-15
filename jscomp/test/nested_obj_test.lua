__console = {log = print};


f = {
  x = {
    y = {
      z = 3
    }
  }
};

f2_000 = --[[ :: ]]{
  {
    x = {
      y = {
        z = 3
      }
    }
  },
  --[[ :: ]]{
    {
      x = {
        y = {
          z = 31
        }
      }
    },
    --[[ [] ]]0
  }
};

f2_001 = {
  {
    x = {
      y = {
        z = 3
      }
    }
  },
  {
    x = {
      y = {
        z = 31
      }
    }
  }
};

f2 = --[[ tuple ]]{
  f2_000,
  f2_001
};

f3 = {
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
exports.f_record = f_record;
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
return exports;
--[[ No side effect ]]
