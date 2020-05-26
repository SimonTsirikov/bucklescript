'use strict';

Unix = require("./unix.js");

Unix_error = Unix.Unix_error;

error_message = Unix.error_message;

handle_unix_error = Unix.handle_unix_error;

environment = Unix.environment;

getenv = Unix.getenv;

unsafe_getenv = Unix.unsafe_getenv;

putenv = Unix.putenv;

execv = Unix.execv;

execve = Unix.execve;

execvp = Unix.execvp;

execvpe = Unix.execvpe;

fork = Unix.fork;

wait = Unix.wait;

waitpid = Unix.waitpid;

system = Unix.system;

getpid = Unix.getpid;

getppid = Unix.getppid;

nice = Unix.nice;

stdin = Unix.stdin;

stdout = Unix.stdout;

stderr = Unix.stderr;

openfile = Unix.openfile;

close = Unix.close;

read = Unix.read;

write = Unix.write;

single_write = Unix.single_write;

write_substring = Unix.write_substring;

single_write_substring = Unix.single_write_substring;

in_channel_of_descr = Unix.in_channel_of_descr;

out_channel_of_descr = Unix.out_channel_of_descr;

descr_of_in_channel = Unix.descr_of_in_channel;

descr_of_out_channel = Unix.descr_of_out_channel;

lseek = Unix.lseek;

truncate = Unix.truncate;

ftruncate = Unix.ftruncate;

stat = Unix.stat;

lstat = Unix.lstat;

fstat = Unix.fstat;

isatty = Unix.isatty;

LargeFile = Unix.LargeFile;

map_file = Unix.map_file;

unlink = Unix.unlink;

rename = Unix.rename;

link = Unix.link;

chmod = Unix.chmod;

fchmod = Unix.fchmod;

chown = Unix.chown;

fchown = Unix.fchown;

umask = Unix.umask;

access = Unix.access;

dup = Unix.dup;

dup2 = Unix.dup2;

set_nonblock = Unix.set_nonblock;

clear_nonblock = Unix.clear_nonblock;

set_close_on_exec = Unix.set_close_on_exec;

clear_close_on_exec = Unix.clear_close_on_exec;

mkdir = Unix.mkdir;

rmdir = Unix.rmdir;

chdir = Unix.chdir;

getcwd = Unix.getcwd;

chroot = Unix.chroot;

opendir = Unix.opendir;

readdir = Unix.readdir;

rewinddir = Unix.rewinddir;

closedir = Unix.closedir;

pipe = Unix.pipe;

mkfifo = Unix.mkfifo;

create_process = Unix.create_process;

create_process_env = Unix.create_process_env;

open_process_in = Unix.open_process_in;

open_process_out = Unix.open_process_out;

open_process = Unix.open_process;

open_process_full = Unix.open_process_full;

close_process_in = Unix.close_process_in;

close_process_out = Unix.close_process_out;

close_process = Unix.close_process;

close_process_full = Unix.close_process_full;

symlink = Unix.symlink;

has_symlink = Unix.has_symlink;

readlink = Unix.readlink;

select = Unix.select;

lockf = Unix.lockf;

kill = Unix.kill;

sigprocmask = Unix.sigprocmask;

sigpending = Unix.sigpending;

sigsuspend = Unix.sigsuspend;

pause = Unix.pause;

time = Unix.time;

gettimeofday = Unix.gettimeofday;

gmtime = Unix.gmtime;

localtime = Unix.localtime;

mktime = Unix.mktime;

alarm = Unix.alarm;

sleep = Unix.sleep;

times = Unix.times;

utimes = Unix.utimes;

getitimer = Unix.getitimer;

setitimer = Unix.setitimer;

getuid = Unix.getuid;

geteuid = Unix.geteuid;

setuid = Unix.setuid;

getgid = Unix.getgid;

getegid = Unix.getegid;

setgid = Unix.setgid;

getgroups = Unix.getgroups;

setgroups = Unix.setgroups;

initgroups = Unix.initgroups;

getlogin = Unix.getlogin;

getpwnam = Unix.getpwnam;

getgrnam = Unix.getgrnam;

getpwuid = Unix.getpwuid;

