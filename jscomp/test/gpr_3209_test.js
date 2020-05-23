'use strict';


function f9(param) do
  if (typeof param == "number") do
    switch (param) do
      case --[ T60 ]--0 :
      case --[ T61 ]--1 :
      case --[ T62 ]--2 :
          return 1;
      default:
        return 3;
    end
  end else do
    switch (param.tag | 0) do
      case --[ T64 ]--0 :
      case --[ T65 ]--1 :
          return 2;
      default:
        return 3;
    end
  end
end

exports.f9 = f9;
--[ No side effect ]--
