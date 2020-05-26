'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_int32 = require("../../lib/js/caml_int32.js");
Caml_module = require("../../lib/js/caml_module.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function add(suite) do
  suites.contents = --[ :: ]--[
    suite,
    suites.contents
  ];
  return --[ () ]--0;
end

Int3 = Caml_module.init_mod(--[ tuple ]--[
      "recursive_module_test.ml",
      13,
      6
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "u"
          ]]]));

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "u"
          ]]]), Int3, Int3);

M = Caml_module.init_mod(--[ tuple ]--[
      "recursive_module_test.ml",
      20,
      20
    ], --[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "fact"
          ]]]));

function fact(n) do
  if (n <= 1) then do
    return 1;
  end else do
    return Caml_int32.imul(n, Curry._1(M.fact, n - 1 | 0));
  end end 
end

Caml_module.update_mod(--[ Module ]--Block.__(0, [[--[ tuple ]--[
            --[ Function ]--0,
            "fact"
          ]]]), M, do
      fact: fact
    end);

fact$1 = M.fact;

Fact = do
  M: M,
  fact: fact$1
end;

eq("File \"recursive_module_test.ml\", line 30, characters 5-12", 120, Curry._1(fact$1, 5));

add(--[ tuple ]--[
      "File \"recursive_module_test.ml\", line 34, characters 7-14",
      (function (param) do
          return --[ ThrowAny ]--Block.__(7, [(function (param) do
                        Curry._1(Int3.u, 3);
                        return --[ () ]--0;
                      end)]);
        end)
    ]);

Mt.from_pair_suites("Recursive_module_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.add = add;
exports.Int3 = Int3;
exports.Fact = Fact;
--[ Int3 Not a pure module ]--
