console = {log = print};

Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Printf = require "../../lib/js/printf";

console.error(Curry._2(Printf.sprintf(--[[ Format ]]{
              --[[ Int ]]Block.__(4, {
                  --[[ Int_d ]]0,
                  --[[ No_padding ]]0,
                  --[[ No_precision ]]0,
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ End_of_format ]]0
                    })
                }),
              "%d%s"
            }), 32, "ss"));

exports = {}
--[[  Not a pure module ]]