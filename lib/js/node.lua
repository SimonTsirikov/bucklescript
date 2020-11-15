__console = {log = print};


function test(x) do
  if (type(x) == "string") then do
    return --[[ tuple ]]{
            --[[ String ]]0,
            x
          };
  end else do
    return --[[ tuple ]]{
            --[[ Buffer ]]1,
            x
          };
  end end 
end end

Path = --[[ alias ]]0;

Fs = --[[ alias ]]0;

Process = --[[ alias ]]0;

Module = --[[ alias ]]0;

__Buffer = --[[ alias ]]0;

Child_process = --[[ alias ]]0;

exports = {};
exports.Path = Path;
exports.Fs = Fs;
exports.Process = Process;
exports.Module = Module;
exports.__Buffer = __Buffer;
exports.Child_process = Child_process;
exports.test = test;
return exports;
--[[ No side effect ]]
