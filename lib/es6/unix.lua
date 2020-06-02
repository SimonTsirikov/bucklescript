

import * as Sys from "./sys.lua";
import * as List from "./list.lua";
import * as __Array from "./array.lua";
import * as Block from "./block.lua";
import * as Curry from "./curry.lua";
import * as Printf from "./printf.lua";
import * as __String from "./string.lua";
import * as Caml_io from "./caml_io.lua";
import * as Hashtbl from "./hashtbl.lua";
import * as Callback from "./callback.lua";
import * as Caml_sys from "./caml_sys.lua";
import * as Filename from "./filename.lua";
import * as Printexc from "./printexc.lua";
import * as Caml_array from "./caml_array.lua";
import * as Caml_bytes from "./caml_bytes.lua";
import * as Pervasives from "./pervasives.lua";
import * as Caml_format from "./caml_format.lua";
import * as Caml_exceptions from "./caml_exceptions.lua";
import * as Caml_js_exceptions from "./caml_js_exceptions.lua";
import * as Caml_external_polyfill from "./caml_external_polyfill.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

Unix_error = Caml_exceptions.create("Unix.Unix_error");

Callback.register_exception("Unix.Unix_error", {
      Unix_error,
      --[[ E2BIG ]]0,
      "",
      ""
    });

