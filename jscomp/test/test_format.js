'use strict';

Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Format = require("../../lib/js/format.js");

Curry._1(Format.fprintf(Format.std_formatter, --[[ Format ]][
          --[[ Int ]]Block.__(4, [
              --[[ Int_d ]]0,
              --[[ No_padding ]]0,
              --[[ No_precision ]]0,
              --[[ End_of_format ]]0
            ]),
          "%d"
        ]), 3);

--[[  Not a pure module ]]
