'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, param) do
  var y = param[1];
  var x = param[0];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

var v5 = do
  x: 3,
  y: 3,
  setY: (function (v) do
      var self = this ;
      self.y = 2;
      return --[ tuple ]--[
              self.y,
              v
            ];
    end),
  say: (function () do
      var self = this ;
      return self.x + self.y | 0;
    end),
  hihi: (function (u) do
      var self = this ;
      return self.x + self.say() | 0;
    end),
  bark: (function () do
      console.log("bark");
      return --[ () ]--0;
    end),
  xz: (function () do
      return 3;
    end)
end;

var v = do
  x: 3,
  y: 0,
  reset: (function () do
      var self = this ;
      self.y = 0;
      return --[ () ]--0;
    end),
  incr: (function () do
      var self = this ;
      self.y = self.y + 1 | 0;
      return --[ () ]--0;
    end),
  getY: (function () do
      var self = this ;
      return self.y;
    end),
  say: (function () do
      var self = this ;
      return self.x + self.y | 0;
    end)
end;

var u = do
  incr: (function () do
      console.log("hey");
      return --[ () ]--0;
    end),
  getY: (function () do
      return 3;
    end),
  say: (function () do
      return 7;
    end)
end;

var test_type_001 = --[ :: ]--[
  v,
  --[ [] ]--0
];

var test_type = --[ :: ]--[
  u,
  test_type_001
];

var z = do
  x: do
    contents: 3
  end,
  setX: (function (x) do
      var self = this ;
      self.x.contents = x;
      return --[ () ]--0;
    end),
  getX: (function () do
      var self = this ;
      return self.x.contents;
    end)
end;

var eventObj = do
  events: [],
  empty: (function () do
      var self = this ;
      var a = self.events;
      a.splice(0);
      return --[ () ]--0;
    end),
  push: (function (a) do
      var self = this ;
      var xs = self.events;
      xs.push(a);
      return --[ () ]--0;
    end),
  needRebuild: (function () do
      var self = this ;
      return #self.events ~= 0;
    end)
end;

function test__(x) do
  return eventObj.push(x);
end

var zz = do
  x: 3,
  setX: (function (x) do
      var self = this ;
      self.x = x;
      return --[ () ]--0;
    end),
  getX: (function () do
      var self = this ;
      return self.x;
    end)
end;

var test_type2_001 = --[ :: ]--[
  zz,
  --[ [] ]--0
];

var test_type2 = --[ :: ]--[
  z,
  test_type2_001
];

eq("File \"ppx_this_obj_field.ml\", line 92, characters 5-12", --[ tuple ]--[
      6,
      v5.say()
    ]);

var a = v.say();

v.incr();

var b = v.say();

v.incr();

var c = v.say();

v.incr();

eq("File \"ppx_this_obj_field.ml\", line 99, characters 5-12", --[ tuple ]--[
      --[ tuple ]--[
        3,
        4,
        5
      ],
      --[ tuple ]--[
        a,
        b,
        c
      ]
    ]);

var aa = z.getX();

z.setX(32);

var bb = z.getX();

eq("File \"ppx_this_obj_field.ml\", line 103, characters 5-12", --[ tuple ]--[
      --[ tuple ]--[
        3,
        32
      ],
      --[ tuple ]--[
        aa,
        bb
      ]
    ]);

Mt.from_pair_suites("Ppx_this_obj_field", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v5 = v5;
exports.v = v;
exports.u = u;
exports.test_type = test_type;
exports.z = z;
exports.eventObj = eventObj;
exports.test__ = test__;
exports.zz = zz;
exports.test_type2 = test_type2;
--[ v5 Not a pure module ]--