Printexc.register_printer((function (param) do
        if (param[0] == Unix_error) then do
          e = param[1];
          msg;
          if (typeof e == "number") then do
            local ___conditional___=(e);
            do
               if ___conditional___ = 0--[[ E2BIG ]] then do
                  msg = "E2BIG";end else 
               if ___conditional___ = 1--[[ EACCES ]] then do
                  msg = "EACCES";end else 
               if ___conditional___ = 2--[[ EAGAIN ]] then do
                  msg = "EAGAIN";end else 
               if ___conditional___ = 3--[[ EBADF ]] then do
                  msg = "EBADF";end else 
               if ___conditional___ = 4--[[ EBUSY ]] then do
                  msg = "EBUSY";end else 
               if ___conditional___ = 5--[[ ECHILD ]] then do
                  msg = "ECHILD";end else 
               if ___conditional___ = 6--[[ EDEADLK ]] then do
                  msg = "EDEADLK";end else 
               if ___conditional___ = 7--[[ EDOM ]] then do
                  msg = "EDOM";end else 
               if ___conditional___ = 8--[[ EEXIST ]] then do
                  msg = "EEXIST";end else 
               if ___conditional___ = 9--[[ EFAULT ]] then do
                  msg = "EFAULT";end else 
               if ___conditional___ = 10--[[ EFBIG ]] then do
                  msg = "EFBIG";end else 
               if ___conditional___ = 11--[[ EINTR ]] then do
                  msg = "EINTR";end else 
               if ___conditional___ = 12--[[ EINVAL ]] then do
                  msg = "EINVAL";end else 
               if ___conditional___ = 13--[[ EIO ]] then do
                  msg = "EIO";end else 
               if ___conditional___ = 14--[[ EISDIR ]] then do
                  msg = "EISDIR";end else 
               if ___conditional___ = 15--[[ EMFILE ]] then do
                  msg = "EMFILE";end else 
               if ___conditional___ = 16--[[ EMLINK ]] then do
                  msg = "EMLINK";end else 
               if ___conditional___ = 17--[[ ENAMETOOLONG ]] then do
                  msg = "ENAMETOOLONG";end else 
               if ___conditional___ = 18--[[ ENFILE ]] then do
                  msg = "ENFILE";end else 
               if ___conditional___ = 19--[[ ENODEV ]] then do
                  msg = "ENODEV";end else 
               if ___conditional___ = 20--[[ ENOENT ]] then do
                  msg = "ENOENT";end else 
               if ___conditional___ = 21--[[ ENOEXEC ]] then do
                  msg = "ENOEXEC";end else 
               if ___conditional___ = 22--[[ ENOLCK ]] then do
                  msg = "ENOLCK";end else 
               if ___conditional___ = 23--[[ ENOMEM ]] then do
                  msg = "ENOMEM";end else 
               if ___conditional___ = 24--[[ ENOSPC ]] then do
                  msg = "ENOSPC";end else 
               if ___conditional___ = 25--[[ ENOSYS ]] then do
                  msg = "ENOSYS";end else 
               if ___conditional___ = 26--[[ ENOTDIR ]] then do
                  msg = "ENOTDIR";end else 
               if ___conditional___ = 27--[[ ENOTEMPTY ]] then do
                  msg = "ENOTEMPTY";end else 
               if ___conditional___ = 28--[[ ENOTTY ]] then do
                  msg = "ENOTTY";end else 
               if ___conditional___ = 29--[[ ENXIO ]] then do
                  msg = "ENXIO";end else 
               if ___conditional___ = 30--[[ EPERM ]] then do
                  msg = "EPERM";end else 
               if ___conditional___ = 31--[[ EPIPE ]] then do
                  msg = "EPIPE";end else 
               if ___conditional___ = 32--[[ ERANGE ]] then do
                  msg = "ERANGE";end else 
               if ___conditional___ = 33--[[ EROFS ]] then do
                  msg = "EROFS";end else 
               if ___conditional___ = 34--[[ ESPIPE ]] then do
                  msg = "ESPIPE";end else 
               if ___conditional___ = 35--[[ ESRCH ]] then do
                  msg = "ESRCH";end else 
               if ___conditional___ = 36--[[ EXDEV ]] then do
                  msg = "EXDEV";end else 
               if ___conditional___ = 37--[[ EWOULDBLOCK ]] then do
                  msg = "EWOULDBLOCK";end else 
               if ___conditional___ = 38--[[ EINPROGRESS ]] then do
                  msg = "EINPROGRESS";end else 
               if ___conditional___ = 39--[[ EALREADY ]] then do
                  msg = "EALREADY";end else 
               if ___conditional___ = 40--[[ ENOTSOCK ]] then do
                  msg = "ENOTSOCK";end else 
               if ___conditional___ = 41--[[ EDESTADDRREQ ]] then do
                  msg = "EDESTADDRREQ";end else 
               if ___conditional___ = 42--[[ EMSGSIZE ]] then do
                  msg = "EMSGSIZE";end else 
               if ___conditional___ = 43--[[ EPROTOTYPE ]] then do
                  msg = "EPROTOTYPE";end else 
               if ___conditional___ = 44--[[ ENOPROTOOPT ]] then do
                  msg = "ENOPROTOOPT";end else 
               if ___conditional___ = 45--[[ EPROTONOSUPPORT ]] then do
                  msg = "EPROTONOSUPPORT";end else 
               if ___conditional___ = 46--[[ ESOCKTNOSUPPORT ]] then do
                  msg = "ESOCKTNOSUPPORT";end else 
               if ___conditional___ = 47--[[ EOPNOTSUPP ]] then do
                  msg = "EOPNOTSUPP";end else 
               if ___conditional___ = 48--[[ EPFNOSUPPORT ]] then do
                  msg = "EPFNOSUPPORT";end else 
               if ___conditional___ = 49--[[ EAFNOSUPPORT ]] then do
                  msg = "EAFNOSUPPORT";end else 
               if ___conditional___ = 50--[[ EADDRINUSE ]] then do
                  msg = "EADDRINUSE";end else 
               if ___conditional___ = 51--[[ EADDRNOTAVAIL ]] then do
                  msg = "EADDRNOTAVAIL";end else 
               if ___conditional___ = 52--[[ ENETDOWN ]] then do
                  msg = "ENETDOWN";end else 
               if ___conditional___ = 53--[[ ENETUNREACH ]] then do
                  msg = "ENETUNREACH";end else 
               if ___conditional___ = 54--[[ ENETRESET ]] then do
                  msg = "ENETRESET";end else 
               if ___conditional___ = 55--[[ ECONNABORTED ]] then do
                  msg = "ECONNABORTED";end else 
               if ___conditional___ = 56--[[ ECONNRESET ]] then do
                  msg = "ECONNRESET";end else 
               if ___conditional___ = 57--[[ ENOBUFS ]] then do
                  msg = "ENOBUFS";end else 
               if ___conditional___ = 58--[[ EISCONN ]] then do
                  msg = "EISCONN";end else 
               if ___conditional___ = 59--[[ ENOTCONN ]] then do
                  msg = "ENOTCONN";end else 
               if ___conditional___ = 60--[[ ESHUTDOWN ]] then do
                  msg = "ESHUTDOWN";end else 
               if ___conditional___ = 61--[[ ETOOMANYREFS ]] then do
                  msg = "ETOOMANYREFS";end else 
               if ___conditional___ = 62--[[ ETIMEDOUT ]] then do
                  msg = "ETIMEDOUT";end else 
               if ___conditional___ = 63--[[ ECONNREFUSED ]] then do
                  msg = "ECONNREFUSED";end else 
               if ___conditional___ = 64--[[ EHOSTDOWN ]] then do
                  msg = "EHOSTDOWN";end else 
               if ___conditional___ = 65--[[ EHOSTUNREACH ]] then do
                  msg = "EHOSTUNREACH";end else 
               if ___conditional___ = 66--[[ ELOOP ]] then do
                  msg = "ELOOP";end else 
               if ___conditional___ = 67--[[ EOVERFLOW ]] then do
                  msg = "EOVERFLOW";end else 
               do end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end
              
            end
          end else do
            msg = Curry._1(Printf.sprintf(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "EUNKNOWNERR ",
                          --[[ Int ]]Block.__(4, {
                              --[[ Int_d ]]0,
                              --[[ No_padding ]]0,
                              --[[ No_precision ]]0,
                              --[[ End_of_format ]]0
                            })
                        }),
                      "EUNKNOWNERR %d"
                    }), e[0]);
          end end 
          return Curry._3(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Unix.Unix_error(Unix.",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ", ",
                                      --[[ Caml_string ]]Block.__(3, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ", ",
                                              --[[ Caml_string ]]Block.__(3, {
                                                  --[[ No_padding ]]0,
                                                  --[[ Char_literal ]]Block.__(12, {
                                                      --[[ ")" ]]41,
                                                      --[[ End_of_format ]]0
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "Unix.Unix_error(Unix.%s, %S, %S)"
                        }), msg, param[2], param[3]);
        end
         end 
      end end));

function handle_unix_error(f, arg) do
  xpcall(function() do
    return Curry._1(f, arg);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Unix_error) then do
      arg$1 = exn[3];
      Pervasives.prerr_string(Caml_array.caml_array_get(Sys.argv, 0));
      Pervasives.prerr_string(": \"");
      Pervasives.prerr_string(exn[2]);
      Pervasives.prerr_string("\" failed");
      if (#arg$1 ~= 0) then do
        Pervasives.prerr_string(" on \"");
        Pervasives.prerr_string(arg$1);
        Pervasives.prerr_string("\"");
      end
       end 
      Pervasives.prerr_string(": ");
      console.error(Caml_external_polyfill.resolve("unix_error_message")(exn[1]));
      return Pervasives.exit(2);
    end else do
      error (exn)
    end end 
  end end)
end end

function execvpe(name, args, env) do
  xpcall(function() do
    return Caml_external_polyfill.resolve("unix_execvpe")(name, args, env);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Unix_error) then do
      match = exn[1];
      if (typeof match == "number") then do
        if (match ~= 25) then do
          error (exn)
        end
         end 
        name$1 = name;
        args$1 = args;
        env$1 = env;
        exec = function (file) do
          xpcall(function() do
            return Caml_external_polyfill.resolve("unix_execve")(file, args$1, env$1);
          end end,function(raw_exn) return do
            exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
            if (exn[0] == Unix_error) then do
              match = exn[1];
              if (typeof match == "number") then do
                if (match ~= 21) then do
                  error (exn)
                end
                 end 
                argc = #args$1;
                new_args = __Array.append({
                      "/bin/sh",
                      file
                    }, argc == 0 and args$1 or __Array.sub(args$1, 1, argc - 1 | 0));
                return Caml_external_polyfill.resolve("unix_execve")(Caml_array.caml_array_get(new_args, 0), new_args, env$1);
              end else do
                error (exn)
              end end 
            end else do
              error (exn)
            end end 
          end end)
        end end;
        if (__String.contains(name$1, --[[ "/" ]]47)) then do
          return exec(name$1);
        end else do
          tmp;
          xpcall(function() do
            tmp = Caml_external_polyfill.resolve("caml_sys_unsafe_getenv")("PATH");
          end end,function(exn$1) return do
            if (exn$1 == Caml_builtin_exceptions.not_found) then do
              tmp = "/bin:/usr/bin";
            end else do
              error (exn$1)
            end end 
          end end)
          _eacces = false;
          _param = __String.split_on_char(--[[ ":" ]]58, tmp);
          while(true) do
            param = _param;
            eacces = _eacces;
            if (param) then do
              rem = param[1];
              dir = param[0];
              dir$1 = dir == "" and Filename.current_dir_name or dir;
              xpcall(function() do
                return exec(Filename.concat(dir$1, name$1));
              end end,function(raw_exn$1) return do
                exn$2 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
                if (exn$2[0] == Unix_error) then do
                  err = exn$2[1];
                  if (typeof err == "number") then do
                    switcher = err - 62 | 0;
                    if (switcher > 4 or switcher < 0) then do
                      if (switcher >= -35) then do
                        error (exn$2)
                      end
                       end 
                      local ___conditional___=(switcher + 62 | 0);
                      do
                         if ___conditional___ = 1--[[ EACCES ]] then do
                            _param = rem;
                            _eacces = true;
                            ::continue:: ;end end end 
                         if ___conditional___ = 0--[[ E2BIG ]]
                         or ___conditional___ = 2--[[ EAGAIN ]]
                         or ___conditional___ = 3--[[ EBADF ]]
                         or ___conditional___ = 4--[[ EBUSY ]]
                         or ___conditional___ = 5--[[ ECHILD ]]
                         or ___conditional___ = 6--[[ EDEADLK ]]
                         or ___conditional___ = 7--[[ EDOM ]]
                         or ___conditional___ = 8--[[ EEXIST ]]
                         or ___conditional___ = 9--[[ EFAULT ]]
                         or ___conditional___ = 10--[[ EFBIG ]]
                         or ___conditional___ = 11--[[ EINTR ]]
                         or ___conditional___ = 12--[[ EINVAL ]]
                         or ___conditional___ = 13--[[ EIO ]]
                         or ___conditional___ = 15--[[ EMFILE ]]
                         or ___conditional___ = 16--[[ EMLINK ]]
                         or ___conditional___ = 18--[[ ENFILE ]]
                         or ___conditional___ = 21--[[ ENOEXEC ]]
                         or ___conditional___ = 22--[[ ENOLCK ]]
                         or ___conditional___ = 23--[[ ENOMEM ]]
                         or ___conditional___ = 24--[[ ENOSPC ]]
                         or ___conditional___ = 25--[[ ENOSYS ]] then do
                            error (exn$2)end end end 
                         if ___conditional___ = 14--[[ EISDIR ]]
                         or ___conditional___ = 17--[[ ENAMETOOLONG ]]
                         or ___conditional___ = 19--[[ ENODEV ]]
                         or ___conditional___ = 20--[[ ENOENT ]]
                         or ___conditional___ = 26--[[ ENOTDIR ]] then do
                            _param = rem;
                            ::continue:: ;end end end 
                         do
                        
                      end
                    end else if (switcher > 3 or switcher < 1) then do
                      _param = rem;
                      ::continue:: ;
                    end else do
                      error (exn$2)
                    end end  end 
                  end else do
                    error (exn$2)
                  end end 
                end else do
                  error (exn$2)
                end end 
              end end)
            end else do
              error ({
                Unix_error,
                eacces and --[[ EACCES ]]1 or --[[ ENOENT ]]20,
                "execvpe",
                name$1
              })
            end end 
          end;
        end end 
      end else do
        error (exn)
      end end 
    end else do
      error (exn)
    end end 
  end end)
end end

function read(fd, buf, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Unix.read"
    })
  end
   end 
  return Caml_external_polyfill.resolve("unix_read")(fd, buf, ofs, len);