getgrgid = Unix.getgrgid;

inet_addr_of_string = Unix.inet_addr_of_string;

string_of_inet_addr = Unix.string_of_inet_addr;

inet_addr_any = Unix.inet_addr_any;

inet_addr_loopback = Unix.inet_addr_loopback;

inet6_addr_any = Unix.inet6_addr_any;

inet6_addr_loopback = Unix.inet6_addr_loopback;

socket = Unix.socket;

domain_of_sockaddr = Unix.domain_of_sockaddr;

socketpair = Unix.socketpair;

accept = Unix.accept;

bind = Unix.bind;

connect = Unix.connect;

listen = Unix.listen;

shutdown = Unix.shutdown;

getsockname = Unix.getsockname;

getpeername = Unix.getpeername;

recv = Unix.recv;

recvfrom = Unix.recvfrom;

send = Unix.send;

send_substring = Unix.send_substring;

sendto = Unix.sendto;

sendto_substring = Unix.sendto_substring;

getsockopt = Unix.getsockopt;

setsockopt = Unix.setsockopt;

getsockopt_int = Unix.getsockopt_int;

setsockopt_int = Unix.setsockopt_int;

getsockopt_optint = Unix.getsockopt_optint;

setsockopt_optint = Unix.setsockopt_optint;

getsockopt_float = Unix.getsockopt_float;

setsockopt_float = Unix.setsockopt_float;

getsockopt_error = Unix.getsockopt_error;

open_connection = Unix.open_connection;

shutdown_connection = Unix.shutdown_connection;

establish_server = Unix.establish_server;

gethostname = Unix.gethostname;

gethostbyname = Unix.gethostbyname;

gethostbyaddr = Unix.gethostbyaddr;

getprotobyname = Unix.getprotobyname;

getprotobynumber = Unix.getprotobynumber;

getservbyname = Unix.getservbyname;

getservbyport = Unix.getservbyport;

getaddrinfo = Unix.getaddrinfo;

getnameinfo = Unix.getnameinfo;

tcgetattr = Unix.tcgetattr;

tcsetattr = Unix.tcsetattr;

tcsendbreak = Unix.tcsendbreak;

tcdrain = Unix.tcdrain;

tcflush = Unix.tcflush;

tcflow = Unix.tcflow;

setsid = Unix.setsid;

