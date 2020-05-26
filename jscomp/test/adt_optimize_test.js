'use strict';

Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(x) do
  return x + 1 | 0;
end end

function f_0(x) do
  return x - 1 | 0;
end end

function f2(param) do
  if (param >= 3) then do
    return --[ T003 ]--3;
  end else do
    return param;
  end end 
end end

function f3(param) do
  return param;
end end

function f4(param) do
  return 3;
end end

function f5(param) do
  if (typeof param == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ = 0--[ A ]-- then do
          return 1;end end end 
       if ___conditional___ = 1--[ B ]-- then do
          return 3;end end end 
       if ___conditional___ = 2--[ F ]-- then do
          return 4;end end end 
       do
      
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[ C ]--
       or ___conditional___ = 1--[ D ]-- then do
          return 1;end end end 
       if ___conditional___ = 2--[ E ]-- then do
          return 2;end end end 
       do
      
    end
  end end 
end end

function f6(param) do
  if (typeof param == "number") then do
    if (param >= 2) then do
      return 2;
    end else do
      return 0;
    end end 
  end else do
    return 1;
  end end 
end end

function f7(param) do
  if (typeof param == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ = 0--[ A ]-- then do
          return 1;end end end 
       if ___conditional___ = 1--[ B ]-- then do
          return 2;end end end 
       if ___conditional___ = 2--[ F ]-- then do
          return -1;end end end 
       do
      
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[ C ]-- then do
          return 3;end end end 
       if ___conditional___ = 1--[ D ]-- then do
          return 4;end end end 
       if ___conditional___ = 2--[ E ]-- then do
          return -1;end end end 
       do
      
    end
  end end 
end end

function f8(param) do
  if (typeof param == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ = 0--[ T60 ]--
       or ___conditional___ = 1--[ T61 ]-- then do
          return 1;end end end 
       do
      else do
        return 3;
        end end
        
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[ T64 ]--
       or ___conditional___ = 1--[ T65 ]-- then do
          return 2;end end end 
       do
      else do
        return 3;
        end end
        
    end
  end end 
end end

function f9(param) do
  if (typeof param == "number") then do
    if (param == --[ T63 ]--3) then do
      return 3;
    end else do
      return 1;
    end end 
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[ T64 ]--
       or ___conditional___ = 1--[ T65 ]-- then do
          return 2;end end end 
       if ___conditional___ = 2--[ T66 ]--
       or ___conditional___ = 3--[ T68 ]-- then do
          return 3;end end end 
       do
      
    end
  end end 
end end

function f10(param) do
  if (typeof param == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ = 0--[ T60 ]-- then do
          return 0;end end end 
       if ___conditional___ = 1--[ T61 ]-- then do
          return 2;end end end 
       if ___conditional___ = 2--[ T62 ]-- then do
          return 4;end end end 
       if ___conditional___ = 3--[ T63 ]-- then do
          return 1;end end end 
       do
      
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[ T64 ]--
       or ___conditional___ = 1--[ T65 ]-- then do
          return 2;end end end 
       if ___conditional___ = 2--[ T66 ]--
       or ___conditional___ = 3--[ T68 ]-- then do
          return 3;end end end 
       do
      
    end
  end end 
end end

function f11(x) do
  if (typeof x == "number") then do
    return 2;
  end else if (x.tag) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "adt_optimize_test.ml",
            191,
            9
          ]
        ];
  end else do
    return 1;
  end end  end 
end end

exports.f = f;
exports.f_0 = f_0;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.f8 = f8;
exports.f9 = f9;
exports.f10 = f10;
exports.f11 = f11;
--[ No side effect ]--
