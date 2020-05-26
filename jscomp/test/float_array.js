'use strict';


function small_float_array(x) do
  return --[ tuple ]--[
          [
            1,
            2,
            3
          ],
          x
        ];
end end

function longer_float_array(x) do
  return --[ tuple ]--[
          [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            0
          ],
          x
        ];
end end

exports.small_float_array = small_float_array;
exports.longer_float_array = longer_float_array;
--[ No side effect ]--