end end

function write(fd, buf, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Unix.write"
    })
  end
   end 
  return Caml_external_polyfill.resolve("unix_write")(fd, buf, ofs, len);
end end

function single_write(fd, buf, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Unix.single_write"
    })
  end
   end 
  return Caml_external_polyfill.resolve("unix_single_write")(fd, buf, ofs, len);
end end

function write_substring(fd, buf, ofs, len) do
  return write(fd, Caml_bytes.bytes_of_string(buf), ofs, len);
end end

function single_write_substring(fd, buf, ofs, len) do
  return single_write(fd, Caml_bytes.bytes_of_string(buf), ofs, len);
end end

function map_file(fd, posOpt, kind, layout, shared, dims) do
  pos = posOpt ~= undefined and posOpt or --[[ int64 ]]{
      --[[ hi ]]0,
      --[[ lo ]]0
    };
  return Caml_external_polyfill.resolve("caml_unix_map_file_bytecode")(fd, kind, layout, shared, dims, pos);
end end

function pause(param) do
  return Caml_external_polyfill.resolve("unix_sigsuspend")(Caml_external_polyfill.resolve("unix_sigprocmask")(--[[ SIG_BLOCK ]]1, --[[ [] ]]0));
end end

function sleep(duration) do
  return Caml_external_polyfill.resolve("unix_sleep")(duration);
end end

inet_addr_any = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("0.0.0.0");

inet_addr_loopback = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("127.0.0.1");

inet6_addr_any;

xpcall(function() do
  inet6_addr_any = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("::");
end end,function(raw_exn) return do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.failure) then do
    inet6_addr_any = inet_addr_any;
  end else do
    error (exn)
  end end 
end end)

inet6_addr_loopback;

xpcall(function() do
  inet6_addr_loopback = Caml_external_polyfill.resolve("unix_inet_addr_of_string")("::1");
end end,function(raw_exn$1) return do
  exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
  if (exn$1[0] == Caml_builtin_exceptions.failure) then do
    inet6_addr_loopback = inet_addr_loopback;
  end else do
    error (exn$1)
  end end 
end end)

function domain_of_sockaddr(param) do
  if (param.tag) then do
    if (#param[0] == 16) then do
      return --[[ PF_INET6 ]]2;
    end else do
      return --[[ PF_INET ]]1;
    end end 
  end else do
    return --[[ PF_UNIX ]]0;
  end end 
end end

function recv(fd, buf, ofs, len, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Unix.recv"
    })
  end
   end 
  return Caml_external_polyfill.resolve("unix_recv")(fd, buf, ofs, len, flags);
end end

function recvfrom(fd, buf, ofs, len, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Unix.recvfrom"
    })
  end
   end 
  return Caml_external_polyfill.resolve("unix_recvfrom")(fd, buf, ofs, len, flags);
end end

function send(fd, buf, ofs, len, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Unix.send"
    })
  end
   end 
  return Caml_external_polyfill.resolve("unix_send")(fd, buf, ofs, len, flags);
end end

function sendto(fd, buf, ofs, len, flags, addr) do
  if (ofs < 0 or len < 0 or ofs > (#buf - len | 0)) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Unix.sendto"
    })
  end
   end 
  return Caml_external_polyfill.resolve("unix_sendto")(fd, buf, ofs, len, flags, addr);
