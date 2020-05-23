'use strict';

var Sys = require("./sys.js");
var List = require("./list.js");
var $$Array = require("./array.js");
var Block = require("./block.js");
var Curry = require("./curry.js");
var Printf = require("./printf.js");
var $$String = require("./string.js");
var Caml_io = require("./caml_io.js");
var Hashtbl = require("./hashtbl.js");
var Callback = require("./callback.js");
var Caml_sys = require("./caml_sys.js");
var Filename = require("./filename.js");
var Printexc = require("./printexc.js");
var Caml_array = require("./caml_array.js");
var Caml_bytes = require("./caml_bytes.js");
var Pervasives = require("./pervasives.js");
var Caml_format = require("./caml_format.js");
var Caml_exceptions = require("./caml_exceptions.js");
var Caml_js_exceptions = require("./caml_js_exceptions.js");
var Caml_external_polyfill = require("./caml_external_polyfill.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

var Unix_error = Caml_exceptions.create("Unix.Unix_error");

Callback.register_exception("Unix.Unix_error", [
      Unix_error,
      --[ E2BIG ]--0,
      "",
      ""
    ]);

Printexc.register_printer((function (param) do
        if (param[0] == Unix_error) do
          var e = param[1];
          var msg;
          if (typeof e == "number") do
            switch (e) do
              case --[ E2BIG ]--0 :
                  msg = "E2BIG";
                  break;
              case --[ EACCES ]--1 :
                  msg = "EACCES";
                  break;
              case --[ EAGAIN ]--2 :
                  msg = "EAGAIN";
                  break;
              case --[ EBADF ]--3 :
                  msg = "EBADF";
                  break;
              case --[ EBUSY ]--4 :
                  msg = "EBUSY";
                  break;
              case --[ ECHILD ]--5 :
                  msg = "ECHILD";
                  break;
              case --[ EDEADLK ]--6 :
                  msg = "EDEADLK";
                  break;
              case --[ EDOM ]--7 :
                  msg = "EDOM";
                  break;
              case --[ EEXIST ]--8 :
                  msg = "EEXIST";
                  break;
              case --[ EFAULT ]--9 :
                  msg = "EFAULT";
                  break;
              case --[ EFBIG ]--10 :
                  msg = "EFBIG";
                  break;
              case --[ EINTR ]--11 :
                  msg = "EINTR";
                  break;
              case --[ EINVAL ]--12 :
                  msg = "EINVAL";
                  break;
              case --[ EIO ]--13 :
                  msg = "EIO";
                  break;
              case --[ EISDIR ]--14 :
                  msg = "EISDIR";
                  break;
              case --[ EMFILE ]--15 :
                  msg = "EMFILE";
                  break;
              case --[ EMLINK ]--16 :
                  msg = "EMLINK";
                  break;
              case --[ ENAMETOOLONG ]--17 :
                  msg = "ENAMETOOLONG";
                  break;
              case --[ ENFILE ]--18 :
                  msg = "ENFILE";
                  break;
              case --[ ENODEV ]--19 :
                  msg = "ENODEV";
                  break;
              case --[ ENOENT ]--20 :
                  msg = "ENOENT";
                  break;
              case --[ ENOEXEC ]--21 :
                  msg = "ENOEXEC";
                  break;
              case --[ ENOLCK ]--22 :
                  msg = "ENOLCK";
                  break;
              case --[ ENOMEM ]--23 :
                  msg = "ENOMEM";
                  break;
              case --[ ENOSPC ]--24 :
                  msg = "ENOSPC";
                  break;
              case --[ ENOSYS ]--25 :
                  msg = "ENOSYS";
                  break;
              case --[ ENOTDIR ]--26 :
                  msg = "ENOTDIR";
                  break;
              case --[ ENOTEMPTY ]--27 :
                  msg = "ENOTEMPTY";
                  break;
              case --[ ENOTTY ]--28 :
                  msg = "ENOTTY";
                  break;
              case --[ ENXIO ]--29 :
                  msg = "ENXIO";
                  break;
              case --[ EPERM ]--30 :
                  msg = "EPERM";
                  break;
              case --[ EPIPE ]--31 :
                  msg = "EPIPE";
                  break;
              case --[ ERANGE ]--32 :
                  msg = "ERANGE";
                  break;
              case --[ EROFS ]--33 :
                  msg = "EROFS";
                  break;
              case --[ ESPIPE ]--34 :
                  msg = "ESPIPE";
                  break;
              case --[ ESRCH ]--35 :
                  msg = "ESRCH";
                  break;
              case --[ EXDEV ]--36 :
                  msg = "EXDEV";
                  break;
              case --[ EWOULDBLOCK ]--37 :
                  msg = "EWOULDBLOCK";
                  break;
              case --[ EINPROGRESS ]--38 :
                  msg = "EINPROGRESS";
                  break;
              case --[ EALREADY ]--39 :
                  msg = "EALREADY";
                  break;
              case --[ ENOTSOCK ]--40 :
                  msg = "ENOTSOCK";
                  break;
              case --[ EDESTADDRREQ ]--41 :
                  msg = "EDESTADDRREQ";
                  break;
              case --[ EMSGSIZE ]--42 :
                  msg = "EMSGSIZE";
                  break;
              case --[ EPROTOTYPE ]--43 :
                  msg = "EPROTOTYPE";
                  break;
              case --[ ENOPROTOOPT ]--44 :
                  msg = "ENOPROTOOPT";
                  break;
              case --[ EPROTONOSUPPORT ]--45 :
                  msg = "EPROTONOSUPPORT";
                  break;
              case --[ ESOCKTNOSUPPORT ]--46 :
                  msg = "ESOCKTNOSUPPORT";
                  break;
              case --[ EOPNOTSUPP ]--47 :
                  msg = "EOPNOTSUPP";
                  break;
              case --[ EPFNOSUPPORT ]--48 :
                  msg = "EPFNOSUPPORT";
                  break;
              case --[ EAFNOSUPPORT ]--49 :
                  msg = "EAFNOSUPPORT";
                  break;
              case --[ EADDRINUSE ]--50 :
                  msg = "EADDRINUSE";
                  break;
              case --[ EADDRNOTAVAIL ]--51 :
                  msg = "EADDRNOTAVAIL";
                  break;
              case --[ ENETDOWN ]--52 :
                  msg = "ENETDOWN";
                  break;
              case --[ ENETUNREACH ]--53 :
                  msg = "ENETUNREACH";
                  break;
              case --[ ENETRESET ]--54 :
                  msg = "ENETRESET";
                  break;
              case --[ ECONNABORTED ]--55 :
                  msg = "ECONNABORTED";
                  break;
              case --[ ECONNRESET ]--56 :
                  msg = "ECONNRESET";
                  break;
              case --[ ENOBUFS ]--57 :
                  msg = "ENOBUFS";
                  break;
              case --[ EISCONN ]--58 :
                  msg = "EISCONN";
                  break;
              case --[ ENOTCONN ]--59 :
                  msg = "ENOTCONN";
                  break;
              case --[ ESHUTDOWN ]--60 :
                  msg = "ESHUTDOWN";
                  break;
              case --[ ETOOMANYREFS ]--61 :
                  msg = "ETOOMANYREFS";
                  break;
              case --[ ETIMEDOUT ]--62 :
                  msg = "ETIMEDOUT";
                  break;
              case --[ ECONNREFUSED ]--63 :
                  msg = "ECONNREFUSED";
                  break;
              case --[ EHOSTDOWN ]--64 :
                  msg = "EHOSTDOWN";
                  break;
              case --[ EHOSTUNREACH ]--65 :
                  msg = "EHOSTUNREACH";
                  break;
              case --[ ELOOP ]--66 :
                  msg = "ELOOP";
                  break;
              case --[ EOVERFLOW ]--67 :
                  msg = "EOVERFLOW";
                  break;
              
            end
          end else do
            msg = Curry._1(Printf.sprintf(--[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "EUNKNOWNERR ",
                          --[ Int ]--Block.__(4, [
                              --[ Int_d ]--0,
                              --[ No_padding ]--0,
                              --[ No_precision ]--0,
                              --[ End_of_format ]--0
                            ])
                        ]),
                      "EUNKNOWNERR %d"
                    ]), e[0]);
          end
          return Curry._3(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "Unix.Unix_error(Unix.",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      ", ",
                                      --[ Caml_string ]--Block.__(3, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              ", ",
                                              --[ Caml_string ]--Block.__(3, [
                                                  --[ No_padding ]--0,
                                                  --[ Char_literal ]--Block.__(12, [
                                                      --[ ")" ]--41,
                                                      --[ End_of_format ]--0
                                                    ])
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "Unix.Unix_error(Unix.%s, %S, %S)"
                        ]), msg, param[2], param[3]);
        end
        
      end));

