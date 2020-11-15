__console = {log = print};

Mt = require "..mt";
List = require "......lib.js.list";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Caml_array = require "......lib.js.caml_array";
Caml_exceptions = require "......lib.js.caml_exceptions";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function assert_bool(b) do
  if (b) then do
    return --[[ () ]]0;
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Assertion Failure."
    })
  end end 
end end

function fail(param) do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "js_promise_basic_test.ml",
      19,
      2
    }
  })
end end

function thenTest(param) do
  p = __Promise.resolve(4);
  return p.__then((function(x) do
                return __Promise.resolve(assert_bool(x == 4));
              end end));
end end

function andThenTest(param) do
  p = __Promise.resolve(6);
  return p.__then((function(param) do
                  return __Promise.resolve(12);
                end end)).__then((function(y) do
                return __Promise.resolve(assert_bool(y == 12));
              end end));
end end

h = __Promise.resolve(--[[ () ]]0);

function assertIsNotFound(x) do
  match = Caml_exceptions.caml_is_extension(x) and x == Caml_builtin_exceptions.not_found and 0 or nil;
  if (match ~= nil) then do
    return h;
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "js_promise_basic_test.ml",
        36,
        9
      }
    })
  end end 
end end

function catchTest(param) do
  p = __Promise.reject(Caml_builtin_exceptions.not_found);
  return p.__then(fail).__catch(assertIsNotFound);
end end

function orResolvedTest(param) do
  p = __Promise.resolve(42);
  return p.__catch((function(param) do
                    return __Promise.resolve(22);
                  end end)).__then((function(value) do
                  return __Promise.resolve(assert_bool(value == 42));
                end end)).__catch(fail);
end end

function orRejectedTest(param) do
  p = __Promise.reject(Caml_builtin_exceptions.not_found);
  return p.__catch((function(param) do
                    return __Promise.resolve(22);
                  end end)).__then((function(value) do
                  return __Promise.resolve(assert_bool(value == 22));
                end end)).__catch(fail);
end end

function orElseResolvedTest(param) do
  p = __Promise.resolve(42);
  return p.__catch((function(param) do
                    return __Promise.resolve(22);
                  end end)).__then((function(value) do
                  return __Promise.resolve(assert_bool(value == 42));
                end end)).__catch(fail);
end end

function orElseRejectedResolveTest(param) do
  p = __Promise.reject(Caml_builtin_exceptions.not_found);
  return p.__catch((function(param) do
                    return __Promise.resolve(22);
                  end end)).__then((function(value) do
                  return __Promise.resolve(assert_bool(value == 22));
                end end)).__catch(fail);
end end

function orElseRejectedRejectTest(param) do
  p = __Promise.reject(Caml_builtin_exceptions.not_found);
  return p.__catch((function(param) do
                    return __Promise.reject(Caml_builtin_exceptions.stack_overflow);
                  end end)).__then(fail).__catch((function(error) do
                match = Caml_exceptions.caml_is_extension(error) and error == Caml_builtin_exceptions.stack_overflow and 0 or nil;
                if (match ~= nil) then do
                  return h;
                end else do
                  error({
                    Caml_builtin_exceptions.assert_failure,
                    --[[ tuple ]]{
                      "js_promise_basic_test.ml",
                      77,
                      18
                    }
                  })
                end end 
              end end));
end end

function resolveTest(param) do
  p1 = __Promise.resolve(10);
  return p1.__then((function(x) do
                return __Promise.resolve(assert_bool(x == 10));
              end end));
end end

function rejectTest(param) do
  p = __Promise.reject(Caml_builtin_exceptions.not_found);
  return p.__catch(assertIsNotFound);
end end

function thenCatchChainResolvedTest(param) do
  p = __Promise.resolve(20);
  return p.__then((function(value) do
                  return __Promise.resolve(assert_bool(value == 20));
                end end)).__catch(fail);
end end

function thenCatchChainRejectedTest(param) do
  p = __Promise.reject(Caml_builtin_exceptions.not_found);
  return p.__then(fail).__catch(assertIsNotFound);
end end

