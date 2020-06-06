console = {log = print};

Fs = require "";

function test(path) do
  Fs.watch(path, {
            recursive = true
          }).on("change", (function(__event, string_buffer) do
            console.log(--[[ tuple ]]{
                  __event,
                  string_buffer
                });
            return --[[ () ]]0;
          end end)).close();
  return --[[ () ]]0;
end end

exports = {}
exports.test = test;
--[[ fs Not a pure module ]]
