'use strict';


function compare(x, y) do
  switch (x) do
    case --[ A ]--0 :
        return y == --[ A ]--0;
    case --[ B ]--1 :
        return y == --[ B ]--1;
    case --[ C ]--2 :
        return y == --[ C ]--2;
    
  end
end

function compare2(x, y) do
  switch (x) do
    case --[ A ]--0 :
        return y == 0;
    case --[ B ]--1 :
        return y == 1;
    case --[ C ]--2 :
        return y >= 2;
    
  end
end

function compare3(x, y) do
  return x == y;
end

exports.compare = compare;
exports.compare2 = compare2;
exports.compare3 = compare3;
--[ No side effect ]--
