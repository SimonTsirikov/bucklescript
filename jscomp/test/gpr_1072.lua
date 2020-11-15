__console = {log = print};


u = {
  y = 3
};

v_ice_cream3_000 = {
  flavor = "vanilla",
  num = 3
};

v_ice_cream3_001 = --[[ :: ]]{
  {
    flavor = "x",
    num = 3
  },
  --[[ :: ]]{
    {
      flavor = "vanilla",
      num = 3
    },
    --[[ [] ]]0
  }
};

v_ice_cream3 = --[[ :: ]]{
  v_ice_cream3_000,
  v_ice_cream3_001
};

v_ice_cream4_000 = {
  flavor = "vanilla",
  num = 3
};

v_ice_cream4_001 = --[[ :: ]]{
  {
    flavor = "x",
    num = 3
  },
  --[[ [] ]]0
};

v_ice_cream4 = --[[ :: ]]{
  v_ice_cream4_000,
  v_ice_cream4_001
};

vv = {
  x = 3
};

int_expect = {
  x = 0
};

int_expect2 = {
  x = 0
};

int_expects_000 = { };

int_expects_001 = --[[ :: ]]{
  {
    x = 2
  },
  --[[ :: ]]{
    {
      x = 3
    },
    --[[ [] ]]0
  }
};

int_expects = --[[ :: ]]{
  int_expects_000,
  int_expects_001
};

mk_ice = {
  flavour = "vanilla",
  num = 3
};

my_ice2 = {
  flavour = "vanilla",
  num = 1
};

my_ice3 = {
  num = 2
};

v_mk4 = {
  y = 3
};

v_mk5 = {
  x = --[[ () ]]0,
  y = 3
};

v_mk6 = {
  y = 3
};

v_mk6_1 = {
  x = --[[ () ]]0,
  y = 3
};

mk_u = {
  x = 0
};

v_mk7_000 = {
  y = 3
};

v_mk7_001 = --[[ :: ]]{
  {
    y = 2
  },
  --[[ :: ]]{
    {
      y = 2
    },
    --[[ [] ]]0
  }
};

v_mk7 = --[[ :: ]]{
  v_mk7_000,
  v_mk7_001
};

again("a", 3);

again(nil, 3);

again(nil, 3);

again(nil, 3);

again2("a", 3);

again3(3);

again3(2);

side_effect = {
  contents = 0
};

again4(nil, --[[ () ]]0, 166);

again4(nil, --[[ () ]]0, 167);

again4(--[[ () ]]0, --[[ () ]]0, 168);

again4(--[[ () ]]0, --[[ () ]]0, 169);

again4(nil, --[[ () ]]0, 170);

again4((side_effect.contents = side_effect.contents + 1 | 0, --[[ () ]]0), --[[ () ]]0, 171);

again4((side_effect.contents = side_effect.contents + 1 | 0, --[[ () ]]0), (side_effect.contents = side_effect.contents - 1 | 0, --[[ () ]]0), 172);

again4(nil, (side_effect.contents = side_effect.contents - 1 | 0, --[[ () ]]0), 173);

again4((side_effect.contents = side_effect.contents + 1 | 0, --[[ () ]]0), --[[ () ]]0, 174);

exports = {};
exports.u = u;
exports.v_ice_cream3 = v_ice_cream3;
exports.v_ice_cream4 = v_ice_cream4;
exports.vv = vv;
exports.int_expect = int_expect;
exports.int_expect2 = int_expect2;
exports.int_expects = int_expects;
exports.mk_ice = mk_ice;
exports.my_ice2 = my_ice2;
exports.my_ice3 = my_ice3;
exports.v_mk4 = v_mk4;
exports.v_mk5 = v_mk5;
exports.v_mk6 = v_mk6;
exports.v_mk6_1 = v_mk6_1;
exports.mk_u = mk_u;
exports.v_mk7 = v_mk7;
exports.side_effect = side_effect;
return exports;
--[[  Not a pure module ]]