function handle_unix_error(f, arg) do
  try do
    return Curry._1(f, arg);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Unix_error) do
      var arg$1 = exn[3];
      Pervasives.prerr_string(Caml_array.caml_array_get(Sys.argv, 0));
      Pervasives.prerr_string(": \"");
      Pervasives.prerr_string(exn[2]);
      Pervasives.prerr_string("\" failed");
      if (#arg$1 ~= 0) do
        Pervasives.prerr_string(" on \"");
        Pervasives.prerr_string(arg$1);
        Pervasives.prerr_string("\"");
      end
      Pervasives.prerr_string(": ");
      console.error(Caml_external_polyfill.resolve("unix_error_message")(exn[1]));
      return Pervasives.exit(2);
    end else do
      throw exn;
    end
  end
end

function execvpe(name, args, env) do
  try do
    return Caml_external_polyfill.resolve("unix_execvpe")(name, args, env);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Unix_error) do
      var match = exn[1];
      if (typeof match == "number") do
        if (match ~= 25) do
          throw exn;
        end
        var name$1 = name;
        var args$1 = args;
        var env$1 = env;
        var exec = function (file) do
          try do
            return Caml_external_polyfill.resolve("unix_execve")(file, args$1, env$1);
          end
          catch (raw_exn)do
            var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
            if (exn[0] == Unix_error) do
              var match = exn[1];
              if (typeof match == "number") do
                if (match ~= 21) do
                  throw exn;
                end
                var argc = #args$1;
                var new_args = $$Array.append([
                      "/bin/sh",
                      file
                    ], argc == 0 ? args$1 : $$Array.sub(args$1, 1, argc - 1 | 0));
                return Caml_external_polyfill.resolve("unix_execve")(Caml_array.caml_array_get(new_args, 0), new_args, env$1);
              end else do
                throw exn;
              end
            end else do
              throw exn;
            end
          end
        end;
        if ($$String.contains(name$1, --[ "/" ]--47)) do
          return exec(name$1);
        end else do
          var tmp;
          try do
            tmp = Caml_external_polyfill.resolve("caml_sys_unsafe_getenv")("PATH");
          end
          catch (exn$1)do
            if (exn$1 == Caml_builtin_exceptions.not_found) do
              tmp = "/bin:/usr/bin";
            end else do
              throw exn$1;
            end
          end
          var _eacces = false;
          var _param = $$String.split_on_char(--[ ":" ]--58, tmp);
          while(true) do
            var param = _param;
            var eacces = _eacces;
            if (param) do
              var rem = param[1];
              var dir = param[0];
              var dir$1 = dir == "" ? Filename.current_dir_name : dir;
              try do
                return exec(Filename.concat(dir$1, name$1));
              end
              catch (raw_exn$1)do
                var exn$2 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
                if (exn$2[0] == Unix_error) do
                  var err = exn$2[1];
                  if (typeof err == "number") do
                    var switcher = err - 62 | 0;
                    if (switcher > 4 or switcher < 0) do
                      if (switcher >= -35) do
                        throw exn$2;
                      end
                      switch (switcher + 62 | 0) do
                        case --[ EACCES ]--1 :
                            _param = rem;
                            _eacces = true;
                            continue ;
                        case --[ E2BIG ]--0 :
                        case --[ EAGAIN ]--2 :
                        case --[ EBADF ]--3 :
                        case --[ EBUSY ]--4 :
                        case --[ ECHILD ]--5 :
                        case --[ EDEADLK ]--6 :
                        case --[ EDOM ]--7 :
                        case --[ EEXIST ]--8 :
                        case --[ EFAULT ]--9 :
                        case --[ EFBIG ]--10 :
                        case --[ EINTR ]--11 :
                        case --[ EINVAL ]--12 :
                        case --[ EIO ]--13 :
                        case --[ EMFILE ]--15 :
                        case --[ EMLINK ]--16 :
                        case --[ ENFILE ]--18 :
                        case --[ ENOEXEC ]--21 :
                        case --[ ENOLCK ]--22 :
                        case --[ ENOMEM ]--23 :
                        case --[ ENOSPC ]--24 :
                        case --[ ENOSYS ]--25 :
                            throw exn$2;
                        case --[ EISDIR ]--14 :
                        case --[ ENAMETOOLONG ]--17 :
                        case --[ ENODEV ]--19 :
                        case --[ ENOENT ]--20 :
                        case --[ ENOTDIR ]--26 :
                            _param = rem;
                            continue ;
                        
                      end
                    end else if (switcher > 3 or switcher < 1) do
                      _param = rem;
                      continue ;
                    end else do
                      throw exn$2;
                    end
                  end else do
                    throw exn$2;
                  end
                end else do
                  throw exn$2;
                end
              end
            end else do
              throw [
                    Unix_error,
                    eacces ? --[ EACCES ]--1 : --[ ENOENT ]--20,
                    "execvpe",
                    name$1
                  ];
            end
          end;
        end
      end else do
        throw exn;
      end
    end else do
      throw exn;
    end
  end