end end

function send_substring(fd, buf, ofs, len, flags) do
  return send(fd, Caml_bytes.bytes_of_string(buf), ofs, len, flags);
end end

function sendto_substring(fd, buf, ofs, len, flags, addr) do
  return sendto(fd, Caml_bytes.bytes_of_string(buf), ofs, len, flags, addr);
end end

function SO_get(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_getsockopt")(prim, prim$1, prim$2);
end end

function SO_set(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_setsockopt")(prim, prim$1, prim$2, prim$3);
end end

function getsockopt(fd, opt) do
  return Curry._3(SO_get, 0, fd, opt);
end end

function setsockopt(fd, opt, v) do
  return Curry._4(SO_set, 0, fd, opt, v);
end end

function getsockopt_int(fd, opt) do
  return Curry._3(SO_get, 1, fd, opt);
end end

function setsockopt_int(fd, opt, v) do
  return Curry._4(SO_set, 1, fd, opt, v);
end end

function getsockopt_optint(fd, opt) do
  return Curry._3(SO_get, 2, fd, opt);
end end

function setsockopt_optint(fd, opt, v) do
  return Curry._4(SO_set, 2, fd, opt, v);
end end

function getsockopt_float(fd, opt) do
  return Curry._3(SO_get, 3, fd, opt);
end end

function setsockopt_float(fd, opt, v) do
  return Curry._4(SO_set, 3, fd, opt, v);
end end

function getsockopt_error(fd) do
  return Curry._3(SO_get, 4, fd, --[[ SO_ERROR ]]0);
end end

function getaddrinfo(node, service, opts) do
  xpcall(function() do
    return List.rev(Caml_external_polyfill.resolve("unix_getaddrinfo")(node, service, opts));
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) then do
      node$1 = node;
      service$1 = service;
      opts$1 = opts;
      opt_socktype = do
        contents: undefined
      end;
      opt_protocol = do
        contents: 0
      end;
      opt_passive = do
        contents: false
      end;
      List.iter((function (param) do
              if (typeof param == "number") then do
                if (param == --[[ AI_PASSIVE ]]2) then do
                  opt_passive.contents = true;
                  return --[[ () ]]0;
                end else do
                  return --[[ () ]]0;
                end end 
              end else do
                local ___conditional___=(param.tag | 0);
                do
                   if ___conditional___ = 1--[[ AI_SOCKTYPE ]] then do
                      opt_socktype.contents = param[0];
                      return --[[ () ]]0;end end end 
                   if ___conditional___ = 2--[[ AI_PROTOCOL ]] then do
                      opt_protocol.contents = param[0];
                      return --[[ () ]]0;end end end 
                   do
                  else do
                    return --[[ () ]]0;
                    end end
                    
                end
              end end 
            end end), opts$1);
      get_port = function (ty, kind) do
        if (service$1 == "") then do
          return --[[ :: ]]{
                  --[[ tuple ]]{
                    ty,
                    0
                  },
                  --[[ [] ]]0
                };
        end else do
          xpcall(function() do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      ty,
                      Caml_format.caml_int_of_string(service$1)
                    },
                    --[[ [] ]]0
                  };
          end end,function(raw_exn) return do
            exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
            if (exn[0] == Caml_builtin_exceptions.failure) then do
              xpcall(function() do
                return --[[ :: ]]{
                        --[[ tuple ]]{
                          ty,
                          Caml_external_polyfill.resolve("unix_getservbyname")(service$1, kind).s_port
                        },
                        --[[ [] ]]0
                      };
              end end,function(exn$1) return do
                if (exn$1 == Caml_builtin_exceptions.not_found) then do
                  return --[[ [] ]]0;
                end else do
                  error (exn$1)
                end end 
              end end)
            end else do
              error (exn)
            end end 
          end end)
        end end 
      end end;
      match = opt_socktype.contents;
      ports;
      if (match ~= undefined) then do
        ty = match;
        ports = ty ~= 1 and (
            ty ~= 0 and (
                service$1 == "" and --[[ :: ]]{
                    --[[ tuple ]]{
                      ty,
                      0
                    },
                    --[[ [] ]]0
                  } or --[[ [] ]]0
              ) or get_port(--[[ SOCK_STREAM ]]0, "tcp")
          ) or get_port(--[[ SOCK_DGRAM ]]1, "udp");
      end else do
        ports = Pervasives.$at(get_port(--[[ SOCK_STREAM ]]0, "tcp"), get_port(--[[ SOCK_DGRAM ]]1, "udp"));
      end end 
      addresses;
      if (node$1 == "") then do
        addresses = List.mem(--[[ AI_PASSIVE ]]2, opts$1) and --[[ :: ]]{
            --[[ tuple ]]{
              inet_addr_any,
              "0.0.0.0"
            },
            --[[ [] ]]0
          } or --[[ :: ]]{
            --[[ tuple ]]{
              inet_addr_loopback,
              "127.0.0.1"
            },
            --[[ [] ]]0
          };
      end else do
        xpcall(function() do
          addresses = --[[ :: ]]{
            --[[ tuple ]]{
              Caml_external_polyfill.resolve("unix_inet_addr_of_string")(node$1),
              node$1
            },
            --[[ [] ]]0
          };
        end end,function(raw_exn$1) return do
          exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
          if (exn$1[0] == Caml_builtin_exceptions.failure) then do
            xpcall(function() do
              he = Caml_external_polyfill.resolve("unix_gethostbyname")(node$1);
              addresses = List.map((function (a) do
                      return --[[ tuple ]]{
                              a,
                              he.h_name
                            };
                    end end), __Array.to_list(he.h_addr_list));
            end end,function(exn$2) return do
              if (exn$2 == Caml_builtin_exceptions.not_found) then do
                addresses = --[[ [] ]]0;
              end else do
                error (exn$2)
              end end 
            end end)
          end else do
            error (exn$1)
          end end 
        end end)
      end end 
      return List.flatten(List.map((function (param) do
                        port = param[1];
                        ty = param[0];
                        return List.map((function (param) do
                                      return do
                                              ai_family: --[[ PF_INET ]]1,
                                              ai_socktype: ty,
                                              ai_protocol: opt_protocol.contents,
                                              ai_addr: --[[ ADDR_INET ]]Block.__(1, {
                                                  param[0],
                                                  port
                                                }),
                                              ai_canonname: param[1]
                                            end;
                                    end end), addresses);
                      end end), ports));
    end else do
      error (exn)
    end end 
  end end)
end end

