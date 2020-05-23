'use strict';

var List = require("../../lib/js/list.js");
var Path = require("path");
var $$Array = require("../../lib/js/array.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Assert = require("assert");
var Process = require("process");

function assert_fail(msg) do
  Assert.fail(--[ () ]--0, --[ () ]--0, msg, "");
  return --[ () ]--0;
end

function is_mocha(param) do
  var match = $$Array.to_list(Process.argv);
  if (match) do
    var match$1 = match[1];
    if (match$1) do
      var exec = Path.basename(match$1[0]);
      if (exec == "mocha") do
        return true;
      end else do
        return exec == "_mocha";
      end
    end else do
      return false;
    end
  end else do
    return false;
  end
end

function from_suites(name, suite) do
  var match = $$Array.to_list(Process.argv);
  if (match and is_mocha(--[ () ]--0)) do
    describe(name, (function () do
            return List.iter((function (param) do
                          var partial_arg = param[1];
                          it(param[0], (function () do
                                  return Curry._1(partial_arg, --[ () ]--0);
                                end));
                          return --[ () ]--0;
                        end), suite);
          end));
    return --[ () ]--0;
  end else do
    return --[ () ]--0;
  end
end

function close_enough(thresholdOpt, a, b) do
  var threshold = thresholdOpt ~= undefined ? thresholdOpt : 0.0000001;
  return Math.abs(a - b) < threshold;
end

function handleCode(spec) do
  switch (spec.tag | 0) do
    case --[ Eq ]--0 :
        Assert.deepEqual(spec[0], spec[1]);
        return --[ () ]--0;
    case --[ Neq ]--1 :
        Assert.notDeepEqual(spec[0], spec[1]);
        return --[ () ]--0;
    case --[ StrictEq ]--2 :
        Assert.strictEqual(spec[0], spec[1]);
        return --[ () ]--0;
    case --[ StrictNeq ]--3 :
        Assert.notStrictEqual(spec[0], spec[1]);
        return --[ () ]--0;
    case --[ Ok ]--4 :
        Assert.ok(spec[0]);
        return --[ () ]--0;
    case --[ Approx ]--5 :
        var b = spec[1];
        var a = spec[0];
        if (close_enough(undefined, a, b)) do
          return 0;
        end else do
          Assert.deepEqual(a, b);
          return --[ () ]--0;
        end
    case --[ ApproxThreshold ]--6 :
        var b$1 = spec[2];
        var a$1 = spec[1];
        if (close_enough(spec[0], a$1, b$1)) do
          return 0;
        end else do
          Assert.deepEqual(a$1, b$1);
          return --[ () ]--0;
        end
    case --[ ThrowAny ]--7 :
        Assert.throws(spec[0]);
        return --[ () ]--0;
    case --[ Fail ]--8 :
        return assert_fail("failed");
    case --[ FailWith ]--9 :
        return assert_fail(spec[0]);
    
  end
end

function from_pair_suites(name, suites) do
  var match = $$Array.to_list(Process.argv);
  if (match) do
    if (is_mocha(--[ () ]--0)) do
      describe(name, (function () do
              return List.iter((function (param) do
                            var code = param[1];
                            it(param[0], (function () do
                                    return handleCode(Curry._1(code, --[ () ]--0));
                                  end));
                            return --[ () ]--0;
                          end), suites);
            end));
      return --[ () ]--0;
    end else do
      var name$1 = name;
      var suites$1 = suites;
      console.log(--[ tuple ]--[
            name$1,
            "testing"
          ]);
      return List.iter((function (param) do
                    var name = param[0];
                    var match = Curry._1(param[1], --[ () ]--0);
                    switch (match.tag | 0) do
                      case --[ Eq ]--0 :
                          console.log(--[ tuple ]--[
                                name,
                                match[0],
                                "eq?",
                                match[1]
                              ]);
                          return --[ () ]--0;
                      case --[ Neq ]--1 :
                          console.log(--[ tuple ]--[
                                name,
                                match[0],
                                "neq?",
                                match[1]
                              ]);
                          return --[ () ]--0;
                      case --[ StrictEq ]--2 :
                          console.log(--[ tuple ]--[
                                name,
                                match[0],
                                "strict_eq?",
                                match[1]
                              ]);
                          return --[ () ]--0;
                      case --[ StrictNeq ]--3 :
                          console.log(--[ tuple ]--[
                                name,
                                match[0],
                                "strict_neq?",
                                match[1]
                              ]);
                          return --[ () ]--0;
                      case --[ Ok ]--4 :
                          console.log(--[ tuple ]--[
                                name,
                                match[0],
                                "ok?"
                              ]);
                          return --[ () ]--0;
                      case --[ Approx ]--5 :
                          console.log(--[ tuple ]--[
                                name,
                                match[0],
                                "~",
                                match[1]
                              ]);
                          return --[ () ]--0;
                      case --[ ApproxThreshold ]--6 :
                          console.log(--[ tuple ]--[
                                name,
                                match[1],
                                "~",
                                match[2],
                                " (",
                                match[0],
                                ")"
                              ]);
                          return --[ () ]--0;
                      case --[ ThrowAny ]--7 :
                          return --[ () ]--0;
                      case --[ Fail ]--8 :
                          console.log("failed");
                          return --[ () ]--0;
                      case --[ FailWith ]--9 :
                          console.log("failed: " .. match[0]);
                          return --[ () ]--0;
                      
                    end
                  end), suites$1);
    end
  end else do
    return --[ () ]--0;
  end
end

var val_unit = Promise.resolve(--[ () ]--0);

function from_promise_suites(name, suites) do
  var match = $$Array.to_list(Process.argv);
  if (match) do
    if (is_mocha(--[ () ]--0)) do
      describe(name, (function () do
              return List.iter((function (param) do
                            var code = param[1];
                            it(param[0], (function () do
                                    return code.then((function (x) do
                                                  handleCode(x);
                                                  return val_unit;
                                                end));
                                  end));
                            return --[ () ]--0;
                          end), suites);
            end));
      return --[ () ]--0;
    end else do
      console.log("promise suites");
      return --[ () ]--0;
    end
  end else do
    return --[ () ]--0;
  end
end

function eq_suites(test_id, suites, loc, x, y) do
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

function bool_suites(test_id, suites, loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Ok ]--Block.__(4, [x]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function throw_suites(test_id, suites, loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ ThrowAny ]--Block.__(7, [x]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

exports.from_suites = from_suites;
exports.from_pair_suites = from_pair_suites;
exports.from_promise_suites = from_promise_suites;
exports.eq_suites = eq_suites;
exports.bool_suites = bool_suites;
exports.throw_suites = throw_suites;
--[ val_unit Not a pure module ]--
