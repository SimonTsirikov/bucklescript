

import * as Unix from "./unix.js";

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

export do
  Unix_error ,
  error_message ,
  handle_unix_error ,
  environment ,
  getenv ,
  unsafe_getenv ,
  putenv ,
  execv ,
  execve ,
  execvp ,
  execvpe ,
  fork ,
  wait ,
  waitpid ,
  system ,
  getpid ,
  getppid ,
  nice ,
  stdin ,
  stdout ,
  stderr ,
  openfile ,
  close ,
  read ,
  write ,
  single_write ,
  write_substring ,
  single_write_substring ,
  in_channel_of_descr ,
  out_channel_of_descr ,
  descr_of_in_channel ,
  descr_of_out_channel ,
  lseek ,
  truncate ,
  ftruncate ,
  stat ,
  lstat ,
  fstat ,
  isatty ,
  LargeFile ,
  map_file ,
  unlink ,
  rename ,
  link ,
  chmod ,
  fchmod ,
  chown ,
  fchown ,
  umask ,
  access ,
  dup ,
  dup2 ,
  set_nonblock ,
  clear_nonblock ,
  set_close_on_exec ,
  clear_close_on_exec ,
  mkdir ,
  rmdir ,
  chdir ,
  getcwd ,
  chroot ,
  opendir ,
  readdir ,
  rewinddir ,
  closedir ,
  pipe ,
  mkfifo ,
  create_process ,
  create_process_env ,
  open_process_in ,
  open_process_out ,
  open_process ,
  open_process_full ,
  close_process_in ,
  close_process_out ,
  close_process ,
  close_process_full ,
  symlink ,
  has_symlink ,
  readlink ,
  select ,
  lockf ,
  kill ,
  sigprocmask ,
  sigpending ,
  sigsuspend ,
  pause ,
  time ,
  gettimeofday ,
  gmtime ,
  localtime ,
  mktime ,
  alarm ,
  sleep ,
  times ,
  utimes ,
  getitimer ,
  setitimer ,
  getuid ,
  geteuid ,
  setuid ,
  getgid ,
  getegid ,
  setgid ,
  getgroups ,
  setgroups ,
  initgroups ,
  getlogin ,
  getpwnam ,
  getgrnam ,
  getpwuid ,
  getgrgid ,
  inet_addr_of_string ,
  string_of_inet_addr ,
  inet_addr_any ,
  inet_addr_loopback ,
  inet6_addr_any ,
  inet6_addr_loopback ,
  socket ,
  domain_of_sockaddr ,
  socketpair ,
  accept ,
  bind ,
  connect ,
  listen ,
  shutdown ,
  getsockname ,
  getpeername ,
  recv ,
  recvfrom ,
  send ,
  send_substring ,
  sendto ,
  sendto_substring ,
  getsockopt ,
  setsockopt ,
  getsockopt_int ,
  setsockopt_int ,
  getsockopt_optint ,
  setsockopt_optint ,
  getsockopt_float ,
  setsockopt_float ,
  getsockopt_error ,
  open_connection ,
  shutdown_connection ,
  establish_server ,
  gethostname ,
  gethostbyname ,
  gethostbyaddr ,
  getprotobyname ,
  getprotobynumber ,
  getservbyname ,
  getservbyport ,
  getaddrinfo ,
  getnameinfo ,
  tcgetattr ,
  tcsetattr ,
  tcsendbreak ,
  tcdrain ,
  tcflush ,
  tcflow ,
  setsid ,
  
end
--[ Unix Not a pure module ]--
