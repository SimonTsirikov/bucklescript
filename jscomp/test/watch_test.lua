__console = {log = print};

Fs = require "fs";

function test(path) do
  Fs.watch(path, {
            recursive = true
          }).on("change", (function(__event, string_buffer) do
            __console.log(--[[ tuple ]]{
                  __event,
                  string_buffer
                });
            return --[[ () ]]0;
          end end)).close();
  return --[[ () ]]0;
end end

exports = {};
exports.test = test;
return exports;
--[[ fs Not a pure module ]]