function getnameinfo(addr, opts) do
  xpcall(function() do
    return Caml_external_polyfill.resolve("unix_getnameinfo")(addr, opts);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) then do
      addr$1 = addr;
      opts$1 = opts;
      if (addr$1.tag) then do
        p = addr$1[1];
        a = addr$1[0];
        hostname;
        xpcall(function() do
          if (List.mem(--[[ NI_NUMERICHOST ]]1, opts$1)) then do
            error (Caml_builtin_exceptions.not_found)
          end
           end 
          hostname = Caml_external_polyfill.resolve("unix_gethostbyaddr")(a).h_name;
        end end,function(exn$1) return do
          if (exn$1 == Caml_builtin_exceptions.not_found) then do
            if (List.mem(--[[ NI_NAMEREQD ]]2, opts$1)) then do
              error (Caml_builtin_exceptions.not_found)
            end
             end 
            hostname = Caml_external_polyfill.resolve("unix_string_of_inet_addr")(a);
          end else do
            error (exn$1)
          end end 
        end end)
        service;
        xpcall(function() do
          if (List.mem(--[[ NI_NUMERICSERV ]]3, opts$1)) then do
            error (Caml_builtin_exceptions.not_found)
          end
           end 
          kind = List.mem(--[[ NI_DGRAM ]]4, opts$1) and "udp" or "tcp";
          service = Caml_external_polyfill.resolve("unix_getservbyport")(p, kind).s_name;
        end end,function(exn$2) return do
          if (exn$2 == Caml_builtin_exceptions.not_found) then do
            service = String(p);
          end else do
            error (exn$2)
          end end 
        end end)
        return do
                ni_hostname: hostname,
                ni_service: service
              end;
      end else do
        return do
                ni_hostname: "",
                ni_service: addr$1[0]
              end;
      end end 
    end else do
      error (exn)
    end end 
  end end)
end end

function waitpid_non_intr(pid) do
  while(true) do
    xpcall(function() do
      return Caml_external_polyfill.resolve("unix_waitpid")(--[[ [] ]]0, pid);
    end end,function(raw_exn) return do
      exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn[0] == Unix_error) then do
        match = exn[1];
        if (typeof match == "number") then do
          if (match ~= 11) then do
            error (exn)
          end
           end 
          ::continue:: ;
        end else do
          error (exn)
        end end 
      end else do
        error (exn)
      end end 
    end end)
  end;
end end

function system(cmd) do
  id = Caml_external_polyfill.resolve("unix_fork")(--[[ () ]]0);
  if (id ~= 0) then do
    return waitpid_non_intr(id)[1];
  end else do
    xpcall(function() do
      return Caml_external_polyfill.resolve("unix_execv")("/bin/sh", {
                  "/bin/sh",
                  "-c",
                  cmd
                });
    end end,function(exn) return do
      return Caml_sys.caml_sys_exit(127);
    end end)
  end end 
end end

function file_descr_not_standard(_fd) do
  while(true) do
    fd = _fd;
    if (fd >= 3) then do
      return fd;
    end else do
      _fd = Caml_external_polyfill.resolve("unix_dup")(undefined, fd);
      ::continue:: ;
    end end 
  end;
end end

function safe_close(fd) do
  xpcall(function() do
    return Caml_external_polyfill.resolve("unix_close")(fd);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Unix_error) then do
      return --[[ () ]]0;
    end else do
      error (exn)
    end end 
  end end)
end end

function perform_redirections(new_stdin, new_stdout, new_stderr) do
  new_stdin$1 = file_descr_not_standard(new_stdin);
  new_stdout$1 = file_descr_not_standard(new_stdout);
  new_stderr$1 = file_descr_not_standard(new_stderr);
  Caml_external_polyfill.resolve("unix_dup2")(false, new_stdin$1, 0);
  Caml_external_polyfill.resolve("unix_dup2")(false, new_stdout$1, 1);
  Caml_external_polyfill.resolve("unix_dup2")(false, new_stderr$1, 2);
  safe_close(new_stdin$1);
  safe_close(new_stdout$1);
  return safe_close(new_stderr$1);
end end

function create_process(cmd, args, new_stdin, new_stdout, new_stderr) do
  id = Caml_external_polyfill.resolve("unix_fork")(--[[ () ]]0);
  if (id ~= 0) then do
    return id;
  end else do
    xpcall(function() do
      perform_redirections(new_stdin, new_stdout, new_stderr);
      return Caml_external_polyfill.resolve("unix_execvp")(cmd, args);
    end end,function(exn) return do
      return Caml_sys.caml_sys_exit(127);
    end end)
  end end 
end end

function create_process_env(cmd, args, env, new_stdin, new_stdout, new_stderr) do
  id = Caml_external_polyfill.resolve("unix_fork")(--[[ () ]]0);
  if (id ~= 0) then do
    return id;
  end else do
    xpcall(function() do
      perform_redirections(new_stdin, new_stdout, new_stderr);
      return execvpe(cmd, args, env);
    end end,function(exn) return do
      return Caml_sys.caml_sys_exit(127);
    end end)
  end end 
end end

popen_processes = Hashtbl.create(undefined, 7);

function open_proc(cmd, envopt, proc, input, output, error) do
  id = Caml_external_polyfill.resolve("unix_fork")(--[[ () ]]0);
  if (id ~= 0) then do
    return Hashtbl.add(popen_processes, proc, id);
  end else do
    perform_redirections(input, output, error);
    shell = "/bin/sh";
    argv = {
      shell,
      "-c",
      cmd
    };
    xpcall(function() do
      if (envopt ~= undefined) then do
        return Caml_external_polyfill.resolve("unix_execve")(shell, argv, envopt);
      end else do
        return Caml_external_polyfill.resolve("unix_execv")(shell, argv);
      end end 
    end end,function(exn) return do
      return Caml_sys.caml_sys_exit(127);
    end end)
  end end 
end end

function open_process_in(cmd) do
  match = Caml_external_polyfill.resolve("unix_pipe")(true, --[[ () ]]0);
  in_write = match[1];
  inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(match[0]);
  xpcall(function() do
    open_proc(cmd, undefined, --[[ Process_in ]]Block.__(1, {inchan}), 0, in_write, 2);
  end end,function(e) return do
    Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    error (e)
  end end)
  Caml_external_polyfill.resolve("unix_close")(in_write);
  return inchan;
end end

