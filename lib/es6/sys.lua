

import * as Caml_sys from "./caml_sys.lua";
import * as Caml_exceptions from "./caml_exceptions.lua";

match = Caml_sys.caml_sys_get_argv(--[[ () ]]0);

os_type = Caml_sys.os_type(--[[ () ]]0);

backend_type = --[[ Other ]]["BS"];

big_endian = false;

unix = Caml_sys.os_type(--[[ () ]]0) == "Unix";

win32 = Caml_sys.os_type(--[[ () ]]0) == "Win32";

function getenv_opt(s) do
  match = typeof process == "undefined" and undefined or process;
  if (match ~= undefined) then do
    return match.env[s];
  end
   end 
end end

interactive = do
  contents: false
end;

function set_signal(sig_num, sig_beh) do
  return --[[ () ]]0;
end end

Break = Caml_exceptions.create("Sys.Break");

function catch_break(on) do
  return --[[ () ]]0;
end end

function enable_runtime_warnings(param) do
  return --[[ () ]]0;
end end

function runtime_warnings_enabled(param) do
  return false;
end end

argv = match[1];

executable_name = match[0];

cygwin = false;

word_size = 32;

int_size = 32;

max_string_length = 2147483647;

max_array_length = 2147483647;

sigabrt = -1;

sigalrm = -2;

sigfpe = -3;

sighup = -4;

sigill = -5;

sigint = -6;

sigkill = -7;

sigpipe = -8;

sigquit = -9;

sigsegv = -10;

sigterm = -11;

sigusr1 = -12;

sigusr2 = -13;

sigchld = -14;

sigcont = -15;

sigstop = -16;

sigtstp = -17;

sigttin = -18;

sigttou = -19;

sigvtalrm = -20;

sigprof = -21;

sigbus = -22;

sigpoll = -23;

sigsys = -24;

sigtrap = -25;

sigurg = -26;

sigxcpu = -27;

sigxfsz = -28;

ocaml_version = "4.06.2+BS";

export do
  argv ,
  executable_name ,
  getenv_opt ,
  interactive ,
  os_type ,
  backend_type ,
  unix ,
  win32 ,
  cygwin ,
  word_size ,
  int_size ,
  big_endian ,
  max_string_length ,
  max_array_length ,
  set_signal ,
  sigabrt ,
  sigalrm ,
  sigfpe ,
  sighup ,
  sigill ,
  sigint ,
  sigkill ,
  sigpipe ,
  sigquit ,
  sigsegv ,
  sigterm ,
  sigusr1 ,
  sigusr2 ,
  sigchld ,
  sigcont ,
  sigstop ,
  sigtstp ,
  sigttin ,
  sigttou ,
  sigvtalrm ,
  sigprof ,
  sigbus ,
  sigpoll ,
  sigsys ,
  sigtrap ,
  sigurg ,
  sigxcpu ,
  sigxfsz ,
  Break ,
  catch_break ,
  ocaml_version ,
  enable_runtime_warnings ,
  runtime_warnings_enabled ,
  
end
--[[ No side effect ]]
