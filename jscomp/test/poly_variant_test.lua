--[['use strict';]]

Mt = require "./mt.lua";
Fs = require "fs";
Block = require "../../lib/js/block.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

function hey_string (option){
  switch(option){
  case "on_closed" : 
  case "on_open" : 
  case "in" : return option
  default : throw Error ("impossible")
 }
}
function hey_int (option){
  switch (option){
   case 0 : 
   case 3 : 
   case 4 : 
   case 5:
   case 6 : return option
   default : throw Error("impossible")
  }
 }
;

uu = [
  hey_string("on_open"),
  hey_string("on_closed"),
  hey_string("in")
];

vv = [
  hey_int(3),
  hey_int(0),
  hey_int(4)
];

eq("File \"poly_variant_test.ml\", line 58, characters 5-12", vv, [
      3,
      0,
      4
    ]);

eq("File \"poly_variant_test.ml\", line 59, characters 5-12", --[[ tuple ]][
      hey_int(5),
      hey_int(6)
    ], --[[ tuple ]][
      5,
      6
    ]);

eq("File \"poly_variant_test.ml\", line 60, characters 5-12", uu, [
      "on_open",
      "on_closed",
      "in"
    ]);

hey_string("on_closed");

hey_string("in");

function register(readline) do
  readline.on("line", (function (s) do
          console.log(s);
          return --[[ () ]]0;
        end end));
  readline.on("close", (function () do
          console.log("finished");
          return --[[ () ]]0;
        end end));
  return --[[ () ]]0;
end end

function read(name) do
  return Fs.readFileSync(name, "utf8");
end end

function read$1(name) do
  return Fs.readFileSync(name, "utf8");
end end

function test(readline, x) do
  readline.on((function () do
            local ___conditional___=(x[0]);
            do
               if ___conditional___ = -944564236 then do
                  return "line";end end end 
               if ___conditional___ = -933029960 then do
                  return "close";end end end 
               do
              
            end
          end end)(), x[1]);
  return --[[ () ]]0;
end end

function p_is_int_test(x) do
  if (typeof x == "number") then do
    return 2;
  end else do
    return 3;
  end end 
end end

eq("File \"poly_variant_test.ml\", line 142, characters 5-12", 2, 2);

eq("File \"poly_variant_test.ml\", line 143, characters 5-12", 3, p_is_int_test(--[[ `b ]][
          98,
          2
        ]));

Mt.from_pair_suites("Poly_variant_test", suites.contents);

function on2(prim, prim$1) do
  prim.on2((function () do
            local ___conditional___=(prim$1[0]);
            do
               if ___conditional___ = -944564236 then do
                  return "line";end end end 
               if ___conditional___ = -933029960 then do
                  return "close";end end end 
               do
              
            end
          end end)(), prim$1[1]);
  return --[[ () ]]0;
end end

readN = read$1;

exports.uu = uu;
exports.vv = vv;
exports.register = register;
exports.test = test;
exports.on2 = on2;
exports.read = read;
exports.readN = readN;
exports.p_is_int_test = p_is_int_test;
--[[  Not a pure module ]]
