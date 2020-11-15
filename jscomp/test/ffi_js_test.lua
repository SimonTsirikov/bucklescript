__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";

keys = (function (x){return Object.keys(x)});

function $$higher_order(x){
   return function(y,z){
      return x + y + z
   }
  }
;

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, param) do
  y = param[2];
  x = param[1];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

int_config = {
  hi = 3,
  low = 32
};

string_config = {
  hi = 3,
  low = "32"
};

eq("File \"ffi_js_test.ml\", line 32, characters 5-12", --[[ tuple ]]{
      6,
      $$higher_order(1)(2, 3)
    });

same_type_000 = --[[ :: ]]{
  int_config,
  --[[ :: ]]{
    {
      hi = 3,
      low = 32
    },
    --[[ [] ]]0
  }
};

same_type_001 = --[[ :: ]]{
  string_config,
  --[[ :: ]]{
    {
      hi = 3,
      low = "32"
    },
    --[[ [] ]]0
  }
};

same_type = --[[ tuple ]]{
  same_type_000,
  same_type_001
};

v_obj = {
  hi = (function() do
      __console.log("hei");
      return --[[ () ]]0; end
    end)
};

eq("File \"ffi_js_test.ml\", line 44, characters 5-12", --[[ tuple ]]{
      #__Object.keys(int_config),
      2
    });

eq("File \"ffi_js_test.ml\", line 45, characters 5-12", --[[ tuple ]]{
      #__Object.keys(string_config),
      2
    });

eq("File \"ffi_js_test.ml\", line 46, characters 5-12", --[[ tuple ]]{
      __Object.keys(v_obj).indexOf("hi_x"),
      -1
    });

eq("File \"ffi_js_test.ml\", line 47, characters 5-12", --[[ tuple ]]{
      __Object.keys(v_obj).indexOf("hi"),
      0
    });

u = {
  contents = 3
};

side_effect_config = (u.contents = u.contents + 1 | 0, {
    hi = 3,
    low = 32
  });

eq("File \"ffi_js_test.ml\", line 54, characters 5-12", --[[ tuple ]]{
      u.contents,
      4
    });

function vv(z) do
  return z.hh();
end end

function v(z) do
  return z.ff();
end end

function vvv(z) do
  return z.ff_pipe();
end end

function vvvv(z) do
  return z.ff_pipe2();
end end

function create_prim(param) do
  return {
          "x'" = 3,
          "x''" = 3,
          "x''''" = 2
        };
end end

function ffff(x) do
  x.setGADT = 3;
  x.setGADT2 = --[[ tuple ]]{
    3,
    "3"
  };
  x.setGADT2 = --[[ tuple ]]{
    "3",
    3
  };
  match = x[3];
  __console.log(--[[ tuple ]]{
        match[1],
        match[2]
      });
  __console.log(x.getGADT);
  match_1 = x.getGADT2;
  __console.log(match_1[1], match_1[2]);
  match_2 = x[0];
  __console.log(match_2[1], match_2[2]);
  x[0] = --[[ tuple ]]{
    1,
    "x"
  };
  x[3] = --[[ tuple ]]{
    3,
    "x"
  };
  return --[[ () ]]0;
end end

Mt.from_pair_suites("Ffi_js_test", suites.contents);

exports = {};
exports.keys = keys;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.int_config = int_config;
exports.string_config = string_config;
exports.same_type = same_type;
exports.v_obj = v_obj;
exports.u = u;
exports.side_effect_config = side_effect_config;
exports.vv = vv;
exports.v = v;
exports.vvv = vvv;
exports.vvvv = vvvv;
exports.create_prim = create_prim;
exports.ffff = ffff;
return exports;
--[[  Not a pure module ]]