end

function read(fd, buf, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Unix.read"
        ];
  end
  return Caml_external_polyfill.resolve("unix_read")(fd, buf, ofs, len);
end

function write(fd, buf, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Unix.write"
        ];
  end
  return Caml_external_polyfill.resolve("unix_write")(fd, buf, ofs, len);
end

function single_write(fd, buf, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Unix.single_write"
        ];
  end
  return Caml_external_polyfill.resolve("unix_single_write")(fd, buf, ofs, len);
end

function write_substring(fd, buf, ofs, len) do
  return write(fd, Caml_bytes.bytes_of_string(buf), ofs, len);
end

function single_write_substring(fd, buf, ofs, len) do
  return single_write(fd, Caml_bytes.bytes_of_string(buf), ofs, len);
end

function map_file(fd, posOpt, kind, layout, shared, dims) do
  var pos = posOpt ~= undefined ? posOpt : --[ int64 ]--[
      --[ hi ]--0,
      --[ lo ]--0
    ];
  return Caml_external_polyfill.resolve("caml_unix_map_file_bytecode")(fd, kind, layout, shared, dims, pos);
end

function pause(param) do
  return Caml_external_polyfill.resolve("unix_sigsuspend")(Caml_external_polyfill.resolve("unix_sigprocmask")(--[ SIG_BLOCK ]--1, --[ [] ]--0));
end

function sleep(duration) do
  return Caml_external_polyfill.resolve("unix_sleep")(duration);
end

var inet_addr_any = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("0.0.0.0");

var inet_addr_loopback = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("127.0.0.1");

var inet6_addr_any;

try do
  inet6_addr_any = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("::");
end
catch (raw_exn)do
  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.failure) do
    inet6_addr_any = inet_addr_any;
  end else do
    throw exn;
  end
end

var inet6_addr_loopback;

try do
  inet6_addr_loopback = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("::1");
end
catch (raw_exn$1)do
  var exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
  if (exn$1[0] == Caml_builtin_exceptions.failure) do
    inet6_addr_loopback = inet_addr_loopback;
  end else do
    throw exn$1;
  end
end

function domain_of_sockaddr(param) do
  if (param.tag) do
    if (#param[0] == 16) do
      return --[ PF_INET6 ]--2;
    end else do
      return --[ PF_INET ]--1;
    end
  end else do
    return --[ PF_UNIX ]--0;
  end
end

function recv(fd, buf, ofs, len, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Unix.recv"
        ];
  end
  return Caml_external_polyfill.resolve("unix_recv")(fd, buf, ofs, len, flags);
end

function recvfrom(fd, buf, ofs, len, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Unix.recvfrom"
        ];
  end
  return Caml_external_polyfill.resolve("unix_recvfrom")(fd, buf, ofs, len, flags);
end

function send(fd, buf, ofs, len, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Unix.send"
        ];
  end
  return Caml_external_polyfill.resolve("unix_send")(fd, buf, ofs, len, flags);
end

function sendto(fd, buf, ofs, len, flags, addr) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Unix.sendto"
        ];
  end
  return Caml_external_polyfill.resolve("unix_sendto")(fd, buf, ofs, len, flags, addr);
end

function send_substring(fd, buf, ofs, len, flags) do
  return send(fd, Caml_bytes.bytes_of_string(buf), ofs, len, flags);
end

function sendto_substring(fd, buf, ofs, len, flags, addr) do
  return sendto(fd, Caml_bytes.bytes_of_string(buf), ofs, len, flags, addr);
end

