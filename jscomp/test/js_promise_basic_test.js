'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
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

function assert_bool(b) do
  if (b) then do
    return --[ () ]--0;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Assertion Failure."
        ];
  end end 
end

function fail(param) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "js_promise_basic_test.ml",
          19,
          2
        ]
      ];
end

function thenTest(param) do
  var p = Promise.resolve(4);
  return p.then((function (x) do
                return Promise.resolve(assert_bool(x == 4));
              end));
end

function andThenTest(param) do
  var p = Promise.resolve(6);
  return p.then((function (param) do
                  return Promise.resolve(12);
                end)).then((function (y) do
                return Promise.resolve(assert_bool(y == 12));
              end));
end

var h = Promise.resolve(--[ () ]--0);

function assertIsNotFound(x) do
  var match = Caml_exceptions.caml_is_extension(x) and x == Caml_builtin_exceptions.not_found and 0 or undefined;
  if (match ~= undefined) then do
    return h;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "js_promise_basic_test.ml",
            36,
            9
          ]
        ];
  end end 
end

function catchTest(param) do
  var p = Promise.reject(Caml_builtin_exceptions.not_found);
  return p.then(fail).catch(assertIsNotFound);
end

function orResolvedTest(param) do
  var p = Promise.resolve(42);
  return p.catch((function (param) do
                    return Promise.resolve(22);
                  end)).then((function (value) do
                  return Promise.resolve(assert_bool(value == 42));
                end)).catch(fail);
end

function orRejectedTest(param) do
  var p = Promise.reject(Caml_builtin_exceptions.not_found);
  return p.catch((function (param) do
                    return Promise.resolve(22);
                  end)).then((function (value) do
                  return Promise.resolve(assert_bool(value == 22));
                end)).catch(fail);
end

function orElseResolvedTest(param) do
  var p = Promise.resolve(42);
  return p.catch((function (param) do
                    return Promise.resolve(22);
                  end)).then((function (value) do
                  return Promise.resolve(assert_bool(value == 42));
                end)).catch(fail);
end

function orElseRejectedResolveTest(param) do
  var p = Promise.reject(Caml_builtin_exceptions.not_found);
  return p.catch((function (param) do
                    return Promise.resolve(22);
                  end)).then((function (value) do
                  return Promise.resolve(assert_bool(value == 22));
                end)).catch(fail);
end

function orElseRejectedRejectTest(param) do
  var p = Promise.reject(Caml_builtin_exceptions.not_found);
  return p.catch((function (param) do
                    return Promise.reject(Caml_builtin_exceptions.stack_overflow);
                  end)).then(fail).catch((function (error) do
                var match = Caml_exceptions.caml_is_extension(error) and error == Caml_builtin_exceptions.stack_overflow and 0 or undefined;
                if (match ~= undefined) then do
                  return h;
                end else do
                  throw [
                        Caml_builtin_exceptions.assert_failure,
                        --[ tuple ]--[
                          "js_promise_basic_test.ml",
                          77,
                          18
                        ]
                      ];
                end end 
              end));
end

function resolveTest(param) do
  var p1 = Promise.resolve(10);
  return p1.then((function (x) do
                return Promise.resolve(assert_bool(x == 10));
              end));
end

function rejectTest(param) do
  var p = Promise.reject(Caml_builtin_exceptions.not_found);
  return p.catch(assertIsNotFound);
end

function thenCatchChainResolvedTest(param) do
  var p = Promise.resolve(20);
  return p.then((function (value) do
                  return Promise.resolve(assert_bool(value == 20));
                end)).catch(fail);
end

function thenCatchChainRejectedTest(param) do
  var p = Promise.reject(Caml_builtin_exceptions.not_found);
  return p.then(fail).catch(assertIsNotFound);
end

function allResolvedTest(param) do
  var p1 = Promise.resolve(1);
  var p2 = Promise.resolve(2);
  var p3 = Promise.resolve(3);
  var promises = [
    p1,
    p2,
    p3
  ];
  return Promise.all(promises).then((function (resolved) do
                assert_bool(Caml_array.caml_array_get(resolved, 0) == 1);
                assert_bool(Caml_array.caml_array_get(resolved, 1) == 2);
                assert_bool(Caml_array.caml_array_get(resolved, 2) == 3);
                return h;
              end));
end

