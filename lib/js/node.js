'use strict';


function test(x) do
  if (typeof x == "string") do
    return --[ tuple ]--[
            --[ String ]--0,
            x
          ];
  end else do
    return --[ tuple ]--[
            --[ Buffer ]--1,
            x
          ];
  end
end

var Path = --[ alias ]--0;

var Fs = --[ alias ]--0;

var Process = --[ alias ]--0;

var Module = --[ alias ]--0;

var $$Buffer = --[ alias ]--0;

var Child_process = --[ alias ]--0;

exports.Path = Path;
exports.Fs = Fs;
exports.Process = Process;
exports.Module = Module;
exports.$$Buffer = $$Buffer;
exports.Child_process = Child_process;
exports.test = test;
--[ No side effect ]--
