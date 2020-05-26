'use strict';

Caml_sys = require("./caml_sys.js");
Caml_exceptions = require("./caml_exceptions.js");

match = Caml_sys.caml_sys_get_argv(--[ () ]--0);

os_type = Caml_sys.os_type(--[ () ]--0);

backend_type = --[ Other ]--["BS"];

big_endian = false;

unix = Caml_sys.os_type(--[ () ]--0) == "Unix";

win32 = Caml_sys.os_type(--[ () ]--0) == "Win32";

function getenv_opt(s) do
  match = typeof process == "undefined" and undefined or process;
  if (match ~= undefined) then do
    return match.env[s];
  end
   end 
end

interactive = do
  contents: false
end;

function set_signal(sig_num, sig_beh) do
  return --[ () ]--0;
end

Break = Caml_exceptions.create("Sys.Break");

function catch_break(on) do
  return --[ () ]--0;
end

function enable_runtime_warnings(param) do
  return --[ () ]--0;
end

function runtime_warnings_enabled(param) do
  return false;
end

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

exports.argv = argv;
exports.executable_name = executable_name;
exports.getenv_opt = getenv_opt;
exports.interactive = interactive;
exports.os_type = os_type;
exports.backend_type = backend_type;
exports.unix = unix;
exports.win32 = win32;
exports.cygwin = cygwin;
exports.word_size = word_size;
exports.int_size = int_size;
exports.big_endian = big_endian;
exports.max_string_length = max_string_length;
exports.max_array_length = max_array_length;
exports.set_signal = set_signal;
exports.sigabrt = sigabrt;
exports.sigalrm = sigalrm;
exports.sigfpe = sigfpe;
exports.sighup = sighup;
exports.sigill = sigill;
exports.sigint = sigint;
exports.sigkill = sigkill;
exports.sigpipe = sigpipe;
exports.sigquit = sigquit;
exports.sigsegv = sigsegv;
exports.sigterm = sigterm;
exports.sigusr1 = sigusr1;
exports.sigusr2 = sigusr2;
exports.sigchld = sigchld;
exports.sigcont = sigcont;
exports.sigstop = sigstop;
exports.sigtstp = sigtstp;
exports.sigttin = sigttin;
exports.sigttou = sigttou;
exports.sigvtalrm = sigvtalrm;
exports.sigprof = sigprof;
exports.sigbus = sigbus;
exports.sigpoll = sigpoll;
exports.sigsys = sigsys;
exports.sigtrap = sigtrap;
exports.sigurg = sigurg;
exports.sigxcpu = sigxcpu;
exports.sigxfsz = sigxfsz;
exports.Break = Break;
exports.catch_break = catch_break;
exports.ocaml_version = ocaml_version;
exports.enable_runtime_warnings = enable_runtime_warnings;
exports.runtime_warnings_enabled = runtime_warnings_enabled;
--[ No side effect ]--