function SO_get(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_getsockopt")(prim, prim$1, prim$2);
end

function SO_set(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_setsockopt")(prim, prim$1, prim$2, prim$3);
end

function getsockopt(fd, opt) do
  return Curry._3(SO_get, 0, fd, opt);
end

function setsockopt(fd, opt, v) do
  return Curry._4(SO_set, 0, fd, opt, v);
end

function getsockopt_int(fd, opt) do
  return Curry._3(SO_get, 1, fd, opt);
end

function setsockopt_int(fd, opt, v) do
  return Curry._4(SO_set, 1, fd, opt, v);
end

function getsockopt_optint(fd, opt) do
  return Curry._3(SO_get, 2, fd, opt);
end

function setsockopt_optint(fd, opt, v) do
  return Curry._4(SO_set, 2, fd, opt, v);
end

function getsockopt_float(fd, opt) do
  return Curry._3(SO_get, 3, fd, opt);
end

function setsockopt_float(fd, opt, v) do
  return Curry._4(SO_set, 3, fd, opt, v);
end

function getsockopt_error(fd) do
  return Curry._3(SO_get, 4, fd, --[ SO_ERROR ]--0);
end

function getaddrinfo(node, service, opts) do
  try do
    return List.rev(Caml_external_polyfill.resolve("unix_getaddrinfo")(node, service, opts));
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) do
      var node$1 = node;
      var service$1 = service;
      var opts$1 = opts;
      var opt_socktype = do
        contents: undefined
      end;
      var opt_protocol = do
        contents: 0
      end;
      var opt_passive = do
        contents: false
      end;
      List.iter((function (param) do
              if (typeof param == "number") do
                if (param == --[ AI_PASSIVE ]--2) do
                  opt_passive.contents = true;
                  return --[ () ]--0;
                end else do
                  return --[ () ]--0;
                end
              end else do
                switch (param.tag | 0) do
                  case --[ AI_SOCKTYPE ]--1 :
                      opt_socktype.contents = param[0];
                      return --[ () ]--0;
                  case --[ AI_PROTOCOL ]--2 :
                      opt_protocol.contents = param[0];
                      return --[ () ]--0;
                  default:
                    return --[ () ]--0;
                end
              end
            end), opts$1);
      var get_port = function (ty, kind) do
        if (service$1 == "") do
          return --[ :: ]--[
                  --[ tuple ]--[
                    ty,
                    0
                  ],
                  --[ [] ]--0
                ];
        end else do
          try do
            return --[ :: ]--[
                    --[ tuple ]--[
                      ty,
                      Caml_format.caml_int_of_string(service$1)
                    ],
                    --[ [] ]--0
                  ];
          end
          catch (raw_exn)do
            var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
            if (exn[0] == Caml_builtin_exceptions.failure) do
              try do
                return --[ :: ]--[
                        --[ tuple ]--[
                          ty,
                          Caml_external_polyfill.resolve("unix_getservbyname")(service$1, kind).s_port
                        ],
                        --[ [] ]--0
                      ];
              end
              catch (exn$1)do
                if (exn$1 == Caml_builtin_exceptions.not_found) do
                  return --[ [] ]--0;
                end else do
                  throw exn$1;
                end
              end
            end else do
              throw exn;
            end
          end
        end
      end;
      var match = opt_socktype.contents;
      var ports;
      if (match ~= undefined) do
        var ty = match;
        ports = ty ~= 1 ? (
            ty ~= 0 ? (
                service$1 == "" ? --[ :: ]--[
                    --[ tuple ]--[
                      ty,
                      0
                    ],
                    --[ [] ]--0
                  ] : --[ [] ]--0
              ) : get_port(--[ SOCK_STREAM ]--0, "tcp")
          ) : get_port(--[ SOCK_DGRAM ]--1, "udp");
      end else do
        ports = Pervasives.$at(get_port(--[ SOCK_STREAM ]--0, "tcp"), get_port(--[ SOCK_DGRAM ]--1, "udp"));
      end
      var addresses;
      if (node$1 == "") do
        addresses = List.mem(--[ AI_PASSIVE ]--2, opts$1) ? --[ :: ]--[
            --[ tuple ]--[
              inet_addr_any,
              "0.0.0.0"
            ],
            --[ [] ]--0
          ] : --[ :: ]--[
            --[ tuple ]--[
              inet_addr_loopback,
              "127.0.0.1"
            ],
            --[ [] ]--0
          ];
      end else do
        try do
          addresses = --[ :: ]--[
            --[ tuple ]--[
              Caml_external_polyfill.resolve("unix_inet_addr_of_string")(node$1),
              node$1
            ],
            --[ [] ]--0
          ];
        end
        catch (raw_exn$1)do
          var exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
          if (exn$1[0] == Caml_builtin_exceptions.failure) do
            try do
              var he = Caml_external_polyfill.resolve("unix_gethostbyname")(node$1);
              addresses = List.map((function (a) do
                      return --[ tuple ]--[
                              a,
                              he.h_name
                            ];
                    end), $$Array.to_list(he.h_addr_list));
            end
            catch (exn$2)do
              if (exn$2 == Caml_builtin_exceptions.not_found) do
                addresses = --[ [] ]--0;
              end else do
                throw exn$2;
              end
            end
          end else do
            throw exn$1;
          end
        end
      end
      return List.flatten(List.map((function (param) do
                        var port = param[1];
                        var ty = param[0];
                        return List.map((function (param) do
                                      return do
                                              ai_family: --[ PF_INET ]--1,
                                              ai_socktype: ty,
                                              ai_protocol: opt_protocol.contents,
                                              ai_addr: --[ ADDR_INET ]--Block.__(1, [
                                                  param[0],
                                                  port
                                                ]),
                                              ai_canonname: param[1]
                                            end;
                                    end), addresses);
                      end), ports));
    end else do
      throw exn;
    end
  end
end

function getnameinfo(addr, opts) do
  try do
    return Caml_external_polyfill.resolve("unix_getnameinfo")(addr, opts);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) do
      var addr$1 = addr;
      var opts$1 = opts;
      if (addr$1.tag) do
        var p = addr$1[1];
        var a = addr$1[0];
        var hostname;
        try do
          if (List.mem(--[ NI_NUMERICHOST ]--1, opts$1)) do
            throw Caml_builtin_exceptions.not_found;
          end
          hostname = Caml_external_polyfill.resolve("unix_gethostbyaddr")(a).h_name;
        end
        catch (exn$1)do
          if (exn$1 == Caml_builtin_exceptions.not_found) do
            if (List.mem(--[ NI_NAMEREQD ]--2, opts$1)) do
              throw Caml_builtin_exceptions.not_found;
            end
            hostname = Caml_external_polyfill.resolve("unix_string_of_inet_addr")(a);
          end else do
            throw exn$1;
          end
        end
        var service;
        try do
          if (List.mem(--[ NI_NUMERICSERV ]--3, opts$1)) do
            throw Caml_builtin_exceptions.not_found;
          end
          var kind = List.mem(--[ NI_DGRAM ]--4, opts$1) ? "udp" : "tcp";
          service = Caml_external_polyfill.resolve("unix_getservbyport")(p, kind).s_name;
        end
        catch (exn$2)do
          if (exn$2 == Caml_builtin_exceptions.not_found) do
            service = String(p);
          end else do
            throw exn$2;
          end
        end
        return do
                ni_hostname: hostname,
                ni_service: service
              end;
      end else do
        return do
                ni_hostname: "",
                ni_service: addr$1[0]
              end;
      end
    end else do
      throw exn;
    end
  end
