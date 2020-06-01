'use strict';

Caml_builtin_exceptions = require("./caml_builtin_exceptions.lua");

function caml_sys_getenv(s) do
  if (typeof process == "undefined" or process.env == undefined) then do
    throw Caml_builtin_exceptions.not_found;
  end
   end 
  match = process.env[s];
  if (match ~= undefined) then do
    return match;
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end 
end end

os_type = (function(_){
  if(typeof process !== 'undefined' && process.platform === 'win32'){
        return "Win32"    
  }
  else {
    return "Unix"
  }
});

function caml_sys_time(param) do
  if (typeof process == "undefined" or process.uptime == undefined) then do
    return -1;
  end else do
    return process.uptime();
  end end 
end end

function caml_sys_random_seed(param) do
  return [((Date.now() | 0) ^ 4294967295) * Math.random() | 0];
end end

function caml_sys_system_command(_cmd) do
  return 127;
end end

caml_sys_getcwd = (function(param){
    if (typeof process === "undefined" || process.cwd === undefined){
      return "/"  
    }
    return process.cwd()
  });

function caml_sys_get_argv(param) do
  if (typeof process == "undefined") then do
    return --[[ tuple ]][
            "",
            [""]
          ];
  end else do
    argv = process.argv;
    if (argv == null) then do
      return --[[ tuple ]][
              "",
              [""]
            ];
    end else do
      return --[[ tuple ]][
              argv[0],
              argv
            ];
    end end 
  end end 
end end

function caml_sys_exit(exit_code) do
  if (typeof process ~= "undefined") then do
    return process.exit(exit_code);
  end else do
    return 0;
  end end 
end end

function caml_sys_is_directory(_s) do
  throw [
        Caml_builtin_exceptions.failure,
        "caml_sys_is_directory not implemented"
      ];
end end

function caml_sys_file_exists(_s) do
  throw [
        Caml_builtin_exceptions.failure,
        "caml_sys_file_exists not implemented"
      ];
end end

exports.caml_sys_getenv = caml_sys_getenv;
exports.caml_sys_time = caml_sys_time;
exports.os_type = os_type;
exports.caml_sys_random_seed = caml_sys_random_seed;
exports.caml_sys_system_command = caml_sys_system_command;
exports.caml_sys_getcwd = caml_sys_getcwd;
exports.caml_sys_get_argv = caml_sys_get_argv;
exports.caml_sys_exit = caml_sys_exit;
exports.caml_sys_is_directory = caml_sys_is_directory;
exports.caml_sys_file_exists = caml_sys_file_exists;
--[[ No side effect ]]
