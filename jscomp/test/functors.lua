--[['use strict';]]

Curry = require "../../lib/js/curry.lua";

function O(X) do
  cow = function (x) do
    return Curry._1(X.foo, x);
  end end;
  sheep = function (x) do
    return 1 + Curry._1(X.foo, x) | 0;
  end end;
  return do
          cow: cow,
          sheep: sheep
        end;
end end

function F(X, Y) do
  cow = function (x) do
    return Curry._1(Y.foo, Curry._1(X.foo, x));
  end end;
  sheep = function (x) do
    return 1 + Curry._1(Y.foo, Curry._1(X.foo, x)) | 0;
  end end;
  return do
          cow: cow,
          sheep: sheep
        end;
end end

function F1(X, Y) do
  sheep = function (x) do
    return 1 + Curry._1(Y.foo, Curry._1(X.foo, x)) | 0;
  end end;
  return do
          sheep: sheep
        end;
end end

function F2(X, Y) do
  sheep = function (x) do
    return 1 + Curry._1(Y.foo, Curry._1(X.foo, x)) | 0;
  end end;
  return do
          sheep: sheep
        end;
end end

M = do
  F: (function (funarg, funarg$1) do
      sheep = function (x) do
        return 1 + Curry._1(funarg$1.foo, Curry._1(funarg.foo, x)) | 0;
      end end;
      return do
              sheep: sheep
            end;
    end end)
end;

exports.O = O;
exports.F = F;
exports.F1 = F1;
exports.F2 = F2;
exports.M = M;
--[[ No side effect ]]