function open_process_out(cmd) do
  match = Caml_external_polyfill.resolve("unix_pipe")(true, --[[ () ]]0);
  out_read = match[0];
  outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(match[1]);
  xpcall(function() do
    open_proc(cmd, undefined, --[[ Process_out ]]Block.__(2, {outchan}), out_read, 1, 2);
  end end,function(e) return do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
    Caml_external_polyfill.resolve("unix_close")(out_read);
    error (e)
  end end)
  Caml_external_polyfill.resolve("unix_close")(out_read);
  return outchan;
end end

function open_process(cmd) do
  match = Caml_external_polyfill.resolve("unix_pipe")(true, --[[ () ]]0);
  in_write = match[1];
  in_read = match[0];
  match$1;
  xpcall(function() do
    match$1 = Caml_external_polyfill.resolve("unix_pipe")(true, --[[ () ]]0);
  end end,function(e) return do
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    error (e)
  end end)
  out_write = match$1[1];
  out_read = match$1[0];
  inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(in_read);
  outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(out_write);
  xpcall(function() do
    open_proc(cmd, undefined, --[[ Process ]]Block.__(0, {
            inchan,
            outchan
          }), out_read, in_write, 2);
  end end,function(e$1) return do
    Caml_external_polyfill.resolve("unix_close")(out_read);
    Caml_external_polyfill.resolve("unix_close")(out_write);
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    error (e$1)
  end end)
  Caml_external_polyfill.resolve("unix_close")(out_read);
  Caml_external_polyfill.resolve("unix_close")(in_write);
  return --[[ tuple ]]{
          inchan,
          outchan
        };
end end

function open_process_full(cmd, env) do
  match = Caml_external_polyfill.resolve("unix_pipe")(true, --[[ () ]]0);
  in_write = match[1];
  in_read = match[0];
  match$1;
  xpcall(function() do
    match$1 = Caml_external_polyfill.resolve("unix_pipe")(true, --[[ () ]]0);
  end end,function(e) return do
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    error (e)
  end end)
  out_write = match$1[1];
  out_read = match$1[0];
  match$2;
  xpcall(function() do
    match$2 = Caml_external_polyfill.resolve("unix_pipe")(true, --[[ () ]]0);
  end end,function(e$1) return do
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    Caml_external_polyfill.resolve("unix_close")(out_read);
    Caml_external_polyfill.resolve("unix_close")(out_write);
    error (e$1)
  end end)
  err_write = match$2[1];
  err_read = match$2[0];
  inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(in_read);
  outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(out_write);
  errchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(err_read);
  xpcall(function() do
    open_proc(cmd, env, --[[ Process_full ]]Block.__(3, {
            inchan,
            outchan,
            errchan
          }), out_read, in_write, err_write);
  end end,function(e$2) return do
    Caml_external_polyfill.resolve("unix_close")(out_read);
    Caml_external_polyfill.resolve("unix_close")(out_write);
    Caml_external_polyfill.resolve("unix_close")(in_read);
    Caml_external_polyfill.resolve("unix_close")(in_write);
    Caml_external_polyfill.resolve("unix_close")(err_read);
    Caml_external_polyfill.resolve("unix_close")(err_write);
    error (e$2)
  end end)
  Caml_external_polyfill.resolve("unix_close")(out_read);
  Caml_external_polyfill.resolve("unix_close")(in_write);
  Caml_external_polyfill.resolve("unix_close")(err_write);
  return --[[ tuple ]]{
          inchan,
          outchan,
          errchan
        };
end end

function find_proc_id(fun_name, proc) do
  xpcall(function() do
    pid = Hashtbl.find(popen_processes, proc);
    Hashtbl.remove(popen_processes, proc);
    return pid;
  end end,function(exn) return do
    if (exn == Caml_builtin_exceptions.not_found) then do
      error ({
        Unix_error,
        --[[ EBADF ]]3,
        fun_name,
        ""
      })
    end
     end 
    error (exn)
  end end)
end end

function close_process_in(inchan) do
  pid = find_proc_id("close_process_in", --[[ Process_in ]]Block.__(1, {inchan}));
  Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
  return waitpid_non_intr(pid)[1];
end end

function close_process_out(outchan) do
  pid = find_proc_id("close_process_out", --[[ Process_out ]]Block.__(2, {outchan}));
  xpcall(function() do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] ~= Caml_builtin_exceptions.sys_error) then do
      error (exn)
    end
     end 
  end end)
  return waitpid_non_intr(pid)[1];
end end

function close_process(param) do
  outchan = param[1];
  inchan = param[0];
  pid = find_proc_id("close_process", --[[ Process ]]Block.__(0, {
          inchan,
          outchan
        }));
  Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
  xpcall(function() do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] ~= Caml_builtin_exceptions.sys_error) then do
      error (exn)
    end
     end 
  end end)
  return waitpid_non_intr(pid)[1];
end end

function close_process_full(param) do
  errchan = param[2];
  outchan = param[1];
  inchan = param[0];
  pid = find_proc_id("close_process_full", --[[ Process_full ]]Block.__(3, {
          inchan,
          outchan,
          errchan
        }));
  Caml_external_polyfill.resolve("caml_ml_close_channel")(inchan);
  xpcall(function() do
    Caml_io.caml_ml_flush(outchan);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(outchan);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] ~= Caml_builtin_exceptions.sys_error) then do
      error (exn)
    end
     end 
  end end)
  Caml_external_polyfill.resolve("caml_ml_close_channel")(errchan);
  return waitpid_non_intr(pid)[1];
end end

function open_connection(sockaddr) do
  sock = Caml_external_polyfill.resolve("unix_socket")(true, domain_of_sockaddr(sockaddr), --[[ SOCK_STREAM ]]0, 0);
  xpcall(function() do
    Caml_external_polyfill.resolve("unix_connect")(sock, sockaddr);
    return --[[ tuple ]]{
            Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(sock),
            Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(sock)
          };
  end end,function(exn) return do
    Caml_external_polyfill.resolve("unix_close")(sock);
    error (exn)
  end end)
end end

function shutdown_connection(inchan) do
  return Caml_external_polyfill.resolve("unix_shutdown")(Caml_external_polyfill.resolve("caml_channel_descriptor")(inchan), --[[ SHUTDOWN_SEND ]]1);
end end

function accept_non_intr(s) do
  while(true) do
    xpcall(function() do
      return Caml_external_polyfill.resolve("unix_accept")(true, s);
    end end,function(raw_exn) return do
      exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn[0] == Unix_error) then do
        match = exn[1];
        if (typeof match == "number") then do
          if (match ~= 11) then do
            error (exn)
          end
           end 
          ::continue:: ;
        end else do
          error (exn)
        end end 
      end else do
        error (exn)
      end end 
    end end)
  end;
