--[['use strict';]]

List = require "../../lib/js/list.lua";
Path = require "path";
__Array = require "../../lib/js/array.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Assert = require "assert";
Process = require "process";

function assert_fail(msg) do
  Assert.fail(--[[ () ]]0, --[[ () ]]0, msg, "");
  return --[[ () ]]0;
end end

function is_mocha(param) do
  match = __Array.to_list(Process.argv);
  if (match) then do
    match$1 = match[1];
    if (match$1) then do
      exec = Path.basename(match$1[0]);
      if (exec == "mocha") then do
        return true;
      end else do
        return exec == "_mocha";
      end end 
    end else do
      return false;
    end end 
  end else do
    return false;
  end end 
end end

function from_suites(name, suite) do
  match = __Array.to_list(Process.argv);
  if (match and is_mocha(--[[ () ]]0)) then do
    describe(name, (function () do
            return List.iter((function (param) do
                          partial_arg = param[1];
                          it(param[0], (function () do
                                  return Curry._1(partial_arg, --[[ () ]]0);
                                end end));
                          return --[[ () ]]0;
                        end end), suite);
          end end));
    return --[[ () ]]0;
  end else do
    return --[[ () ]]0;
  end end 
end end

function close_enough(thresholdOpt, a, b) do
  threshold = thresholdOpt ~= undefined and thresholdOpt or 0.0000001;
  return Math.abs(a - b) < threshold;
end end

function handleCode(spec) do
  local ___conditional___=(spec.tag | 0);
  do
     if ___conditional___ = 0--[[ Eq ]] then do
        Assert.deepEqual(spec[0], spec[1]);
        return --[[ () ]]0;end end end 
     if ___conditional___ = 1--[[ Neq ]] then do
        Assert.notDeepEqual(spec[0], spec[1]);
        return --[[ () ]]0;end end end 
     if ___conditional___ = 2--[[ StrictEq ]] then do
        Assert.strictEqual(spec[0], spec[1]);
        return --[[ () ]]0;end end end 
     if ___conditional___ = 3--[[ StrictNeq ]] then do
        Assert.notStrictEqual(spec[0], spec[1]);
        return --[[ () ]]0;end end end 
     if ___conditional___ = 4--[[ Ok ]] then do
        Assert.ok(spec[0]);
        return --[[ () ]]0;end end end 
     if ___conditional___ = 5--[[ Approx ]] then do
        b = spec[1];
        a = spec[0];
        if (close_enough(undefined, a, b)) then do
          return 0;
        end else do
          Assert.deepEqual(a, b);
          return --[[ () ]]0;
        end end end end end 
     if ___conditional___ = 6--[[ ApproxThreshold ]] then do
        b$1 = spec[2];
        a$1 = spec[1];
        if (close_enough(spec[0], a$1, b$1)) then do
          return 0;
        end else do
          Assert.deepEqual(a$1, b$1);
          return --[[ () ]]0;
        end end end end end 
     if ___conditional___ = 7--[[ ThrowAny ]] then do
        Assert.throws(spec[0]);
        return --[[ () ]]0;end end end 
     if ___conditional___ = 8--[[ Fail ]] then do
        return assert_fail("failed");end end end 
     if ___conditional___ = 9--[[ FailWith ]] then do
        return assert_fail(spec[0]);end end end 
     do
    
  end
end end

function from_pair_suites(name, suites) do
  match = __Array.to_list(Process.argv);
  if (match) then do
    if (is_mocha(--[[ () ]]0)) then do
      describe(name, (function () do
              return List.iter((function (param) do
                            code = param[1];
                            it(param[0], (function () do
                                    return handleCode(Curry._1(code, --[[ () ]]0));
                                  end end));
                            return --[[ () ]]0;
                          end end), suites);
            end end));
      return --[[ () ]]0;
    end else do
      name$1 = name;
      suites$1 = suites;
      console.log(--[[ tuple ]]{
            name$1,
            "testing"
          });
      return List.iter((function (param) do
                    name = param[0];
                    match = Curry._1(param[1], --[[ () ]]0);
                    local ___conditional___=(match.tag | 0);
                    do
                       if ___conditional___ = 0--[[ Eq ]] then do
                          console.log(--[[ tuple ]]{
                                name,
                                match[0],
                                "eq?",
                                match[1]
                              });
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 1--[[ Neq ]] then do
                          console.log(--[[ tuple ]]{
                                name,
                                match[0],
                                "neq?",
                                match[1]
                              });
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 2--[[ StrictEq ]] then do
                          console.log(--[[ tuple ]]{
                                name,
                                match[0],
                                "strict_eq?",
                                match[1]
                              });
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 3--[[ StrictNeq ]] then do
                          console.log(--[[ tuple ]]{
                                name,
                                match[0],
                                "strict_neq?",
                                match[1]
                              });
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 4--[[ Ok ]] then do
                          console.log(--[[ tuple ]]{
                                name,
                                match[0],
                                "ok?"
                              });
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 5--[[ Approx ]] then do
                          console.log(--[[ tuple ]]{
                                name,
                                match[0],
                                "~",
                                match[1]
                              });
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 6--[[ ApproxThreshold ]] then do
                          console.log(--[[ tuple ]]{
                                name,
                                match[1],
                                "~",
                                match[2],
                                " (",
                                match[0],
                                ")"
                              });
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 7--[[ ThrowAny ]] then do
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 8--[[ Fail ]] then do
                          console.log("failed");
                          return --[[ () ]]0;end end end 
                       if ___conditional___ = 9--[[ FailWith ]] then do
                          console.log("failed: " .. match[0]);
                          return --[[ () ]]0;end end end 
                       do
                      
                    end
                  end end), suites$1);
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

val_unit = Promise.resolve(--[[ () ]]0);

function from_promise_suites(name, suites) do
  match = __Array.to_list(Process.argv);
  if (match) then do
    if (is_mocha(--[[ () ]]0)) then do
      describe(name, (function () do
              return List.iter((function (param) do
                            code = param[1];
                            it(param[0], (function () do
                                    return code.then((function (x) do
                                                  handleCode(x);
                                                  return val_unit;
                                                end end));
                                  end end));
                            return --[[ () ]]0;
                          end end), suites);
            end end));
      return --[[ () ]]0;
    end else do
      console.log("promise suites");
      return --[[ () ]]0;
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function eq_suites(test_id, suites, loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
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

function bool_suites(test_id, suites, loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Ok ]]Block.__(4, {x});
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function throw_suites(test_id, suites, loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ ThrowAny ]]Block.__(7, {x});
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

exports.from_suites = from_suites;
exports.from_pair_suites = from_pair_suites;
exports.from_promise_suites = from_promise_suites;
exports.eq_suites = eq_suites;
exports.bool_suites = bool_suites;
exports.throw_suites = throw_suites;
--[[ val_unit Not a pure module ]]