function allResolvedTest(param) do
  p1 = __Promise.resolve(1);
  p2 = __Promise.resolve(2);
  p3 = __Promise.resolve(3);
  promises = {
    p1,
    p2,
    p3
  };
  return __Promise.all(promises).__then((function(resolved) do
                assert_bool(Caml_array.caml_array_get(resolved, 0) == 1);
                assert_bool(Caml_array.caml_array_get(resolved, 1) == 2);
                assert_bool(Caml_array.caml_array_get(resolved, 2) == 3);
                return h;
              end end));
end end

function allRejectTest(param) do
  p1 = __Promise.resolve(1);
  p2 = __Promise.resolve(3);
  p3 = __Promise.reject(Caml_builtin_exceptions.not_found);
  promises = {
    p1,
    p2,
    p3
  };
  return __Promise.all(promises).__then(fail).__catch((function(error) do
                assert_bool(error == Caml_builtin_exceptions.not_found);
                return h;
              end end));
end end

function raceTest(param) do
  p1 = __Promise.resolve("first");
  p2 = __Promise.resolve("second");
  p3 = __Promise.resolve("third");
  promises = {
    p1,
    p2,
    p3
  };
  return __Promise.race(promises).__then((function(resolved) do
                  return h;
                end end)).__catch(fail);
end end

function createPromiseRejectTest(param) do
  return new __Promise((function(resolve, reject) do
                  return reject(Caml_builtin_exceptions.not_found);
                end end)).__catch((function(error) do
                assert_bool(error == Caml_builtin_exceptions.not_found);
                return h;
              end end));
end end

function createPromiseFulfillTest(param) do
  return new __Promise((function(resolve, param) do
                    return resolve("success");
                  end end)).__then((function(resolved) do
                  assert_bool(resolved == "success");
                  return h;
                end end)).__catch(fail);
end end

thenTest(--[[ () ]]0);

andThenTest(--[[ () ]]0);

catchTest(--[[ () ]]0);

orResolvedTest(--[[ () ]]0);

orRejectedTest(--[[ () ]]0);

orElseResolvedTest(--[[ () ]]0);

orElseRejectedResolveTest(--[[ () ]]0);

orElseRejectedRejectTest(--[[ () ]]0);

thenCatchChainResolvedTest(--[[ () ]]0);

thenCatchChainRejectedTest(--[[ () ]]0);

allResolvedTest(--[[ () ]]0);

allRejectTest(--[[ () ]]0);

raceTest(--[[ () ]]0);

createPromiseRejectTest(--[[ () ]]0);

createPromiseFulfillTest(--[[ () ]]0);

__Promise.all(--[[ tuple ]]{
        __Promise.resolve(2),
        __Promise.resolve(3)
      }).__then((function(param) do
        eq("File \"js_promise_basic_test.ml\", line 169, characters 7-14", --[[ tuple ]]{
              param[1],
              param[2]
            }, --[[ tuple ]]{
              2,
              3
            });
        return __Promise.resolve(--[[ () ]]0);
      end end));

__console.log(List.length(suites.contents));

__console.log("hey");

Mt.from_pair_suites("Js_promise_basic_test", suites.contents);

twop = __Promise.resolve(2);

function then_(prim, prim_1) do
  return prim_1.__then(Curry.__1(prim));
end end

function re(prim) do
  return __Promise.resolve(prim);
end end

Mt.from_promise_suites("Js_promise_basic_test", --[[ :: ]]{
      --[[ tuple ]]{
        "File \"js_promise_basic_test.ml\", line 187, characters 4-11",
        twop.__then((function(x) do
                return __Promise.resolve(--[[ Eq ]]Block.__(0, {
                              x,
                              2
                            }));
              end end))
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "File \"js_promise_basic_test.ml\", line 190, characters 4-11",
          twop.__then((function(x) do
                  return __Promise.resolve(--[[ Neq ]]Block.__(1, {
                                x,
                                3
                              }));
                end end))
        },
        --[[ [] ]]0
      }
    });

exports = {};
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
return exports;
--[[ h Not a pure module ]]