end end

function establish_server(server_fun, sockaddr) do
  sock = Caml_external_polyfill.resolve("unix_socket")(true, domain_of_sockaddr(sockaddr), --[[ SOCK_STREAM ]]0, 0);
  setsockopt(sock, --[[ SO_REUSEADDR ]]2, true);
  Caml_external_polyfill.resolve("unix_bind")(sock, sockaddr);
  Caml_external_polyfill.resolve("unix_listen")(sock, 5);
  while(true) do
    match = accept_non_intr(sock);
    s = match[0];
    id = Caml_external_polyfill.resolve("unix_fork")(--[[ () ]]0);
    if (id ~= 0) then do
      Caml_external_polyfill.resolve("unix_close")(s);
      waitpid_non_intr(id);
    end else do
      if (Caml_external_polyfill.resolve("unix_fork")(--[[ () ]]0) ~= 0) then do
        Caml_sys.caml_sys_exit(0);
      end
       end 
      Caml_external_polyfill.resolve("unix_close")(sock);
      inchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(s);
      outchan = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(s);
      Curry._2(server_fun, inchan, outchan);
      Pervasives.exit(0);
    end end 
  end;
  return --[[ () ]]0;
end end

function error_message(prim) do
  return Caml_external_polyfill.resolve("unix_error_message")(prim);
end end

function environment(prim) do
  return Caml_external_polyfill.resolve("unix_environment")(prim);
end end

function unsafe_environment(prim) do
  return Caml_external_polyfill.resolve("unix_environment_unsafe")(prim);
end end

getenv = Caml_sys.caml_sys_getenv;

function unsafe_getenv(prim) do
  return Caml_external_polyfill.resolve("caml_sys_unsafe_getenv")(prim);
end end