end

function waitpid_non_intr(pid) do
  while(true) do
    try do
      return Caml_external_polyfill.resolve("unix_waitpid")(--[ [] ]--0, pid);
    end
    catch (raw_exn)do
      var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn[0] == Unix_error) do
        var match = exn[1];
        if (typeof match == "number") do
          if (match ~= 11) do
            throw exn;
          end
          continue ;
        end else do
          throw exn;
        end
      end else do
        throw exn;
      end
    end
  end;
end

function system(cmd) do
  var id = Caml_external_polyfill.resolve("unix_fork")(--[ () ]--0);
  if (id ~= 0) do
    return waitpid_non_intr(id)[1];
  end else do
    try do
      return Caml_external_polyfill.resolve("unix_execv")("/bin/sh", [
                  "/bin/sh",
                  "-c",
                  cmd
                ]);
    end
    catch (exn)do
      return Caml_sys.caml_sys_exit(127);
    end
  end
end

function file_descr_not_standard(_fd) do
  while(true) do
    var fd = _fd;
    if (fd >= 3) do
      return fd;
    end else do
      _fd = Caml_external_polyfill.resolve("unix_dup")(undefined, fd);
      continue ;
    end
  end;
end

function safe_close(fd) do
  try do
    return Caml_external_polyfill.resolve("unix_close")(fd);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Unix_error) do
      return --[ () ]--0;
    end else do
      throw exn;
    end
  end
end

function perform_redirections(new_stdin, new_stdout, new_stderr) do
  var new_stdin$1 = file_descr_not_standard(new_stdin);
  var new_stdout$1 = file_descr_not_standard(new_stdout);
  var new_stderr$1 = file_descr_not_standard(new_stderr);
  Caml_external_polyfill.resolve("unix_dup2")(false, new_stdin$1, 0);
  Caml_external_polyfill.resolve("unix_dup2")(false, new_stdout$1, 1);
  Caml_external_polyfill.resolve("unix_dup2")(false, new_stderr$1, 2);
  safe_close(new_stdin$1);
  safe_close(new_stdout$1);
  return safe_close(new_stderr$1);
end

function create_process(cmd, args, new_stdin, new_stdout, new_stderr) do
  var id = Caml_external_polyfill.resolve("unix_fork")(--[ () ]--0);
  if (id ~= 0) do
    return id;
  end else do
    try do
      perform_redirections(new_stdin, new_stdout, new_stderr);
      return Caml_external_polyfill.resolve("unix_execvp")(cmd, args);
    end
    catch (exn)do
      return Caml_sys.caml_sys_exit(127);
    end
  end
end

function create_process_env(cmd, args, env, new_stdin, new_stdout, new_stderr) do
  var id = Caml_external_polyfill.resolve("unix_fork")(--[ () ]--0);
  if (id ~= 0) do
    return id;
  end else do
    try do
      perform_redirections(new_stdin, new_stdout, new_stderr);
      return execvpe(cmd, args, env);
    end
    catch (exn)do
      return Caml_sys.caml_sys_exit(127);
    end
  end
end

var popen_processes = Hashtbl.create(undefined, 7);

function open_proc(cmd, envopt, proc, input, output, error) do
  var id = Caml_external_polyfill.resolve("unix_fork")(--[ () ]--0);
  if (id ~= 0) do
    return Hashtbl.add(popen_processes, proc, id);
  end else do
    perform_redirections(input, output, error);
    var shell = "/bin/sh";
    var argv = [
      shell,
      "-c",
      cmd
    ];
    try do
      if (envopt ~= undefined) do
        return Caml_external_polyfill.resolve("unix_execve")(shell, argv, envopt);
      end else do
        return Caml_external_polyfill.resolve("unix_execv")(shell, argv);
      end
    end
    catch (exn)do
      return Caml_sys.caml_sys_exit(127);
    end
  end
end

function open_process_in(cmd) do
  var match = Caml_external_polyfill.resolve("unix_pipe")(true, --[ () ]--0);
  var in_write = match[1];
  var inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(match[0]);
  try do
    open_proc(cmd, undefined, --[ Process_in ]--Block.__(1, [inchan]), 0, in_write, 2);
  end
  catch (e)do
    Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    throw e;
  end
  Caml_external_polyfill.resolve("unix_close")(in_write);
  return inchan;
end

function open_process_out(cmd) do
  var match = Caml_external_polyfill.resolve("unix_pipe")(true, --[ () ]--0);
  var out_read = match[0];
  var outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(match[1]);
  try do
    open_proc(cmd, undefined, --[ Process_out ]--Block.__(2, [outchan]), out_read, 1, 2);
  end
  catch (e)do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
    Caml_external_polyfill.resolve("unix_close")(out_read);
    throw e;
  end
  Caml_external_polyfill.resolve("unix_close")(out_read);
  return outchan;
end

