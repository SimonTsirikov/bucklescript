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

var v = do
  x: (function () do
      return 3;
    end),
  say: (function (x) do
      var self = this ;
      return x * self.x();
    end),
  hi: (function (x, y) do
      var self = this ;
      return self.say(x) + y;
    end)
end;

var v2 = do
  hi: (function (x, y) do
      var self = this ;
      return self.say(x) + y;
    end),
  say: (function (x) do
      var self = this ;
      return x * self.x();
    end),
  x: (function () do
      return 3;
    end)
end;

var v3 = do
  hi: (function (x, y) do
      var self = this ;
      var u = do
        x: x
      end;
      return self.say(u.x) + y + x;
    end),
  say: (function (x) do
      var self = this ;
      return x * self.x();
    end),
  x: (function () do
      return 3;
    end)
end;

var v4 = do
  hi: (function (x, y) do
      return x + y;
    end),
  say: (function (x) do
      return x;
    end),
  x: (function () do
      return 1;
    end)
end;

var collection = [
  v,
  v2,
  v3,
  v4
];

eq("File \"ppx_this_obj_test.ml\", line 59, characters 5-12", --[ tuple ]--[
      11,
      v.hi(3, 2)
    ]);

eq("File \"ppx_this_obj_test.ml\", line 60, characters 5-12", --[ tuple ]--[
      11,
      v2.hi(3, 2)
    ]);

Mt.from_pair_suites("Ppx_this_obj_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.v2 = v2;
exports.v3 = v3;
exports.v4 = v4;
exports.collection = collection;
--[ v Not a pure module ]--
