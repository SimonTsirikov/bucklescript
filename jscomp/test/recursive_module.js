'use strict';

var Mt = require("./mt.js");
var Lazy = require("../../lib/js/lazy.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Caml_module = require("../../lib/js/caml_module.js");
var CamlinternalLazy = require("../../lib/js/camlinternalLazy.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_external_polyfill = require("../../lib/js/caml_external_polyfill.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

var Xx = do
  f: (function (prim, prim$1) do
      return Caml_external_polyfill.resolve("hfiehi")(prim, prim$1);
    end)
end;

var Int3 = Caml_module.init_mod(--[ tuple ]--[
      "recursive_module.ml",
      27,
      6
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "u"
          ]]]));

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "u"
          ]]]), Int3, Int3);

var Inta = Caml_module.init_mod(--[ tuple ]--[
      "recursive_module.ml",
      31,
      6
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]));

var Intb = Caml_module.init_mod(--[ tuple ]--[
      "recursive_module.ml",
      36,
      6
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]));

var a = Caml_obj.caml_lazy_make((function (param) do
        return CamlinternalLazy.force(Intb.a);
      end));

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]), Inta, do
      a: a
    end);

var a$1 = Caml_obj.caml_lazy_make((function (param) do
        return CamlinternalLazy.force(Inta.a) + 1 | 0;
      end));

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]), Intb, do
      a: a$1
    end);

var tmp;

try do
  tmp = CamlinternalLazy.force(Intb.a);
end
catch (exn)do
  if (exn == Lazy.Undefined) do
    tmp = -1;
  end else do
    throw exn;
  end
end

eq("File \"recursive_module.ml\", line 41, characters 3-10", -1, tmp);

var Inta$1 = Caml_module.init_mod(--[ tuple ]--[
      "recursive_module.ml",
      48,
      8
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]));

var Intb$1 = Caml_module.init_mod(--[ tuple ]--[
      "recursive_module.ml",
      53,
      8
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]));

var a$2 = Caml_obj.caml_lazy_make((function (param) do
        return CamlinternalLazy.force(Intb$1.a) + 1 | 0;
      end));

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]), Inta$1, do
      a: a$2
    end);

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Lazy ]--1,
            "a"
          ]]]), Intb$1, do
      a: 2
    end);

var A = do
  Inta: Inta$1,
  Intb: Intb$1
end;

eq("File \"recursive_module.ml\", line 58, characters 6-13", CamlinternalLazy.force(Inta$1.a), 3);

var tmp$1;

try do
  Curry._1(Int3.u, 3);
  tmp$1 = 3;
end
catch (raw_exn)do
  var exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn$1[0] == Caml_builtin_exceptions.undefined_recursive_module) do
    tmp$1 = 4;
  end else do
    throw exn$1;
  end
end

eq("File \"recursive_module.ml\", line 60, characters 6-13", 4, tmp$1);

Mt.from_pair_suites("Recursive_module", suites.contents);

var Int32 = --[ () ]--0;

var uuu = Xx.f;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.Int32 = Int32;
exports.Xx = Xx;
exports.uuu = uuu;
exports.Int3 = Int3;
exports.Inta = Inta;
exports.Intb = Intb;
exports.A = A;
--[ Int3 Not a pure module ]--
