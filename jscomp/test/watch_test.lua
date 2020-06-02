--[['use strict';]]

Fs = require "";

function test(path) do
  Fs.watch(path, do
            recursive: true
          end).on("change", (function (__event, string_buffer) do
            console.log(--[[ tuple ]]{
                  __event,
                  string_buffer
                });
            return --[[ () ]]0;
          end end)).close();
  return --[[ () ]]0;
end end

exports.test = test;
--[[ fs Not a pure module ]]
