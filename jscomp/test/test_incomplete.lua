console = {log = print};

Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function f(x) do
  if (x > 3 or x < 1) then do
    error({
      Caml_builtin_exceptions.match_failure,
      --[[ tuple ]]{
        "test_incomplete.ml",
        3,
        2
      }
    })
  end else do
    return --[[ "a" ]]97;
  end end 
end end

function f2(x) do
  if (x ~= nil) then do
    return 0;
  end else do
    return 1;
  end end 
end end

function f3(x) do
  local ___conditional___=(x.tag | 0);
  do
     if ___conditional___ == 0--[[ A ]]
     or ___conditional___ == 2--[[ C ]] then do
        return x[0] + 1 | 0; end end 
     if ___conditional___ == 1--[[ B ]]
     or ___conditional___ == 3--[[ D ]] then do
        return x[0] + 2 | 0; end end 
    
  end
end end

exports = {}
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
--[[ No side effect ]]
