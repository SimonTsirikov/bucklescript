__console = {log = print};

Sys = require "......lib.js.sys";

is_windows_or_cygwin = Sys.win32 or false;

exports = {};
exports.is_windows_or_cygwin = is_windows_or_cygwin;
return exports;
--[[ No side effect ]]