function open_process(cmd) do
  var match = Caml_external_polyfill.resolve("unix_pipe")(true, --[ () ]--0);
  var in_write = match[1];
  var in_read = match[0];
  var match$1;
  try do
    match$1 = Caml_external_polyfill.resolve("unix_pipe")(true, --[ () ]--0);
  end
  catch (e)do
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    throw e;
  end
  var out_write = match$1[1];
  var out_read = match$1[0];
  var inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(in_read);
  var outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(out_write);
  try do
    open_proc(cmd, undefined, --[ Process ]--Block.__(0, [
            inchan,
            outchan
          ]), out_read, in_write, 2);
  end
  catch (e$1)do
    Caml_external_polyfill.resolve("unix_close")(out_read);
    Caml_external_polyfill.resolve("unix_close")(out_write);
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    throw e$1;
  end
  Caml_external_polyfill.resolve("unix_close")(out_read);
  Caml_external_polyfill.resolve("unix_close")(in_write);
  return --[ tuple ]--[
          inchan,
          outchan
        ];
end

function open_process_full(cmd, env) do
  var match = Caml_external_polyfill.resolve("unix_pipe")(true, --[ () ]--0);
  var in_write = match[1];
  var in_read = match[0];
  var match$1;
  try do
    match$1 = Caml_external_polyfill.resolve("unix_pipe")(true, --[ () ]--0);
  end
  catch (e)do
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    throw e;
  end
  var out_write = match$1[1];
  var out_read = match$1[0];
  var match$2;
  try do
    match$2 = Caml_external_polyfill.resolve("unix_pipe")(true, --[ () ]--0);
  end
  catch (e$1)do
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    Caml_external_polyfill.resolve("unix_close")(out_read);
    Caml_external_polyfill.resolve("unix_close")(out_write);
    throw e$1;
  end
  var err_write = match$2[1];
  var err_read = match$2[0];
  var inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(in_read);
  var outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(out_write);
  var errchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(err_read);
  try do
    open_proc(cmd, env, --[ Process_full ]--Block.__(3, [
            inchan,
            outchan,
            errchan
          ]), out_read, in_write, err_write);
  end
  catch (e$2)do
    Caml_external_polyfill.resolve("unix_close")(out_read);
    Caml_external_polyfill.resolve("unix_close")(out_write);
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    Caml_external_polyfill.resolve("unix_close")(err_read);
    Caml_external_polyfill.resolve("unix_close")(err_write);
    throw e$2;
  end
  Caml_external_polyfill.resolve("unix_close")(out_read);
  Caml_external_polyfill.resolve("unix_close")(in_write);
  Caml_external_polyfill.resolve("unix_close")(err_write);
  return --[ tuple ]--[
          inchan,
          outchan,
          errchan
        ];
end

function find_proc_id(fun_name, proc) do
  try do
    var pid = Hashtbl.find(popen_processes, proc);
    Hashtbl.remove(popen_processes, proc);
    return pid;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      throw [
            Unix_error,
            --[ EBADF ]--3,
            fun_name,
            ""
          ];
    end
    throw exn;
  end
end

function close_process_in(inchan) do
  var pid = find_proc_id("close_process_in", --[ Process_in ]--Block.__(1, [inchan]));
  Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
  return waitpid_non_intr(pid)[1];
end

function close_process_out(outchan) do
  var pid = find_proc_id("close_process_out", --[ Process_out ]--Block.__(2, [outchan]));
  try do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] ~= Caml_builtin_exceptions.sys_error) do
      throw exn;
    end
    
  end
  return waitpid_non_intr(pid)[1];
end

function close_process(param) do
  var outchan = param[1];
  var inchan = param[0];
  var pid = find_proc_id("close_process", --[ Process ]--Block.__(0, [
          inchan,
          outchan
        ]));
  Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
  try do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] ~= Caml_builtin_exceptions.sys_error) do
      throw exn;
    end
    
  end
  return waitpid_non_intr(pid)[1];
end

function close_process_full(param) do
  var errchan = param[2];
  var outchan = param[1];
  var inchan = param[0];
  var pid = find_proc_id("close_process_full", --[ Process_full ]--Block.__(3, [
          inchan,
          outchan,
          errchan
        ]));
  Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
  try do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] ~= Caml_builtin_exceptions.sys_error) do
      throw exn;
    end
    
  end
  Caml_external_polyfill.resolve("caml_ml_close_channel")(errchan);
  return waitpid_non_intr(pid)[1];
end

function open_connection(sockaddr) do
  var sock = Caml_external_polyfill.resolve("unix_socket")(true, domain_of_sockaddr(sockaddr), --[ SOCK_STREAM ]--0, 0);
  try do
    Caml_external_polyfill.resolve("unix_connect")(sock, sockaddr);
    return --[ tuple ]--[
            Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(sock),
            Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(sock)
          ];
  end
  catch (exn)do
    Caml_external_polyfill.resolve("unix_close")(sock);
    throw exn;
  end
end

function shutdown_connection(inchan) do
  return Caml_external_polyfill.resolve("unix_shutdown")(Caml_external_polyfill.resolve("caml_channel_descriptor")(inchan), --[ SHUTDOWN_SEND ]--1);
end

function accept_non_intr(s) do
  while(true) do
    try do
      return Caml_external_polyfill.resolve("unix_accept")(true, s);
    end
    catch (raw_exn)do
      var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn[0] == Unix_error) do
        var match = exn[1];
        if (typeof match == "number") do
          if (match ~= 11) do
            throw exn;
          end
          continue ;
        end else do
          throw exn;
        end
      end else do
        throw exn;
      end
    end
  end;
end

function establish_server(server_fun, sockaddr) do
  var sock = Caml_external_polyfill.resolve("unix_socket")(true, domain_of_sockaddr(sockaddr), --[ SOCK_STREAM ]--0, 0);
  setsockopt(sock, --[ SO_REUSEADDR ]--2, true);
  Caml_external_polyfill.resolve("unix_bind")(sock, sockaddr);
  Caml_external_polyfill.resolve("unix_listen")(sock, 5);
  while(true) do
    var match = accept_non_intr(sock);
    var s = match[0];
    var id = Caml_external_polyfill.resolve("unix_fork")(--[ () ]--0);
    if (id ~= 0) do
      Caml_external_polyfill.resolve("unix_close")(s);
      waitpid_non_intr(id);
    end else do
      if (Caml_external_polyfill.resolve("unix_fork")(--[ () ]--0) ~= 0) do
        Caml_sys.caml_sys_exit(0);
      end
      Caml_external_polyfill.resolve("unix_close")(sock);
      var inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(s);
      var outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(s);
      Curry._2(server_fun, inchan, outchan);
      Pervasives.exit(0);
    end
  end;
  return --[ () ]--0;
