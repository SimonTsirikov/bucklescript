'use strict';

Block = require("../../lib/js/block.js");
Caml_module = require("../../lib/js/caml_module.js");

Point = Caml_module.init_mod(--[ tuple ]--[
      "gpr_1539_test.ml",
      10,
      6
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "add"
          ]]]));

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "add"
          ]]]), Point, do
      add: (function (prim, prim$1) do
          return prim.add(prim$1);
        end)
    end);

CRS = --[ () ]--0;

Layer = --[ () ]--0;

exports.CRS = CRS;
exports.Layer = Layer;
exports.Point = Point;
--[ Point Not a pure module ]--