exports.Unix_error = Unix_error;
exports.error_message = error_message;
exports.handle_unix_error = handle_unix_error;
exports.environment = environment;
exports.getenv = getenv;
exports.unsafe_getenv = unsafe_getenv;
exports.putenv = putenv;
exports.execv = execv;
exports.execve = execve;
exports.execvp = execvp;
exports.execvpe = execvpe;
exports.fork = fork;
exports.wait = wait;
exports.waitpid = waitpid;
exports.system = system;
exports.getpid = getpid;
exports.getppid = getppid;
exports.nice = nice;
exports.stdin = stdin;
exports.stdout = stdout;
exports.stderr = stderr;
exports.openfile = openfile;
exports.close = close;
exports.read = read;
exports.write = write;
exports.single_write = single_write;
exports.write_substring = write_substring;
exports.single_write_substring = single_write_substring;
exports.in_channel_of_descr = in_channel_of_descr;
exports.out_channel_of_descr = out_channel_of_descr;
exports.descr_of_in_channel = descr_of_in_channel;
exports.descr_of_out_channel = descr_of_out_channel;
exports.lseek = lseek;
exports.truncate = truncate;
exports.ftruncate = ftruncate;
exports.stat = stat;
exports.lstat = lstat;
exports.fstat = fstat;
exports.isatty = isatty;
exports.LargeFile = LargeFile;
exports.map_file = map_file;
exports.unlink = unlink;
exports.rename = rename;
exports.link = link;
exports.chmod = chmod;
exports.fchmod = fchmod;
exports.chown = chown;
exports.fchown = fchown;
exports.umask = umask;
exports.access = access;
exports.dup = dup;
exports.dup2 = dup2;
exports.set_nonblock = set_nonblock;
exports.clear_nonblock = clear_nonblock;
exports.set_close_on_exec = set_close_on_exec;
exports.clear_close_on_exec = clear_close_on_exec;
exports.mkdir = mkdir;
exports.rmdir = rmdir;
exports.chdir = chdir;
exports.getcwd = getcwd;
exports.chroot = chroot;
exports.opendir = opendir;
exports.readdir = readdir;
exports.rewinddir = rewinddir;
exports.closedir = closedir;
exports.pipe = pipe;
exports.mkfifo = mkfifo;
exports.create_process = create_process;
exports.create_process_env = create_process_env;
exports.open_process_in = open_process_in;
exports.open_process_out = open_process_out;
exports.open_process = open_process;
exports.open_process_full = open_process_full;
exports.close_process_in = close_process_in;
exports.close_process_out = close_process_out;
exports.close_process = close_process;
exports.close_process_full = close_process_full;
exports.symlink = symlink;
exports.has_symlink = has_symlink;
exports.readlink = readlink;
exports.select = select;
exports.lockf = lockf;
exports.kill = kill;
exports.sigprocmask = sigprocmask;
exports.sigpending = sigpending;
exports.sigsuspend = sigsuspend;
exports.pause = pause;
exports.time = time;
exports.gettimeofday = gettimeofday;
exports.gmtime = gmtime;
exports.localtime = localtime;
exports.mktime = mktime;
exports.alarm = alarm;
exports.sleep = sleep;
exports.times = times;
exports.utimes = utimes;
exports.getitimer = getitimer;
exports.setitimer = setitimer;
exports.getuid = getuid;
exports.geteuid = geteuid;
exports.setuid = setuid;
exports.getgid = getgid;
exports.getegid = getegid;
exports.setgid = setgid;
exports.getgroups = getgroups;
exports.setgroups = setgroups;
exports.initgroups = initgroups;
exports.getlogin = getlogin;
exports.getpwnam = getpwnam;
exports.getgrnam = getgrnam;
exports.getpwuid = getpwuid;
exports.getgrgid = getgrgid;
exports.inet_addr_of_string = inet_addr_of_string;
exports.string_of_inet_addr = string_of_inet_addr;
exports.inet_addr_any = inet_addr_any;
exports.inet_addr_loopback = inet_addr_loopback;
exports.inet6_addr_any = inet6_addr_any;
exports.inet6_addr_loopback = inet6_addr_loopback;
exports.socket = socket;
exports.domain_of_sockaddr = domain_of_sockaddr;
exports.socketpair = socketpair;
exports.accept = accept;
exports.bind = bind;
exports.connect = connect;
exports.listen = listen;
exports.shutdown = shutdown;
exports.getsockname = getsockname;
exports.getpeername = getpeername;
exports.recv = recv;
exports.recvfrom = recvfrom;
exports.send = send;
exports.send_substring = send_substring;
exports.sendto = sendto;
exports.sendto_substring = sendto_substring;
exports.getsockopt = getsockopt;
exports.setsockopt = setsockopt;
exports.getsockopt_int = getsockopt_int;
exports.setsockopt_int = setsockopt_int;
exports.getsockopt_optint = getsockopt_optint;
exports.setsockopt_optint = setsockopt_optint;
exports.getsockopt_float = getsockopt_float;
exports.setsockopt_float = setsockopt_float;
exports.getsockopt_error = getsockopt_error;
exports.open_connection = open_connection;
exports.shutdown_connection = shutdown_connection;
exports.establish_server = establish_server;
exports.gethostname = gethostname;
exports.gethostbyname = gethostbyname;
exports.gethostbyaddr = gethostbyaddr;
exports.getprotobyname = getprotobyname;
exports.getprotobynumber = getprotobynumber;
exports.getservbyname = getservbyname;
exports.getservbyport = getservbyport;
exports.getaddrinfo = getaddrinfo;
exports.getnameinfo = getnameinfo;
exports.tcgetattr = tcgetattr;
exports.tcsetattr = tcsetattr;
exports.tcsendbreak = tcsendbreak;
exports.tcdrain = tcdrain;
exports.tcflush = tcflush;
exports.tcflow = tcflow;
exports.setsid = setsid;
--[[ Unix Not a pure module ]]