function putenv(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_putenv")(prim, prim$1);
end end

function execv(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_execv")(prim, prim$1);
end end

function execve(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_execve")(prim, prim$1, prim$2);
end end

function execvp(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_execvp")(prim, prim$1);
end end

function fork(prim) do
  return Caml_external_polyfill.resolve("unix_fork")(prim);
end end

function wait(prim) do
  return Caml_external_polyfill.resolve("unix_wait")(prim);
end end

function waitpid(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_waitpid")(prim, prim$1);
end end

function getpid(prim) do
  return Caml_external_polyfill.resolve("unix_getpid")(prim);
end end

function getppid(prim) do
  return Caml_external_polyfill.resolve("unix_getppid")(prim);
end end

function nice(prim) do
  return Caml_external_polyfill.resolve("unix_nice")(prim);
end end

stdin = 0;

stdout = 1;

stderr = 2;

function openfile(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_open")(prim, prim$1, prim$2);
end end

function close(prim) do
  return Caml_external_polyfill.resolve("unix_close")(prim);
end end

function in_channel_of_descr(prim) do
  return Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(prim);
end end

function out_channel_of_descr(prim) do
  return Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(prim);
end end

function descr_of_in_channel(prim) do
  return Caml_external_polyfill.resolve("caml_channel_descriptor")(prim);
end end

function descr_of_out_channel(prim) do
  return Caml_external_polyfill.resolve("caml_channel_descriptor")(prim);
end end

function lseek(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_lseek")(prim, prim$1, prim$2);
end end

function truncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_truncate")(prim, prim$1);
end end

function ftruncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_ftruncate")(prim, prim$1);
end end

function stat(prim) do
  return Caml_external_polyfill.resolve("unix_stat")(prim);
end end

function lstat(prim) do
  return Caml_external_polyfill.resolve("unix_lstat")(prim);
end end

function fstat(prim) do
  return Caml_external_polyfill.resolve("unix_fstat")(prim);
end end

function isatty(prim) do
  return Caml_external_polyfill.resolve("unix_isatty")(prim);
end end

function LargeFile_lseek(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_lseek_64")(prim, prim$1, prim$2);
end end

function LargeFile_truncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_truncate_64")(prim, prim$1);
end end

function LargeFile_ftruncate(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_ftruncate_64")(prim, prim$1);
end end

function LargeFile_stat(prim) do
  return Caml_external_polyfill.resolve("unix_stat_64")(prim);
end end

function LargeFile_lstat(prim) do
  return Caml_external_polyfill.resolve("unix_lstat_64")(prim);
end end

function LargeFile_fstat(prim) do
  return Caml_external_polyfill.resolve("unix_fstat_64")(prim);
end end

LargeFile = do
  lseek: LargeFile_lseek,
  truncate: LargeFile_truncate,
  ftruncate: LargeFile_ftruncate,
  stat: LargeFile_stat,
  lstat: LargeFile_lstat,
  fstat: LargeFile_fstat
end;

function unlink(prim) do
  return Caml_external_polyfill.resolve("unix_unlink")(prim);
end end

function rename(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_rename")(prim, prim$1);
end end

function link(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_link")(prim, prim$1);
end end

function chmod(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_chmod")(prim, prim$1);
end end

function fchmod(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_fchmod")(prim, prim$1);
end end

function chown(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_chown")(prim, prim$1, prim$2);
end end

function fchown(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_fchown")(prim, prim$1, prim$2);
end end

function umask(prim) do
  return Caml_external_polyfill.resolve("unix_umask")(prim);
end end

function access(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_access")(prim, prim$1);
end end

function dup(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_dup")(prim, prim$1);
end end

function dup2(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_dup2")(prim, prim$1, prim$2);
end end

function set_nonblock(prim) do
  return Caml_external_polyfill.resolve("unix_set_nonblock")(prim);
end end

function clear_nonblock(prim) do
  return Caml_external_polyfill.resolve("unix_clear_nonblock")(prim);
end end

function set_close_on_exec(prim) do
  return Caml_external_polyfill.resolve("unix_set_close_on_exec")(prim);
end end

function clear_close_on_exec(prim) do
  return Caml_external_polyfill.resolve("unix_clear_close_on_exec")(prim);
end end

function mkdir(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_mkdir")(prim, prim$1);
end end

function rmdir(prim) do
  return Caml_external_polyfill.resolve("unix_rmdir")(prim);
end end

function chdir(prim) do
  return Caml_external_polyfill.resolve("unix_chdir")(prim);
end end

function getcwd(prim) do
  return Caml_external_polyfill.resolve("unix_getcwd")(prim);
end end

function chroot(prim) do
  return Caml_external_polyfill.resolve("unix_chroot")(prim);
end end

function opendir(prim) do
  return Caml_external_polyfill.resolve("unix_opendir")(prim);
end end

function readdir(prim) do
  return Caml_external_polyfill.resolve("unix_readdir")(prim);
end end

function rewinddir(prim) do
  return Caml_external_polyfill.resolve("unix_rewinddir")(prim);
end end

function closedir(prim) do
  return Caml_external_polyfill.resolve("unix_closedir")(prim);
end end

function pipe(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_pipe")(prim, prim$1);
end end

function mkfifo(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_mkfifo")(prim, prim$1);
end end

function symlink(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_symlink")(prim, prim$1, prim$2);
end end

function has_symlink(prim) do
  return Caml_external_polyfill.resolve("unix_has_symlink")(prim);
end end

function readlink(prim) do
  return Caml_external_polyfill.resolve("unix_readlink")(prim);
end end

function select(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_select")(prim, prim$1, prim$2, prim$3);
end end

function lockf(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_lockf")(prim, prim$1, prim$2);
end end

function kill(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_kill")(prim, prim$1);
end end

function sigprocmask(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_sigprocmask")(prim, prim$1);
end end

function sigpending(prim) do
  return Caml_external_polyfill.resolve("unix_sigpending")(prim);
end end

function sigsuspend(prim) do
  return Caml_external_polyfill.resolve("unix_sigsuspend")(prim);
end end

function time(prim) do
  return Caml_external_polyfill.resolve("unix_time")(prim);
end end

function gettimeofday(prim) do
  return Caml_external_polyfill.resolve("unix_gettimeofday")(prim);
end end

function gmtime(prim) do
  return Caml_external_polyfill.resolve("unix_gmtime")(prim);
end end

function localtime(prim) do
  return Caml_external_polyfill.resolve("unix_localtime")(prim);
end end

function mktime(prim) do
  return Caml_external_polyfill.resolve("unix_mktime")(prim);
end end

function alarm(prim) do
  return Caml_external_polyfill.resolve("unix_alarm")(prim);
end end

function sleepf(prim) do
  return Caml_external_polyfill.resolve("unix_sleep")(prim);
end end

function times(prim) do
  return Caml_external_polyfill.resolve("unix_times")(prim);
end end

function utimes(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_utimes")(prim, prim$1, prim$2);
end end

function getitimer(prim) do
  return Caml_external_polyfill.resolve("unix_getitimer")(prim);
end end

function setitimer(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_setitimer")(prim, prim$1);
end end

function getuid(prim) do
  return Caml_external_polyfill.resolve("unix_getuid")(prim);
end end

function geteuid(prim) do
  return Caml_external_polyfill.resolve("unix_geteuid")(prim);
end end

function setuid(prim) do
  return Caml_external_polyfill.resolve("unix_setuid")(prim);
end end

function getgid(prim) do
  return Caml_external_polyfill.resolve("unix_getgid")(prim);
end end

function getegid(prim) do
  return Caml_external_polyfill.resolve("unix_getegid")(prim);
end end

function setgid(prim) do
  return Caml_external_polyfill.resolve("unix_setgid")(prim);
end end

function getgroups(prim) do
  return Caml_external_polyfill.resolve("unix_getgroups")(prim);
end end

function setgroups(prim) do
  return Caml_external_polyfill.resolve("unix_setgroups")(prim);
end end

function initgroups(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_initgroups")(prim, prim$1);
end end

function getlogin(prim) do
  return Caml_external_polyfill.resolve("unix_getlogin")(prim);
end end

function getpwnam(prim) do
  return Caml_external_polyfill.resolve("unix_getpwnam")(prim);
end end

function getgrnam(prim) do
  return Caml_external_polyfill.resolve("unix_getgrnam")(prim);
end end

function getpwuid(prim) do
  return Caml_external_polyfill.resolve("unix_getpwuid")(prim);
end end

function getgrgid(prim) do
  return Caml_external_polyfill.resolve("unix_getgrgid")(prim);
end end

function inet_addr_of_string(prim) do
  return Caml_external_polyfill.resolve("unix_inet_addr_of_string")(prim);
end end

function string_of_inet_addr(prim) do
  return Caml_external_polyfill.resolve("unix_string_of_inet_addr")(prim);
end end

function socket(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_socket")(prim, prim$1, prim$2, prim$3);
end end

function socketpair(prim, prim$1, prim$2, prim$3) do
  return Caml_external_polyfill.resolve("unix_socketpair")(prim, prim$1, prim$2, prim$3);
end end

function accept(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_accept")(prim, prim$1);
end end

function bind(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_bind")(prim, prim$1);
end end

function connect(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_connect")(prim, prim$1);
end end

function listen(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_listen")(prim, prim$1);
end end

function shutdown(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_shutdown")(prim, prim$1);
end end

function getsockname(prim) do
  return Caml_external_polyfill.resolve("unix_getsockname")(prim);
end end

function getpeername(prim) do
  return Caml_external_polyfill.resolve("unix_getpeername")(prim);
end end

function gethostname(prim) do
  return Caml_external_polyfill.resolve("unix_gethostname")(prim);
end end

function gethostbyname(prim) do
  return Caml_external_polyfill.resolve("unix_gethostbyname")(prim);
end end

function gethostbyaddr(prim) do
  return Caml_external_polyfill.resolve("unix_gethostbyaddr")(prim);
end end

function getprotobyname(prim) do
  return Caml_external_polyfill.resolve("unix_getprotobyname")(prim);
end end

function getprotobynumber(prim) do
  return Caml_external_polyfill.resolve("unix_getprotobynumber")(prim);
end end

function getservbyname(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_getservbyname")(prim, prim$1);
end end

function getservbyport(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_getservbyport")(prim, prim$1);
end end

function tcgetattr(prim) do
  return Caml_external_polyfill.resolve("unix_tcgetattr")(prim);
end end

function tcsetattr(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("unix_tcsetattr")(prim, prim$1, prim$2);
end end

function tcsendbreak(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_tcsendbreak")(prim, prim$1);
end end

function tcdrain(prim) do
  return Caml_external_polyfill.resolve("unix_tcdrain")(prim);
end end

function tcflush(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_tcflush")(prim, prim$1);
end end

function tcflow(prim, prim$1) do
  return Caml_external_polyfill.resolve("unix_tcflow")(prim, prim$1);
end end

function setsid(prim) do
  return Caml_external_polyfill.resolve("unix_setsid")(prim);
end end

export do
  Unix_error ,
  error_message ,
  handle_unix_error ,
  environment ,
  unsafe_environment ,
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
  sleepf ,
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
--[[  Not a pure module ]]
