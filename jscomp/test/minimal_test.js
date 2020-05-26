'use strict';


fake_y = --[ :: ]--[
  2,
  --[ :: ]--[
    3,
    --[ [] ]--0
  ]
];

fake_z = --[ :: ]--[
  1,
  fake_y
];

exports.fake_y = fake_y;
exports.fake_z = fake_z;
--[ No side effect ]--
