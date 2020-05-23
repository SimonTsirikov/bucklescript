'use strict';

var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function bool_equal(x, y) do
  if (x) then do
    if (y) then do
      return true;
    end else do
      return false;
    end end 
  end else if (y) then do
    return false;
  end else do
    return true;
  end end  end 
end

function assertions(param) do
  if (!bool_equal(true, true)) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_bool_equal.ml",
            21,
            2
          ]
        ];
  end
   end 
  if (!bool_equal(false, false)) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_bool_equal.ml",
            22,
            2
          ]
        ];
  end
   end 
  if (bool_equal(true, false)) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_bool_equal.ml",
            23,
            2
          ]
        ];
  end
   end 
  if (bool_equal(false, true)) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_bool_equal.ml",
            24,
            2
          ]
        ];
  end
   end 
  return 0;
end

function f0(x) do
  if (x == true) then do
    return 1;
  end else do
    return 2;
  end end 
end

function f1(x) do
  if (x ~= true) then do
    return 1;
  end else do
    return 2;
  end end 
end

function f2(x) do
  if (x == true) then do
    return 1;
  end else do
    return 2;
  end end 
end

function f3(x) do
  if (x == false) then do
    return 1;
  end else do
    return 2;
  end end 
end

function f4(x) do
  if (x ~= true) then do
    return 1;
  end else do
    return 2;
  end end 
end

function f5(x) do
  if (x) then do
    return 2;
  end else do
    return 1;
  end end 
end

function f6(x) do
  if (x == --[ [] ]--0) then do
    return 1;
  end else do
    return 2;
  end end 
end

function f7(x) do
  if (#x ~= 0) then do
    return 1;
  end else do
    return 2;
  end end 
end

function f8(x) do
  return 1;
end

exports.bool_equal = bool_equal;
exports.assertions = assertions;
exports.f0 = f0;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.f8 = f8;
--[ No side effect ]--
