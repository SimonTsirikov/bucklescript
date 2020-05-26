'use strict';

Fs = require("fs");

function test(path) do
  Fs.watch(path, do
            recursive: true
          end).on("change", (function ($$event, string_buffer) do
            console.log(--[ tuple ]--[
                  $$event,
                  string_buffer
                ]);
            return --[ () ]--0;
          end end)).close();
  return --[ () ]--0;
end end

exports.test = test;
--[ fs Not a pure module ]--
