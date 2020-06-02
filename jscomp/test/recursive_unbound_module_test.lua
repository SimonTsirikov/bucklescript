--[['use strict';]]

Block = require "../../lib/js/block.lua";
Caml_module = require "../../lib/js/caml_module.lua";

function Make(X) do
  f = function (param) do
    return --[[ () ]]0;
  end end;
  M = do
    f: f
  end;
  return do
          M: M
        end;
end end

B = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_unbound_module_test.ml",
      18,
      0
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Function ]]0,
                    "f"
                  }}}),
            "M"
          }}}));

function f(param) do
  return --[[ () ]]0;
end end

M = do
  f: f
end;

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Function ]]0,
                    "f"
                  }}}),
            "M"
          }}}), B, do
      M: M
    end);

A = --[[ () ]]0;

exports.Make = Make;
exports.A = A;
exports.B = B;
--[[ B Not a pure module ]]
