'use strict';

Export_keyword = require("./export_keyword.js");

function test2(v) do
  return do
          open: v.open,
          window: v.window
        end;
end

function test(p) do
  return --[ tuple ]--[
          p.catch,
          p.then
        ];
end

$$case = Export_keyword.$$case;

$$window = Export_keyword.$$window;

$$switch = Export_keyword.$$switch;

exports.test2 = test2;
exports.test = test;
exports.$$case = $$case;
exports.$$window = $$window;
exports.$$switch = $$switch;
--[ No side effect ]--
