console.log = print;

Mt = require "./mt";
Lazy = require "../../lib/js/lazy";
Block = require "../../lib/js/block";
Caml_obj = require "../../lib/js/caml_obj";
CamlinternalLazy = require "../../lib/js/camlinternalLazy";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

u = do
  contents: 3
end;

v = Caml_obj.caml_lazy_make((function (param) do
        u.contents = 32;
        return --[[ () ]]0;
      end end));

function lazy_test(param) do
  h = u.contents;
  CamlinternalLazy.force(v);
  g = u.contents;
  return --[[ tuple ]]{
          h,
          g
        };
end end

function f(param) do
  CamlinternalLazy.force(param[0]);
  match = param[2].contents;
  if (match ~= undefined) then do
    CamlinternalLazy.force(param[1]);
    match_1 = param[2].contents;
    if (match_1 ~= undefined) then do
      return 1;
    end else do
      error({
        Caml_builtin_exceptions.match_failure,
        --[[ tuple ]]{
          "lazy_test.ml",
          11,
          8
        }
      })
    end end 
  end else do
    return 0;
  end end 
end end

s = do
  contents: undefined
end;

set_true = Caml_obj.caml_lazy_make((function (param) do
        s.contents = 1;
        return --[[ () ]]0;
      end end));

set_false = Caml_obj.caml_lazy_make((function (param) do
        s.contents = undefined;
        return --[[ () ]]0;
      end end));

h;

xpcall(function() do
  h = f(--[[ tuple ]]{
        set_true,
        set_false,
        s
      });
end end,function(raw_exn) do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.match_failure) then do
    h = 2;
  end else do
    error(exn)
  end end 
end end)

u_v = do
  contents: 0
end;

u_1 = Caml_obj.caml_lazy_make((function (param) do
        u_v.contents = 2;
        return --[[ () ]]0;
      end end));

CamlinternalLazy.force(u_1);

exotic = CamlinternalLazy.force;

l_from_fun = Lazy.from_fun((function (param) do
        return 3;
      end end));

forward_test = Caml_obj.caml_lazy_make((function (param) do
        u = 3;
        u = u + 1 | 0;
        return u;
      end end));

f005 = Caml_obj.caml_lazy_make((function (param) do
        return 6;
      end end));

f006 = Caml_obj.caml_lazy_make((function (param) do
        return (function (param) do
            return 3;
          end end);
      end end));

f007 = Caml_obj.caml_lazy_make((function (param) do
        error(Caml_builtin_exceptions.not_found)
      end end));

f008 = Caml_obj.caml_lazy_make((function (param) do
        console.log("hi");
        error(Caml_builtin_exceptions.not_found)
      end end));

Mt.from_pair_suites("Lazy_test", --[[ :: ]]{
      --[[ tuple ]]{
        "simple",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      lazy_test(--[[ () ]]0),
                      --[[ tuple ]]{
                        3,
                        32
                      }
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "lazy_match",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        h,
                        2
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "lazy_force",
            (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          u_v.contents,
                          2
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "lazy_from_fun",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, {
                            CamlinternalLazy.force(l_from_fun),
                            3
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "lazy_from_val",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, {
                              CamlinternalLazy.force(Lazy.from_val(3)),
                              3
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "lazy_from_val2",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, {
                                CamlinternalLazy.force(CamlinternalLazy.force(Lazy.from_val(3))),
                                3
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "lazy_from_val3",
                    (function (param) do
                        debugger;
                        return --[[ Eq ]]Block.__(0, {
                                  CamlinternalLazy.force(CamlinternalLazy.force(Lazy.from_val(forward_test))),
                                  4
                                });
                      end end)
                  },
                  --[[ [] ]]0
                }
              }
            }
          }
        }
      }
    });

exports.v = v;
exports.lazy_test = lazy_test;
exports.f = f;
exports.s = s;
exports.set_true = set_true;
exports.set_false = set_false;
exports.h = h;
exports.u_v = u_v;
exports.u = u_1;
exports.exotic = exotic;
exports.l_from_fun = l_from_fun;
exports.forward_test = forward_test;
exports.f005 = f005;
exports.f006 = f006;
exports.f007 = f007;
exports.f008 = f008;
--[[ h Not a pure module ]]