end

function error_message(prim) do
  return Caml_external_polyfill.resolve("unix_error_message")(prim);
end

function environment(prim) do
  return Caml_external_polyfill.resolve("unix_environment")(prim);
end

function unsafe_environment(prim) do
  return Caml_external_polyfill.resolve("unix_environment_unsafe")(prim);
end

var getenv = Caml_sys.caml_sys_getenv;

function unsafe_getenv(prim) do
  return Caml_external_polyfill.resolve("caml_sys_unsafe_getenv")(prim);
end

function putenv(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_putenv")(prim, prim$1);
end

function execv(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_execv")(prim, prim$1);
end

function execve(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_execve")(prim, prim$1, prim$2);
end

function execvp(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_execvp")(prim, prim$1);
end

function fork(prim) do
  return Caml_external_polyfill.resolve("unix_fork")(prim);
end

function wait(prim) do
  return Caml_external_polyfill.resolve("unix_wait")(prim);
end

function waitpid(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_waitpid")(prim, prim$1);
end

function getpid(prim) do
  return Caml_external_polyfill.resolve("unix_getpid")(prim);
end

function getppid(prim) do
  return Caml_external_polyfill.resolve("unix_getppid")(prim);
end

function nice(prim) do
  return Caml_external_polyfill.resolve("unix_nice")(prim);
end

var stdin = 0;

var stdout = 1;

var stderr = 2;

function openfile(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_open")(prim, prim$1, prim$2);
end

function close(prim) do
  return Caml_external_polyfill.resolve("unix_close")(prim);
end

function in_channel_of_descr(prim) do
  return Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(prim);
end

function out_channel_of_descr(prim) do
  return Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(prim);
end

function descr_of_in_channel(prim) do
  return Caml_external_polyfill.resolve("caml_channel_descriptor")(prim);
end

function descr_of_out_channel(prim) do
  return Caml_external_polyfill.resolve("caml_channel_descriptor")(prim);
end

function lseek(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_lseek")(prim, prim$1, prim$2);
end

function truncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_truncate")(prim, prim$1);
end

function ftruncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_ftruncate")(prim, prim$1);
end

function stat(prim) do
  return Caml_external_polyfill.resolve("unix_stat")(prim);
end

function lstat(prim) do
  return Caml_external_polyfill.resolve("unix_lstat")(prim);
end

function fstat(prim) do
  return Caml_external_polyfill.resolve("unix_fstat")(prim);
end

function isatty(prim) do
  return Caml_external_polyfill.resolve("unix_isatty")(prim);
end

function LargeFile_lseek(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_lseek_64")(prim, prim$1, prim$2);
end

function LargeFile_truncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_truncate_64")(prim, prim$1);
end

function LargeFile_ftruncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_ftruncate_64")(prim, prim$1);
end

function LargeFile_stat(prim) do
  return Caml_external_polyfill.resolve("unix_stat_64")(prim);
end

function LargeFile_lstat(prim) do
  return Caml_external_polyfill.resolve("unix_lstat_64")(prim);
end

function LargeFile_fstat(prim) do
  return Caml_external_polyfill.resolve("unix_fstat_64")(prim);
end

var LargeFile = do
  lseek: LargeFile_lseek,
  truncate: LargeFile_truncate,
  ftruncate: LargeFile_ftruncate,
  stat: LargeFile_stat,
  lstat: LargeFile_lstat,
  fstat: LargeFile_fstat
end;

function unlink(prim) do
  return Caml_external_polyfill.resolve("unix_unlink")(prim);
end

function rename(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_rename")(prim, prim$1);
end

function link(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_link")(prim, prim$1);
end

function chmod(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_chmod")(prim, prim$1);
end

function fchmod(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_fchmod")(prim, prim$1);
end

function chown(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_chown")(prim, prim$1, prim$2);
end

function fchown(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_fchown")(prim, prim$1, prim$2);
end

function umask(prim) do
  return Caml_external_polyfill.resolve("unix_umask")(prim);
end

function access(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_access")(prim, prim$1);
end

function dup(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_dup")(prim, prim$1);
end

function dup2(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_dup2")(prim, prim$1, prim$2);
end

function set_nonblock(prim) do
  return Caml_external_polyfill.resolve("unix_set_nonblock")(prim);
end

function clear_nonblock(prim) do
  return Caml_external_polyfill.resolve("unix_clear_nonblock")(prim);
end

function set_close_on_exec(prim) do
  return Caml_external_polyfill.resolve("unix_set_close_on_exec")(prim);
end

function clear_close_on_exec(prim) do
  return Caml_external_polyfill.resolve("unix_clear_close_on_exec")(prim);
end

function mkdir(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_mkdir")(prim, prim$1);
end

function rmdir(prim) do
  return Caml_external_polyfill.resolve("unix_rmdir")(prim);
end

function chdir(prim) do
  return Caml_external_polyfill.resolve("unix_chdir")(prim);
end

function getcwd(prim) do
  return Caml_external_polyfill.resolve("unix_getcwd")(prim);
end

function chroot(prim) do
  return Caml_external_polyfill.resolve("unix_chroot")(prim);
end

function opendir(prim) do
  return Caml_external_polyfill.resolve("unix_opendir")(prim);
end

function readdir(prim) do
  return Caml_external_polyfill.resolve("unix_readdir")(prim);
end

function rewinddir(prim) do
  return Caml_external_polyfill.resolve("unix_rewinddir")(prim);
end

function closedir(prim) do
  return Caml_external_polyfill.resolve("unix_closedir")(prim);
end

function pipe(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_pipe")(prim, prim$1);
end

function mkfifo(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_mkfifo")(prim, prim$1);
end

function symlink(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_symlink")(prim, prim$1, prim$2);
end

function has_symlink(prim) do
  return Caml_external_polyfill.resolve("unix_has_symlink")(prim);
end

function readlink(prim) do
  return Caml_external_polyfill.resolve("unix_readlink")(prim);
end

function select(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_select")(prim, prim$1, prim$2, prim$3);
end

function lockf(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_lockf")(prim, prim$1, prim$2);
end

function kill(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_kill")(prim, prim$1);
end

function sigprocmask(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_sigprocmask")(prim, prim$1);
end

function sigpending(prim) do
  return Caml_external_polyfill.resolve("unix_sigpending")(prim);
end

function sigsuspend(prim) do
  return Caml_external_polyfill.resolve("unix_sigsuspend")(prim);
end

function time(prim) do
  return Caml_external_polyfill.resolve("unix_time")(prim);
end

function gettimeofday(prim) do
  return Caml_external_polyfill.resolve("unix_gettimeofday")(prim);
end

function gmtime(prim) do
  return Caml_external_polyfill.resolve("unix_gmtime")(prim);
end

function localtime(prim) do
  return Caml_external_polyfill.resolve("unix_localtime")(prim);
end

function mktime(prim) do
  return Caml_external_polyfill.resolve("unix_mktime")(prim);
end

function alarm(prim) do
  return Caml_external_polyfill.resolve("unix_alarm")(prim);
end

function sleepf(prim) do
  return Caml_external_polyfill.resolve("unix_sleep")(prim);
end

function times(prim) do
  return Caml_external_polyfill.resolve("unix_times")(prim);
end

function utimes(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_utimes")(prim, prim$1, prim$2);
end

function getitimer(prim) do
  return Caml_external_polyfill.resolve("unix_getitimer")(prim);
end

function setitimer(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_setitimer")(prim, prim$1);
end

function getuid(prim) do
  return Caml_external_polyfill.resolve("unix_getuid")(prim);
end

function geteuid(prim) do
  return Caml_external_polyfill.resolve("unix_geteuid")(prim);
end

function setuid(prim) do
  return Caml_external_polyfill.resolve("unix_setuid")(prim);
end

function getgid(prim) do
  return Caml_external_polyfill.resolve("unix_getgid")(prim);
end

function getegid(prim) do
  return Caml_external_polyfill.resolve("unix_getegid")(prim);
end

function setgid(prim) do
  return Caml_external_polyfill.resolve("unix_setgid")(prim);
end

function getgroups(prim) do
  return Caml_external_polyfill.resolve("unix_getgroups")(prim);
end

function setgroups(prim) do
  return Caml_external_polyfill.resolve("unix_setgroups")(prim);
end

function initgroups(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_initgroups")(prim, prim$1);
end

function getlogin(prim) do
  return Caml_external_polyfill.resolve("unix_getlogin")(prim);
end

function getpwnam(prim) do
  return Caml_external_polyfill.resolve("unix_getpwnam")(prim);
end

function getgrnam(prim) do
  return Caml_external_polyfill.resolve("unix_getgrnam")(prim);
end

function getpwuid(prim) do
  return Caml_external_polyfill.resolve("unix_getpwuid")(prim);
end

function getgrgid(prim) do
  return Caml_external_polyfill.resolve("unix_getgrgid")(prim);
end

function inet_addr_of_string(prim) do
  return Caml_external_polyfill.resolve("unix_inet_addr_of_string")(prim);
end

function string_of_inet_addr(prim) do
  return Caml_external_polyfill.resolve("unix_string_of_inet_addr")(prim);
end

function socket(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_socket")(prim, prim$1, prim$2, prim$3);
end

function socketpair(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_socketpair")(prim, prim$1, prim$2, prim$3);
end

function accept(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_accept")(prim, prim$1);
end

function bind(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_bind")(prim, prim$1);
end

function connect(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_connect")(prim, prim$1);
end

function listen(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_listen")(prim, prim$1);
end

function shutdown(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_shutdown")(prim, prim$1);
end

function getsockname(prim) do
  return Caml_external_polyfill.resolve("unix_getsockname")(prim);
end

function getpeername(prim) do
  return Caml_external_polyfill.resolve("unix_getpeername")(prim);
end

function gethostname(prim) do
  return Caml_external_polyfill.resolve("unix_gethostname")(prim);
end

function gethostbyname(prim) do
  return Caml_external_polyfill.resolve("unix_gethostbyname")(prim);
end

function gethostbyaddr(prim) do
  return Caml_external_polyfill.resolve("unix_gethostbyaddr")(prim);
end

function getprotobyname(prim) do
  return Caml_external_polyfill.resolve("unix_getprotobyname")(prim);
end

function getprotobynumber(prim) do
  return Caml_external_polyfill.resolve("unix_getprotobynumber")(prim);
end

function getservbyname(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_getservbyname")(prim, prim$1);
end

function getservbyport(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_getservbyport")(prim, prim$1);
end

function tcgetattr(prim) do
  return Caml_external_polyfill.resolve("unix_tcgetattr")(prim);
end

function tcsetattr(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_tcsetattr")(prim, prim$1, prim$2);
end

function tcsendbreak(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_tcsendbreak")(prim, prim$1);
end

function tcdrain(prim) do
  return Caml_external_polyfill.resolve("unix_tcdrain")(prim);
end

function tcflush(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_tcflush")(prim, prim$1);
end

function tcflow(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_tcflow")(prim, prim$1);
end

function setsid(prim) do
  return Caml_external_polyfill.resolve("unix_setsid")(prim);
end

exports.Unix_error = Unix_error;
exports.error_message = error_message;
exports.handle_unix_error = handle_unix_error;
exports.environment = environment;
exports.unsafe_environment = unsafe_environment;
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
exports.sleepf = sleepf;
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
--[  Not a pure module ]--
