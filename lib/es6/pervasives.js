

import * as Curry from "./curry.js";
import * as Caml_io from "./caml_io.js";
import * as Caml_sys from "./caml_sys.js";
import * as Caml_bytes from "./caml_bytes.js";
import * as Caml_format from "./caml_format.js";
import * as Caml_string from "./caml_string.js";
import * as Caml_exceptions from "./caml_exceptions.js";
import * as Caml_js_exceptions from "./caml_js_exceptions.js";
import * as Caml_external_polyfill from "./caml_external_polyfill.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";
import * as CamlinternalFormatBasics from "./camlinternalFormatBasics.js";

function failwith(s) do
  throw [
        Caml_builtin_exceptions.failure,
        s
      ];
end

function invalid_arg(s) do
  throw [
        Caml_builtin_exceptions.invalid_argument,
        s
      ];
end

var Exit = Caml_exceptions.create("Pervasives.Exit");

function abs(x) do
  if (x >= 0) then do
    return x;
  end else do
    return -x | 0;
  end end 
end

function lnot(x) do
  return x ^ -1;
end

var min_int = -2147483648;

function classify_float(x) do
  if (isFinite(x)) then do
    if (Math.abs(x) >= 2.22507385850720138e-308) then do
      return --[ FP_normal ]--0;
    end else if (x ~= 0) then do
      return --[ FP_subnormal ]--1;
    end else do
      return --[ FP_zero ]--2;
    end end  end 
  end else if (isNaN(x)) then do
    return --[ FP_nan ]--4;
  end else do
    return --[ FP_infinite ]--3;
  end end  end 
end

function char_of_int(n) do
  if (n < 0 or n > 255) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "char_of_int"
        ];
  end
   end 
  return n;
end

function string_of_bool(b) do
  if (b) then do
    return "true";
  end else do
    return "false";
  end end 
end

function bool_of_string(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = "false" then do
        return false;end end end 
     if ___conditional___ = "true" then do
        return true;end end end 
     do
    else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "bool_of_string"
          ];
      end end
      
  end
end

