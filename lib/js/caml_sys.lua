__console = {log = print};

Caml_builtin_exceptions = require "..caml_builtin_exceptions";

function caml_sys_getenv(s) do
  if (type(process) == "undefined" or process.env == nil) then do
    error(Caml_builtin_exceptions.not_found)
  end
   end 
  match = process.env[s];
  if (match ~= nil) then do
    return match;
  end else do
    error(Caml_builtin_exceptions.not_found)
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
  if (type(process) == "undefined" or process.uptime == nil) then do
    return -1;
  end else do
    return process.uptime();
  end end 
end end

function caml_sys_random_seed(param) do
  return {((__Date.now() | 0) ^ 4294967295) * __Math.random() | 0};
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
  if (type(process) == "undefined") then do
    return --[[ tuple ]]{
            "",
            {""}
          };
  end else do
    argv = process.argv;
    if (argv == nil) then do
      return --[[ tuple ]]{
              "",
              {""}
            };
    end else do
      return --[[ tuple ]]{
              argv[0],
              argv
            };
    end end 
  end end 
end end

function caml_sys_exit(exit_code) do
  if (type(process) ~= "undefined") then do
    return process.exit(exit_code);
  end else do
    return 0;
  end end 
end end

function caml_sys_is_directory(_s) do
  error({
    Caml_builtin_exceptions.failure,
    "caml_sys_is_directory not implemented"
  })
end end

function caml_sys_file_exists(_s) do
  error({
    Caml_builtin_exceptions.failure,
    "caml_sys_file_exists not implemented"
  })
end end

exports = {};
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
return exports;
--[[ No side effect ]]
