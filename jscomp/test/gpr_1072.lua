console = {log = print};


u = do
  y: 3
end;

v_ice_cream3_000 = do
  flavor: "vanilla",
  num: 3
end;

v_ice_cream3_001 = --[[ :: ]]{
  do
    flavor: "x",
    num: 3
  end,
  --[[ :: ]]{
    do
      flavor: "vanilla",
      num: 3
    end,
    --[[ [] ]]0
  }
};

v_ice_cream3 = --[[ :: ]]{
  v_ice_cream3_000,
  v_ice_cream3_001
};

v_ice_cream4_000 = do
  flavor: "vanilla",
  num: 3
end;

v_ice_cream4_001 = --[[ :: ]]{
  do
    flavor: "x",
    num: 3
  end,
  --[[ [] ]]0
};

v_ice_cream4 = --[[ :: ]]{
  v_ice_cream4_000,
  v_ice_cream4_001
};

vv = do
  x: 3
end;

int_expect = do
  x: 0
end;

int_expect2 = do
  x: 0
end;

int_expects_000 = { };

int_expects_001 = --[[ :: ]]{
  do
    x: 2
  end,
  --[[ :: ]]{
    do
      x: 3
    end,
    --[[ [] ]]0
  }
};

int_expects = --[[ :: ]]{
  int_expects_000,
  int_expects_001
};

mk_ice = do
  flavour: "vanilla",
  num: 3
end;

my_ice2 = do
  flavour: "vanilla",
  num: 1
end;

my_ice3 = do
  num: 2
end;

v_mk4 = do
  y: 3
end;

v_mk5 = do
  x: --[[ () ]]0,
  y: 3
end;

v_mk6 = do
  y: 3
end;

v_mk6_1 = do
  x: --[[ () ]]0,
  y: 3
end;

mk_u = do
  x: 0
end;

v_mk7_000 = do
  y: 3
end;

v_mk7_001 = --[[ :: ]]{
  do
    y: 2
  end,
  --[[ :: ]]{
    do
      y: 2
    end,
    --[[ [] ]]0
  }
};

v_mk7 = --[[ :: ]]{
  v_mk7_000,
  v_mk7_001
};

again("a", 3);

again(undefined, 3);

again(undefined, 3);

again(undefined, 3);

again2("a", 3);

again3(3);

again3(2);

side_effect = do
  contents: 0
end;

again4(undefined, --[[ () ]]0, 166);

again4(undefined, --[[ () ]]0, 167);

again4(--[[ () ]]0, --[[ () ]]0, 168);

again4(--[[ () ]]0, --[[ () ]]0, 169);

again4(undefined, --[[ () ]]0, 170);

again4((side_effect.contents = side_effect.contents + 1 | 0, --[[ () ]]0), --[[ () ]]0, 171);

again4((side_effect.contents = side_effect.contents + 1 | 0, --[[ () ]]0), (side_effect.contents = side_effect.contents - 1 | 0, --[[ () ]]0), 172);

again4(undefined, (side_effect.contents = side_effect.contents - 1 | 0, --[[ () ]]0), 173);

again4((side_effect.contents = side_effect.contents + 1 | 0, --[[ () ]]0), --[[ () ]]0, 174);

exports = {}
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
--[[  Not a pure module ]]