function bool_of_string_opt(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = "false" then do
        return false;end end end 
     if ___conditional___ = "true" then do
        return true;end end end 
     do
    else do
      return ;
      end end
      
  end
end

function int_of_string_opt(s) do
  try do
    return Caml_format.caml_int_of_string(s);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      throw exn;
    end end 
  end
end

function valid_float_lexem(s) do
  var l = #s;
  var _i = 0;
  while(true) do
    var i = _i;
    if (i >= l) then do
      return s .. ".";
    end else do
      var match = Caml_string.get(s, i);
      if (match >= 48) then do
        if (match >= 58) then do
          return s;
        end else do
          _i = i + 1 | 0;
          continue ;
        end end 
      end else if (match ~= 45) then do
        return s;
      end else do
        _i = i + 1 | 0;
        continue ;
      end end  end 
    end end 
  end;
end

function string_of_float(f) do
  return valid_float_lexem(Caml_format.caml_format_float("%.12g", f));
end

function float_of_string_opt(s) do
  try do
    return Caml_format.caml_float_of_string(s);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      throw exn;
    end end 
  end
end

function $at(l1, l2) do
  if (l1) then do
    return --[ :: ]--[
            l1[0],
            $at(l1[1], l2)
          ];
  end else do
    return l2;
  end end 
end

var stdin = Caml_io.stdin;

var stdout = Caml_io.stdout;

var stderr = Caml_io.stderr;

function open_out_gen(mode, perm, name) do
  var c = Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(Caml_external_polyfill.resolve("caml_sys_open")(name, mode, perm));
  Caml_external_polyfill.resolve("caml_ml_set_channel_name")(c, name);
  return c;
end

function open_out(name) do
  return open_out_gen(--[ :: ]--[
              --[ Open_wronly ]--1,
              --[ :: ]--[
                --[ Open_creat ]--3,
                --[ :: ]--[
                  --[ Open_trunc ]--4,
                  --[ :: ]--[
                    --[ Open_text ]--7,
                    --[ [] ]--0
                  ]
                ]
              ]
            ], 438, name);
end

function open_out_bin(name) do
  return open_out_gen(--[ :: ]--[
              --[ Open_wronly ]--1,
              --[ :: ]--[
                --[ Open_creat ]--3,
                --[ :: ]--[
                  --[ Open_trunc ]--4,
                  --[ :: ]--[
                    --[ Open_binary ]--6,
                    --[ [] ]--0
                  ]
                ]
              ]
            ], 438, name);
end

function flush_all(param) do
  var _param = Caml_io.caml_ml_out_channels_list(--[ () ]--0);
  while(true) do
    var param$1 = _param;
    if (param$1) then do
      try do
        Caml_io.caml_ml_flush(param$1[0]);
      end
      catch (raw_exn)do
        var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
        if (exn[0] ~= Caml_builtin_exceptions.sys_error) then do
          throw exn;
        end
         end 
      end
      _param = param$1[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function output_bytes(oc, s) do
  return Caml_external_polyfill.resolve("caml_ml_output_bytes")(oc, s, 0, #s);
end

function output_string(oc, s) do
  return Caml_io.caml_ml_output(oc, s, 0, #s);
end

function output(oc, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "output"
        ];
  end
   end 
  return Caml_external_polyfill.resolve("caml_ml_output_bytes")(oc, s, ofs, len);
end

function output_substring(oc, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "output_substring"
        ];
  end
   end 
  return Caml_io.caml_ml_output(oc, s, ofs, len);
end

function output_value(chan, v) do
  return Caml_external_polyfill.resolve("caml_output_value")(chan, v, --[ [] ]--0);
end

function close_out(oc) do
  Caml_io.caml_ml_flush(oc);
  return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
end

function close_out_noerr(oc) do
  try do
    Caml_io.caml_ml_flush(oc);
  end
  catch (exn)do
    
  end
  try do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
  end
  catch (exn$1)do
    return --[ () ]--0;
  end
end

function open_in_gen(mode, perm, name) do
  var c = Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(Caml_external_polyfill.resolve("caml_sys_open")(name, mode, perm));
  Caml_external_polyfill.resolve("caml_ml_set_channel_name")(c, name);
  return c;
end

function open_in(name) do
  return open_in_gen(--[ :: ]--[
              --[ Open_rdonly ]--0,
              --[ :: ]--[
                --[ Open_text ]--7,
                --[ [] ]--0
              ]
            ], 0, name);
end

function open_in_bin(name) do
  return open_in_gen(--[ :: ]--[
              --[ Open_rdonly ]--0,
              --[ :: ]--[
                --[ Open_binary ]--6,
                --[ [] ]--0
              ]
            ], 0, name);
end

function input(ic, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "input"
        ];
  end
   end 
  return Caml_external_polyfill.resolve("caml_ml_input")(ic, s, ofs, len);
end

function unsafe_really_input(ic, s, _ofs, _len) do
  while(true) do
    var len = _len;
    var ofs = _ofs;
    if (len <= 0) then do
      return --[ () ]--0;
    end else do
      var r = Caml_external_polyfill.resolve("caml_ml_input")(ic, s, ofs, len);
      if (r == 0) then do
        throw Caml_builtin_exceptions.end_of_file;
      end
       end 
      _len = len - r | 0;
      _ofs = ofs + r | 0;
      continue ;
    end end 
  end;
end

function really_input(ic, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "really_input"
        ];
  end
   end 
  return unsafe_really_input(ic, s, ofs, len);
end

function really_input_string(ic, len) do
  var s = Caml_bytes.caml_create_bytes(len);
  really_input(ic, s, 0, len);
  return Caml_bytes.bytes_to_string(s);
end

function input_line(chan) do
  var build_result = function (buf, _pos, _param) do
    while(true) do
      var param = _param;
      var pos = _pos;
      if (param) then do
        var hd = param[0];
        var len = #hd;
        Caml_bytes.caml_blit_bytes(hd, 0, buf, pos - len | 0, len);
        _param = param[1];
        _pos = pos - len | 0;
        continue ;
      end else do
        return buf;
      end end 
    end;
  end;
  var scan = function (_accu, _len) do
    while(true) do
      var len = _len;
      var accu = _accu;
      var n = Caml_external_polyfill.resolve("caml_ml_input_scan_line")(chan);
      if (n == 0) then do
        if (accu) then do
          return build_result(Caml_bytes.caml_create_bytes(len), len, accu);
        end else do
          throw Caml_builtin_exceptions.end_of_file;
        end end 
      end else if (n > 0) then do
        var res = Caml_bytes.caml_create_bytes(n - 1 | 0);
        Caml_external_polyfill.resolve("caml_ml_input")(chan, res, 0, n - 1 | 0);
        Caml_external_polyfill.resolve("caml_ml_input_char")(chan);
        if (accu) then do
          var len$1 = (len + n | 0) - 1 | 0;
          return build_result(Caml_bytes.caml_create_bytes(len$1), len$1, --[ :: ]--[
                      res,
                      accu
                    ]);
        end else do
          return res;
        end end 
      end else do
        var beg = Caml_bytes.caml_create_bytes(-n | 0);
        Caml_external_polyfill.resolve("caml_ml_input")(chan, beg, 0, -n | 0);
        _len = len - n | 0;
        _accu = --[ :: ]--[
          beg,
          accu
        ];
        continue ;
      end end  end 
    end;
  end;
  return Caml_bytes.bytes_to_string(scan(--[ [] ]--0, 0));
end

function close_in_noerr(ic) do
  try do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
  end
  catch (exn)do
    return --[ () ]--0;
  end
end

function print_char(c) do
  return Caml_io.caml_ml_output_char(stdout, c);
end

function print_string(s) do
  return output_string(stdout, s);
end

function print_bytes(s) do
  return output_bytes(stdout, s);
end

function print_int(i) do
  return output_string(stdout, String(i));
end

function print_float(f) do
  return output_string(stdout, valid_float_lexem(Caml_format.caml_format_float("%.12g", f)));
end

function print_newline(param) do
  Caml_io.caml_ml_output_char(stdout, --[ "\n" ]--10);
  return Caml_io.caml_ml_flush(stdout);
end

function prerr_char(c) do
  return Caml_io.caml_ml_output_char(stderr, c);
end

function prerr_string(s) do
  return output_string(stderr, s);
end

function prerr_bytes(s) do
  return output_bytes(stderr, s);
end

function prerr_int(i) do
  return output_string(stderr, String(i));
end

function prerr_float(f) do
  return output_string(stderr, valid_float_lexem(Caml_format.caml_format_float("%.12g", f)));
end

function prerr_newline(param) do
  Caml_io.caml_ml_output_char(stderr, --[ "\n" ]--10);
  return Caml_io.caml_ml_flush(stderr);
end

function read_line(param) do
  Caml_io.caml_ml_flush(stdout);
  return input_line(stdin);
end

function read_int(param) do
  return Caml_format.caml_int_of_string((Caml_io.caml_ml_flush(stdout), input_line(stdin)));
end

function read_int_opt(param) do
  return int_of_string_opt((Caml_io.caml_ml_flush(stdout), input_line(stdin)));
end

function read_float(param) do
  return Caml_format.caml_float_of_string((Caml_io.caml_ml_flush(stdout), input_line(stdin)));
end

function read_float_opt(param) do
  return float_of_string_opt((Caml_io.caml_ml_flush(stdout), input_line(stdin)));
end

function string_of_format(param) do
  return param[1];
end

function $caret$caret(param, param$1) do
  return --[ Format ]--[
          CamlinternalFormatBasics.concat_fmt(param[0], param$1[0]),
          param[1] .. ("%," .. param$1[1])
        ];
end

var exit_function = do
  contents: flush_all
end;

function at_exit(f) do
  var g = exit_function.contents;
  exit_function.contents = (function (param) do
      Curry._1(f, --[ () ]--0);
      return Curry._1(g, --[ () ]--0);
    end);
  return --[ () ]--0;
end

function do_at_exit(param) do
  return Curry._1(exit_function.contents, --[ () ]--0);
end

function exit(retcode) do
  do_at_exit(--[ () ]--0);
  return Caml_sys.caml_sys_exit(retcode);
end

var max_int = 2147483647;

var infinity = Infinity;

var neg_infinity = -Infinity;

var max_float = 1.79769313486231571e+308;

var min_float = 2.22507385850720138e-308;

var epsilon_float = 2.22044604925031308e-16;

var flush = Caml_io.caml_ml_flush;

var output_char = Caml_io.caml_ml_output_char;

var output_byte = Caml_io.caml_ml_output_char;

function output_binary_int(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ml_output_int")(prim, prim$1);
end

function seek_out(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ml_seek_out")(prim, prim$1);
end

function pos_out(prim) do
  return Caml_external_polyfill.resolve("caml_ml_pos_out")(prim);
end

function out_channel_length(prim) do
  return Caml_external_polyfill.resolve("caml_ml_channel_size")(prim);
end

function set_binary_mode_out(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ml_set_binary_mode")(prim, prim$1);
end

function input_char(prim) do
  return Caml_external_polyfill.resolve("caml_ml_input_char")(prim);
end

function input_byte(prim) do
  return Caml_external_polyfill.resolve("caml_ml_input_char")(prim);
end

function input_binary_int(prim) do
  return Caml_external_polyfill.resolve("caml_ml_input_int")(prim);
end

function input_value(prim) do
  return Caml_external_polyfill.resolve("caml_input_value")(prim);
end

function seek_in(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ml_seek_in")(prim, prim$1);
end

function pos_in(prim) do
  return Caml_external_polyfill.resolve("caml_ml_pos_in")(prim);
end

function in_channel_length(prim) do
  return Caml_external_polyfill.resolve("caml_ml_channel_size")(prim);
end

function close_in(prim) do
  return Caml_external_polyfill.resolve("caml_ml_close_channel")(prim);
end

function set_binary_mode_in(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ml_set_binary_mode")(prim, prim$1);
end

function LargeFile_seek_out(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ml_seek_out_64")(prim, prim$1);
end

function LargeFile_pos_out(prim) do
  return Caml_external_polyfill.resolve("caml_ml_pos_out_64")(prim);
end

function LargeFile_out_channel_length(prim) do
  return Caml_external_polyfill.resolve("caml_ml_channel_size_64")(prim);
end

function LargeFile_seek_in(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ml_seek_in_64")(prim, prim$1);
end

function LargeFile_pos_in(prim) do
  return Caml_external_polyfill.resolve("caml_ml_pos_in_64")(prim);
end

function LargeFile_in_channel_length(prim) do
  return Caml_external_polyfill.resolve("caml_ml_channel_size_64")(prim);
end

var LargeFile = do
  seek_out: LargeFile_seek_out,
  pos_out: LargeFile_pos_out,
  out_channel_length: LargeFile_out_channel_length,
  seek_in: LargeFile_seek_in,
  pos_in: LargeFile_pos_in,
  in_channel_length: LargeFile_in_channel_length
end;

export do
  invalid_arg ,
  failwith ,
  Exit ,
  abs ,
  max_int ,
  min_int ,
  lnot ,
  infinity ,
  neg_infinity ,
  max_float ,
  min_float ,
  epsilon_float ,
  classify_float ,
  char_of_int ,
  string_of_bool ,
  bool_of_string ,
  bool_of_string_opt ,
  int_of_string_opt ,
  string_of_float ,
  float_of_string_opt ,
  $at ,
  stdin ,
  stdout ,
  stderr ,
  print_char ,
  print_string ,
  print_bytes ,
  print_int ,
  print_float ,
  print_newline ,
  prerr_char ,
  prerr_string ,
  prerr_bytes ,
  prerr_int ,
  prerr_float ,
  prerr_newline ,
  read_line ,
  read_int ,
  read_int_opt ,
  read_float ,
  read_float_opt ,
  open_out ,
  open_out_bin ,
  open_out_gen ,
  flush ,
  flush_all ,
  output_char ,
  output_string ,
  output_bytes ,
  output ,
  output_substring ,
  output_byte ,
  output_binary_int ,
  output_value ,
  seek_out ,
  pos_out ,
  out_channel_length ,
  close_out ,
  close_out_noerr ,
  set_binary_mode_out ,
  open_in ,
  open_in_bin ,
  open_in_gen ,
  input_char ,
  input_line ,
  input ,
  really_input ,
  really_input_string ,
  input_byte ,
  input_binary_int ,
  input_value ,
  seek_in ,
  pos_in ,
  in_channel_length ,
  close_in ,
  close_in_noerr ,
  set_binary_mode_in ,
  LargeFile ,
  string_of_format ,
  $caret$caret ,
  exit ,
  at_exit ,
  valid_float_lexem ,
  unsafe_really_input ,
  do_at_exit ,
  
end
--[ No side effect ]--
