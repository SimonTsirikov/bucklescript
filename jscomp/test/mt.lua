__console = {log = print};

List = require "......lib.js.list";
Path = require "path";
__Array = require "......lib.js.array";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Assert = require "as";
Process = require "pro";

function assert_fail(msg) do
  Assert.fail(--[[ () ]]0, --[[ () ]]0, msg, "");
  return --[[ () ]]0;
end end

function is_mocha(param) do
  match = __Array.to_list(Process.argv);
  if (match) then do
    match_1 = match[2];
    if (match_1) then do
      exec = Path.basename(match_1[1]);
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
    describe(name, (function() do
            return List.iter((function(param) do
                          partial_arg = param[2];
                          it(param[1], (function() do
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
  threshold = thresholdOpt ~= nil and thresholdOpt or 0.0000001;
  return __Math.abs(a - b) < threshold;
end end

function handleCode(spec) do
  local ___conditional___=(spec.tag | 0);
  do
     if ___conditional___ == 0--[[ Eq ]] then do
        Assert.deepEqual(spec[1], spec[2]);
        return --[[ () ]]0; end end 
     if ___conditional___ == 1--[[ Neq ]] then do
        Assert.notDeepEqual(spec[1], spec[2]);
        return --[[ () ]]0; end end 
     if ___conditional___ == 2--[[ StrictEq ]] then do
        Assert.strictEqual(spec[1], spec[2]);
        return --[[ () ]]0; end end 
     if ___conditional___ == 3--[[ StrictNeq ]] then do
        Assert.notStrictEqual(spec[1], spec[2]);
        return --[[ () ]]0; end end 
     if ___conditional___ == 4--[[ Ok ]] then do
        Assert.ok(spec[1]);
        return --[[ () ]]0; end end 
     if ___conditional___ == 5--[[ Approx ]] then do
        b = spec[2];
        a = spec[1];
        if (close_enough(nil, a, b)) then do
          return 0;
        end else do
          Assert.deepEqual(a, b);
          return --[[ () ]]0;
        end end  end end 
     if ___conditional___ == 6--[[ ApproxThreshold ]] then do
        b_1 = spec[3];
        a_1 = spec[2];
        if (close_enough(spec[1], a_1, b_1)) then do
          return 0;
        end else do
          Assert.deepEqual(a_1, b_1);
          return --[[ () ]]0;
        end end  end end 
     if ___conditional___ == 7--[[ ThrowAny ]] then do
        Assert.throws(spec[1]);
        return --[[ () ]]0; end end 
     if ___conditional___ == 8--[[ Fail ]] then do
        return assert_fail("failed"); end end 
     if ___conditional___ == 9--[[ FailWith ]] then do
        return assert_fail(spec[1]); end end 
    
  end
end end

function from_pair_suites(name, suites) do
  match = __Array.to_list(Process.argv);
  if (match) then do
    if (is_mocha(--[[ () ]]0)) then do
      describe(name, (function() do
              return List.iter((function(param) do
                            code = param[2];
                            it(param[1], (function() do
                                    return handleCode(Curry._1(code, --[[ () ]]0));
                                  end end));
                            return --[[ () ]]0;
                          end end), suites);
            end end));
      return --[[ () ]]0;
    end else do
      name_1 = name;
      suites_1 = suites;
      __console.log(--[[ tuple ]]{
            name_1,
            "testing"
          });
      return List.iter((function(param) do
                    name = param[1];
                    match = Curry._1(param[2], --[[ () ]]0);
                    local ___conditional___=(match.tag | 0);
                    do
                       if ___conditional___ == 0--[[ Eq ]] then do
                          __console.log(--[[ tuple ]]{
                                name,
                                match[1],
                                "eq?",
                                match[2]
                              });
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 1--[[ Neq ]] then do
                          __console.log(--[[ tuple ]]{
                                name,
                                match[1],
                                "neq?",
                                match[2]
                              });
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 2--[[ StrictEq ]] then do
                          __console.log(--[[ tuple ]]{
                                name,
                                match[1],
                                "strict_eq?",
                                match[2]
                              });
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 3--[[ StrictNeq ]] then do
                          __console.log(--[[ tuple ]]{
                                name,
                                match[1],
                                "strict_neq?",
                                match[2]
                              });
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 4--[[ Ok ]] then do
                          __console.log(--[[ tuple ]]{
                                name,
                                match[1],
                                "ok?"
                              });
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 5--[[ Approx ]] then do
                          __console.log(--[[ tuple ]]{
                                name,
                                match[1],
                                "~",
                                match[2]
                              });
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 6--[[ ApproxThreshold ]] then do
                          __console.log(--[[ tuple ]]{
                                name,
                                match[2],
                                "~",
                                match[3],
                                " (",
                                match[1],
                                ")"
                              });
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 7--[[ ThrowAny ]] then do
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 8--[[ Fail ]] then do
                          __console.log("failed");
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 9--[[ FailWith ]] then do
                          __console.log("failed: " .. match[1]);
                          return --[[ () ]]0; end end 
                      
                    end
                  end end), suites_1);
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

val_unit = __Promise.resolve(--[[ () ]]0);

function from_promise_suites(name, suites) do
  match = __Array.to_list(Process.argv);
  if (match) then do
    if (is_mocha(--[[ () ]]0)) then do
      describe(name, (function() do
              return List.iter((function(param) do
                            code = param[2];
                            it(param[1], (function() do
                                    return code.__then((function(x) do
                                                  handleCode(x);
                                                  return val_unit;
                                                end end));
                                  end end));
                            return --[[ () ]]0;
                          end end), suites);
            end end));
      return --[[ () ]]0;
    end else do
      __console.log("promise suites");
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

function bool_suites(test_id, suites, loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
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
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ ThrowAny ]]Block.__(7, {x});
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

exports = {};
exports.from_suites = from_suites;
exports.from_pair_suites = from_pair_suites;
exports.from_promise_suites = from_promise_suites;
exports.eq_suites = eq_suites;
exports.bool_suites = bool_suites;
exports.throw_suites = throw_suites;
return exports;
--[[ val_unit Not a pure module ]]