function allRejectTest(param) do
  var p1 = Promise.resolve(1);
  var p2 = Promise.resolve(3);
  var p3 = Promise.reject(Caml_builtin_exceptions.not_found);
  var promises = [
    p1,
    p2,
    p3
  ];
  return Promise.all(promises).then(fail).catch((function (error) do
                assert_bool(error == Caml_builtin_exceptions.not_found);
                return h;
              end));
end

function raceTest(param) do
  var p1 = Promise.resolve("first");
  var p2 = Promise.resolve("second");
  var p3 = Promise.resolve("third");
  var promises = [
    p1,
    p2,
    p3
  ];
  return Promise.race(promises).then((function (resolved) do
                  return h;
                end)).catch(fail);
end

function createPromiseRejectTest(param) do
  return new Promise((function (resolve, reject) do
                  return reject(Caml_builtin_exceptions.not_found);
                end)).catch((function (error) do
                assert_bool(error == Caml_builtin_exceptions.not_found);
                return h;
              end));
end

function createPromiseFulfillTest(param) do
  return new Promise((function (resolve, param) do
                    return resolve("success");
                  end)).then((function (resolved) do
                  assert_bool(resolved == "success");
                  return h;
                end)).catch(fail);
end

thenTest(--[ () ]--0);

andThenTest(--[ () ]--0);

catchTest(--[ () ]--0);

orResolvedTest(--[ () ]--0);

orRejectedTest(--[ () ]--0);

orElseResolvedTest(--[ () ]--0);

orElseRejectedResolveTest(--[ () ]--0);

orElseRejectedRejectTest(--[ () ]--0);

thenCatchChainResolvedTest(--[ () ]--0);

thenCatchChainRejectedTest(--[ () ]--0);

allResolvedTest(--[ () ]--0);

allRejectTest(--[ () ]--0);

raceTest(--[ () ]--0);

createPromiseRejectTest(--[ () ]--0);

createPromiseFulfillTest(--[ () ]--0);

Promise.all(--[ tuple ]--[
        Promise.resolve(2),
        Promise.resolve(3)
      ]).then((function (param) do
        eq("File \"js_promise_basic_test.ml\", line 169, characters 7-14", --[ tuple ]--[
              param[0],
              param[1]
            ], --[ tuple ]--[
              2,
              3
            ]);
        return Promise.resolve(--[ () ]--0);
      end));

console.log(List.length(suites.contents));

console.log("hey");

Mt.from_pair_suites("Js_promise_basic_test", suites.contents);

var twop = Promise.resolve(2);

function then_(prim, prim$1) do
  return prim$1.then(Curry.__1(prim));
end

function re(prim) do
  return Promise.resolve(prim);
end

Mt.from_promise_suites("Js_promise_basic_test", --[ :: ]--[
      --[ tuple ]--[
        "File \"js_promise_basic_test.ml\", line 187, characters 4-11",
        twop.then((function (x) do
                return Promise.resolve(--[ Eq ]--Block.__(0, [
                              x,
                              2
                            ]));
              end))
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "File \"js_promise_basic_test.ml\", line 190, characters 4-11",
          twop.then((function (x) do
                  return Promise.resolve(--[ Neq ]--Block.__(1, [
                                x,
                                3
                              ]));
                end))
        ],
        --[ [] ]--0
      ]
    ]);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.assert_bool = assert_bool;
exports.fail = fail;
exports.thenTest = thenTest;
exports.andThenTest = andThenTest;
exports.h = h;
exports.assertIsNotFound = assertIsNotFound;
exports.catchTest = catchTest;
exports.orResolvedTest = orResolvedTest;
exports.orRejectedTest = orRejectedTest;
exports.orElseResolvedTest = orElseResolvedTest;
exports.orElseRejectedResolveTest = orElseRejectedResolveTest;
exports.orElseRejectedRejectTest = orElseRejectedRejectTest;
exports.resolveTest = resolveTest;
exports.rejectTest = rejectTest;
exports.thenCatchChainResolvedTest = thenCatchChainResolvedTest;
exports.thenCatchChainRejectedTest = thenCatchChainRejectedTest;
exports.allResolvedTest = allResolvedTest;
exports.allRejectTest = allRejectTest;
exports.raceTest = raceTest;
exports.createPromiseRejectTest = createPromiseRejectTest;
exports.createPromiseFulfillTest = createPromiseFulfillTest;
exports.twop = twop;
exports.then_ = then_;
exports.re = re;
--[ h Not a pure module ]--
