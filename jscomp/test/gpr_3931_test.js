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

function print(a) do
  return $$Array.iter(P.print, a);
end

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "print"
          ]]]), PA, do
      print: print
    end);

function print$1(i) do
  console.log(String(i));
  return --[ () ]--0;
end

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "print"
          ]]]), P, do
      print: print$1
    end);

Curry._1(PA.print, [
      1,
      2
    ]);

exports.PA = PA;
exports.P = P;
--[ PA Not a pure module ]--
