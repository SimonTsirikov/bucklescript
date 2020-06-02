console.log = print;

Mt = require "./mt";
Lazy = require "../../lib/js/lazy";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_obj = require "../../lib/js/caml_obj";
Caml_module = require "../../lib/js/caml_module";
CamlinternalLazy = require "../../lib/js/camlinternalLazy";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_external_polyfill = require "../../lib/js/caml_external_polyfill";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

Xx = do
  f: (function (prim, prim_1) do
      return Caml_external_polyfill.resolve("hfiehi")(prim, prim_1);
    end end)
end;

Int3 = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_module.ml",
      27,
      6
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Function ]]0,
            "u"
          }}}));

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Function ]]0,
            "u"
          }}}), Int3, Int3);

Inta = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_module.ml",
      31,
      6
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}));

Intb = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_module.ml",
      36,
      6
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}));

a = Caml_obj.caml_lazy_make((function (param) do
        return CamlinternalLazy.force(Intb.a);
      end end));

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}), Inta, do
      a: a
    end);

a_1 = Caml_obj.caml_lazy_make((function (param) do
        return CamlinternalLazy.force(Inta.a) + 1 | 0;
      end end));

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}), Intb, do
      a: a_1
    end);

tmp;

xpcall(function() do
  tmp = CamlinternalLazy.force(Intb.a);
end end,function(exn) do
  if (exn == Lazy.Undefined) then do
    tmp = -1;
  end else do
    error(exn)
  end end 
end end)

eq("File \"recursive_module.ml\", line 41, characters 3-10", -1, tmp);

Inta_1 = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_module.ml",
      48,
      8
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}));

Intb_1 = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_module.ml",
      53,
      8
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}));

a_2 = Caml_obj.caml_lazy_make((function (param) do
        return CamlinternalLazy.force(Intb_1.a) + 1 | 0;
      end end));

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}), Inta_1, do
      a: a_2
    end);

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Lazy ]]1,
            "a"
          }}}), Intb_1, do
      a: 2
    end);

A = do
  Inta: Inta_1,
  Intb: Intb_1
end;

eq("File \"recursive_module.ml\", line 58, characters 6-13", CamlinternalLazy.force(Inta_1.a), 3);

tmp_1;

xpcall(function() do
  Curry._1(Int3.u, 3);
  tmp_1 = 3;
end end,function(raw_exn) do
  exn_1 = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn_1[0] == Caml_builtin_exceptions.undefined_recursive_module) then do
    tmp_1 = 4;
  end else do
    error(exn_1)
  end end 
end end)

eq("File \"recursive_module.ml\", line 60, characters 6-13", 4, tmp_1);

Mt.from_pair_suites("Recursive_module", suites.contents);

Int32 = --[[ () ]]0;

uuu = Xx.f;

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
--[[ Int3 Not a pure module ]]
