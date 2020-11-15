__console = {log = print};

Block = require "......lib.js.block";
Caml_module = require "......lib.js.caml_module";

function Make(X) do
  f = function(param) do
    return --[[ () ]]0;
  end end;
  M = {
    f = f
  };
  return {
          M = M
        };
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

M = {
  f = f
};

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Function ]]0,
                    "f"
                  }}}),
            "M"
          }}}), B, {
      M = M
    });

A = --[[ () ]]0;

exports = {};
exports.Make = Make;
exports.A = A;
exports.B = B;
return exports;
--[[ B Not a pure module ]]
