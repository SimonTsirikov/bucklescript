'use strict';

var $$Array = require("../../lib/js/array.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_module = require("../../lib/js/caml_module.js");

var PA = Caml_module.init_mod(--[ tuple ]--[
      "gpr_3931_test.ml",
      3,
      6
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "print"
          ]]]));

var P = Caml_module.init_mod(--[ tuple ]--[
      "gpr_3931_test.ml",
      11,
      6
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "print"
          ]]]));

function print(a) {
  return $$Array.iter(P.print, a);
}

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "print"
          ]]]), PA, {
      print: print
    });

function print$1(i) {
  console.log(String(i));
  return --[ () ]--0;
}

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "print"
          ]]]), P, {
      print: print$1
    });

Curry._1(PA.print, [
      1,
      2
    ]);

exports.PA = PA;
exports.P = P;
--[ PA Not a pure module ]--
