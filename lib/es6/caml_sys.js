

import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function caml_sys_getenv(s) do
  if (typeof process == "undefined" or process.env == undefined) do
    throw Caml_builtin_exceptions.not_found;
  end
  var match = process.env[s];
  if (match ~= undefined) do
    return match;
  end else do
    throw Caml_builtin_exceptions.not_found;
  end
end

var os_type = (function(_){
  if(typeof process !== 'undefined' && process.platform === 'win32'){
        return "Win32"    
  }
  else {
    return "Unix"
  }
});

function caml_sys_time(param) do
  if (typeof process == "undefined" or process.uptime == undefined) do
    return -1;
  end else do
    return process.uptime();
  end
end

function caml_sys_random_seed(param) do
  return [((Date.now() | 0) ^ 4294967295) * Math.random() | 0];
end

function caml_sys_system_command(_cmd) do
  return 127;
end

var caml_sys_getcwd = (function(param){
    if (typeof process === "undefined" || process.cwd === undefined){
      return "/"  
    }
    return process.cwd()
  });

function caml_sys_get_argv(param) do
  if (typeof process == "undefined") do
    return --[ tuple ]--[
            "",
            [""]
          ];
  end else do
    var argv = process.argv;
    if (argv == null) do
      return --[ tuple ]--[
              "",
              [""]
            ];
    end else do
      return --[ tuple ]--[
              argv[0],
              argv
            ];
    end
  end
end

function caml_sys_exit(exit_code) do
  if (typeof process ~= "undefined") do
    return process.exit(exit_code);
  end else do
    return 0;
  end
end

function caml_sys_is_directory(_s) do
  throw [
        Caml_builtin_exceptions.failure,
        "caml_sys_is_directory not implemented"
      ];
end

function caml_sys_file_exists(_s) do
  throw [
        Caml_builtin_exceptions.failure,
        "caml_sys_file_exists not implemented"
      ];
end

export do
  caml_sys_getenv ,
  caml_sys_time ,
  os_type ,
  caml_sys_random_seed ,
  caml_sys_system_command ,
  caml_sys_getcwd ,
  caml_sys_get_argv ,
  caml_sys_exit ,
  caml_sys_is_directory ,
  caml_sys_file_exists ,
  
end
--[ No side effect ]--
