'use strict';

Sys = require("../../lib/js/sys.js");

is_windows_or_cygwin = Sys.win32 or false;

exports.is_windows_or_cygwin = is_windows_or_cygwin;
--[ No side effect ]--
