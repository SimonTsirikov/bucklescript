'use strict';

var Sys = require("./sys.js");
var Block = require("./block.js");
var Bytes = require("./bytes.js");
var Curry = require("./curry.js");
var $$Buffer = require("./buffer.js");
var Printf = require("./printf.js");
var Random = require("./random.js");
var $$String = require("./string.js");
var Caml_obj = require("./caml_obj.js");
var Caml_sys = require("./caml_sys.js");
var Caml_bytes = require("./caml_bytes.js");
var Pervasives = require("./pervasives.js");
var Caml_string = require("./caml_string.js");
var CamlinternalLazy = require("./camlinternalLazy.js");
var Caml_js_exceptions = require("./caml_js_exceptions.js");
var Caml_external_polyfill = require("./caml_external_polyfill.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function generic_basename(is_dir_sep, current_dir_name, name) do
  if (name == "") then do
    return current_dir_name;
  end else do
    var _n = #name - 1 | 0;
    while(true) do
      var n = _n;
      if (n < 0) then do
        return $$String.sub(name, 0, 1);
      end else if (Curry._2(is_dir_sep, name, n)) then do
        _n = n - 1 | 0;
        continue ;
      end else do
        var _n$1 = n;
        var p = n + 1 | 0;
        while(true) do
          var n$1 = _n$1;
          if (n$1 < 0) then do
            return $$String.sub(name, 0, p);
          end else if (Curry._2(is_dir_sep, name, n$1)) then do
            return $$String.sub(name, n$1 + 1 | 0, (p - n$1 | 0) - 1 | 0);
          end else do
            _n$1 = n$1 - 1 | 0;
            continue ;
          end end  end 
        end;
      end end  end 
    end;
  end end 
end

function generic_dirname(is_dir_sep, current_dir_name, name) do
  if (name == "") then do
    return current_dir_name;
  end else do
    var _n = #name - 1 | 0;
    while(true) do
      var n = _n;
      if (n < 0) then do
        return $$String.sub(name, 0, 1);
      end else if (Curry._2(is_dir_sep, name, n)) then do
        _n = n - 1 | 0;
        continue ;
      end else do
        var _n$1 = n;
        while(true) do
          var n$1 = _n$1;
          if (n$1 < 0) then do
            return current_dir_name;
          end else if (Curry._2(is_dir_sep, name, n$1)) then do
            var _n$2 = n$1;
            while(true) do
              var n$2 = _n$2;
              if (n$2 < 0) then do
                return $$String.sub(name, 0, 1);
              end else if (Curry._2(is_dir_sep, name, n$2)) then do
                _n$2 = n$2 - 1 | 0;
                continue ;
              end else do
                return $$String.sub(name, 0, n$2 + 1 | 0);
              end end  end 
            end;
          end else do
            _n$1 = n$1 - 1 | 0;
            continue ;
          end end  end 
        end;
      end end  end 
    end;
  end end 
end

var current_dir_name = ".";

function is_dir_sep(s, i) do
  return Caml_string.get(s, i) == --[ "/" ]--47;
end

function is_relative(n) do
  if (#n < 1) then do
    return true;
  end else do
    return Caml_string.get(n, 0) ~= --[ "/" ]--47;
  end end 
end

function is_implicit(n) do
  if (is_relative(n) and (#n < 2 or $$String.sub(n, 0, 2) ~= "./")) then do
    if (#n < 3) then do
      return true;
    end else do
      return $$String.sub(n, 0, 3) ~= "../";
    end end 
  end else do
    return false;
  end end 
end

function check_suffix(name, suff) do
  if (#name >= #suff) then do
    return $$String.sub(name, #name - #suff | 0, #suff) == suff;
  end else do
    return false;
  end end 
end

var temp_dir_name;

try do
  temp_dir_name = Caml_sys.caml_sys_getenv("TMPDIR");
end
catch (exn)do
  if (exn == Caml_builtin_exceptions.not_found) then do
    temp_dir_name = "/tmp";
  end else do
    throw exn;
  end end 
end

function quote(param) do
  var quotequote = "'\\''";
  var s = param;
  var l = #s;
  var b = $$Buffer.create(l + 20 | 0);
  $$Buffer.add_char(b, --[ "'" ]--39);
  for(var i = 0 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
    if (Caml_string.get(s, i) == --[ "'" ]--39) then do
      $$Buffer.add_string(b, quotequote);
    end else do
      $$Buffer.add_char(b, Caml_string.get(s, i));
    end end 
  end
  $$Buffer.add_char(b, --[ "'" ]--39);
  return $$Buffer.contents(b);
end

function basename(param) do
  return generic_basename(is_dir_sep, current_dir_name, param);
end

function dirname(param) do
  return generic_dirname(is_dir_sep, current_dir_name, param);
end

var current_dir_name$1 = ".";

function is_dir_sep$1(s, i) do
  var c = Caml_string.get(s, i);
  if (c == --[ "/" ]--47 or c == --[ "\\" ]--92) then do
    return true;
  end else do
    return c == --[ ":" ]--58;
  end end 
end

function is_relative$1(n) do
  if ((#n < 1 or Caml_string.get(n, 0) ~= --[ "/" ]--47) and (#n < 1 or Caml_string.get(n, 0) ~= --[ "\\" ]--92)) then do
    if (#n < 2) then do
      return true;
    end else do
      return Caml_string.get(n, 1) ~= --[ ":" ]--58;
    end end 
  end else do
    return false;
  end end 
end

function is_implicit$1(n) do
  if (is_relative$1(n) and (#n < 2 or $$String.sub(n, 0, 2) ~= "./") and (#n < 2 or $$String.sub(n, 0, 2) ~= ".\\") and (#n < 3 or $$String.sub(n, 0, 3) ~= "../")) then do
    if (#n < 3) then do
      return true;
    end else do
      return $$String.sub(n, 0, 3) ~= "..\\";
    end end 
  end else do
    return false;
  end end 
end

function check_suffix$1(name, suff) do
  if (#name >= #suff) then do
    var s = $$String.sub(name, #name - #suff | 0, #suff);
    return Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(s))) == Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(suff)));
  end else do
    return false;
  end end 
end

var temp_dir_name$1;

try do
  temp_dir_name$1 = Caml_sys.caml_sys_getenv("TEMP");
end
catch (exn$1)do
  if (exn$1 == Caml_builtin_exceptions.not_found) then do
    temp_dir_name$1 = ".";
  end else do
    throw exn$1;
  end end 
end

function quote$1(s) do
  var l = #s;
  var b = $$Buffer.create(l + 20 | 0);
  $$Buffer.add_char(b, --[ "\"" ]--34);
  var loop = function (_i) do
    while(true) do
      var i = _i;
      if (i == l) then do
        return $$Buffer.add_char(b, --[ "\"" ]--34);
      end else do
        var c = Caml_string.get(s, i);
        if (c ~= 34 and c ~= 92) then do
          $$Buffer.add_char(b, c);
          _i = i + 1 | 0;
          continue ;
        end else do
          var _n = 0;
          var _i$1 = i;
          while(true) do
            var i$1 = _i$1;
            var n = _n;
            if (i$1 == l) then do
              $$Buffer.add_char(b, --[ "\"" ]--34);
              return add_bs(n);
            end else do
              var match = Caml_string.get(s, i$1);
              if (match ~= 34) then do
                if (match ~= 92) then do
                  add_bs(n);
                  return loop(i$1);
                end else do
                  _i$1 = i$1 + 1 | 0;
                  _n = n + 1 | 0;
                  continue ;
                end end 
              end else do
                add_bs((n << 1) + 1 | 0);
                $$Buffer.add_char(b, --[ "\"" ]--34);
                return loop(i$1 + 1 | 0);
              end end 
            end end 
          end;
        end end 
      end end 
    end;
  end;
  var add_bs = function (n) do
    for(var _j = 1; _j <= n; ++_j)do
      $$Buffer.add_char(b, --[ "\\" ]--92);
    end
    return --[ () ]--0;
  end;
  loop(0);
  return $$Buffer.contents(b);
end

function has_drive(s) do
  var is_letter = function (param) do
    if (param >= 91) then do
      return !(param > 122 or param < 97);
    end else do
      return param >= 65;
    end end 
  end;
  if (#s >= 2 and is_letter(Caml_string.get(s, 0))) then do
    return Caml_string.get(s, 1) == --[ ":" ]--58;
  end else do
    return false;
  end end 
end

function drive_and_path(s) do
  if (has_drive(s)) then do
    return --[ tuple ]--[
            $$String.sub(s, 0, 2),
            $$String.sub(s, 2, #s - 2 | 0)
          ];
  end else do
    return --[ tuple ]--[
            "",
            s
          ];
  end end 
end

function dirname$1(s) do
  var match = drive_and_path(s);
  var dir = generic_dirname(is_dir_sep$1, current_dir_name$1, match[1]);
  return match[0] .. dir;
end

function basename$1(s) do
  var match = drive_and_path(s);
  return generic_basename(is_dir_sep$1, current_dir_name$1, match[1]);
end

var current_dir_name$2 = ".";

function basename$2(param) do
  return generic_basename(is_dir_sep$1, current_dir_name$2, param);
end

function dirname$2(param) do
  return generic_dirname(is_dir_sep$1, current_dir_name$2, param);
end

var match;

switch (Sys.os_type) do
  case "Cygwin" :
      match = --[ tuple ]--[
        current_dir_name$2,
        "..",
        "/",
        is_dir_sep$1,
        is_relative$1,
        is_implicit$1,
        check_suffix$1,
        temp_dir_name,
        quote,
        basename$2,
        dirname$2
      ];
      break;
  case "Win32" :
      match = --[ tuple ]--[
        current_dir_name$1,
        "..",
        "\\",
        is_dir_sep$1,
        is_relative$1,
        is_implicit$1,
        check_suffix$1,
        temp_dir_name$1,
        quote$1,
        basename$1,
        dirname$1
      ];
      break;
  default:
    match = --[ tuple ]--[
      current_dir_name,
      "..",
      "/",
      is_dir_sep,
      is_relative,
      is_implicit,
      check_suffix,
      temp_dir_name,
      quote,
      basename,
      dirname
    ];
end

var temp_dir_name$2 = match[7];

var is_dir_sep$2 = match[3];

var dir_sep = match[2];

function concat(dirname, filename) do
  var l = #dirname;
  if (l == 0 or Curry._2(is_dir_sep$2, dirname, l - 1 | 0)) then do
    return dirname .. filename;
  end else do
    return dirname .. (dir_sep .. filename);
  end end 
end

function chop_suffix(name, suff) do
  var n = #name - #suff | 0;
  if (n < 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Filename.chop_suffix"
        ];
  end
   end 
  return $$String.sub(name, 0, n);
end

function extension_len(name) do
  var _i = #name - 1 | 0;
  while(true) do
    var i = _i;
    if (i < 0 or Curry._2(is_dir_sep$2, name, i)) then do
      return 0;
    end else if (Caml_string.get(name, i) == --[ "." ]--46) then do
      var i0 = i;
      var _i$1 = i - 1 | 0;
      while(true) do
        var i$1 = _i$1;
        if (i$1 < 0 or Curry._2(is_dir_sep$2, name, i$1)) then do
          return 0;
        end else if (Caml_string.get(name, i$1) == --[ "." ]--46) then do
          _i$1 = i$1 - 1 | 0;
          continue ;
        end else do
          return #name - i0 | 0;
        end end  end 
      end;
    end else do
      _i = i - 1 | 0;
      continue ;
    end end  end 
  end;
end

function extension(name) do
  var l = extension_len(name);
  if (l == 0) then do
    return "";
  end else do
    return $$String.sub(name, #name - l | 0, l);
  end end 
end

function chop_extension(name) do
  var l = extension_len(name);
  if (l == 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Filename.chop_extension"
        ];
  end
   end 
  return $$String.sub(name, 0, #name - l | 0);
end

function remove_extension(name) do
  var l = extension_len(name);
  if (l == 0) then do
    return name;
  end else do
    return $$String.sub(name, 0, #name - l | 0);
  end end 
end

var prng = Caml_obj.caml_lazy_make((function (param) do
        return Random.State.make_self_init(--[ () ]--0);
      end));

function temp_file_name(temp_dir, prefix, suffix) do
  var rnd = Random.State.bits(CamlinternalLazy.force(prng)) & 16777215;
  return concat(temp_dir, Curry._3(Printf.sprintf(--[ Format ]--[
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Int ]--Block.__(4, [
                              --[ Int_x ]--6,
                              --[ Lit_padding ]--Block.__(0, [
                                  --[ Zeros ]--2,
                                  6
                                ]),
                              --[ No_precision ]--0,
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ]),
                      "%s%06x%s"
                    ]), prefix, rnd, suffix));
end

var current_temp_dir_name = do
  contents: temp_dir_name$2
end;

function set_temp_dir_name(s) do
  current_temp_dir_name.contents = s;
  return --[ () ]--0;
end

function get_temp_dir_name(param) do
  return current_temp_dir_name.contents;
end

function temp_file(temp_dirOpt, prefix, suffix) do
  var temp_dir = temp_dirOpt ~= undefined ? temp_dirOpt : current_temp_dir_name.contents;
  var _counter = 0;
  while(true) do
    var counter = _counter;
    var name = temp_file_name(temp_dir, prefix, suffix);
    try do
      Caml_external_polyfill.resolve("caml_sys_close")(Caml_external_polyfill.resolve("caml_sys_open")(name, --[ :: ]--[
                --[ Open_wronly ]--1,
                --[ :: ]--[
                  --[ Open_creat ]--3,
                  --[ :: ]--[
                    --[ Open_excl ]--5,
                    --[ [] ]--0
                  ]
                ]
              ], 384));
      return name;
    end
    catch (raw_e)do
      var e = Caml_js_exceptions.internalToOCamlException(raw_e);
      if (e[0] == Caml_builtin_exceptions.sys_error) then do
        if (counter >= 1000) then do
          throw e;
        end
         end 
        _counter = counter + 1 | 0;
        continue ;
      end else do
        throw e;
      end end 
    end
  end;
end

function open_temp_file(modeOpt, permsOpt, temp_dirOpt, prefix, suffix) do
  var mode = modeOpt ~= undefined ? modeOpt : --[ :: ]--[
      --[ Open_text ]--7,
      --[ [] ]--0
    ];
  var perms = permsOpt ~= undefined ? permsOpt : 384;
  var temp_dir = temp_dirOpt ~= undefined ? temp_dirOpt : current_temp_dir_name.contents;
  var _counter = 0;
  while(true) do
    var counter = _counter;
    var name = temp_file_name(temp_dir, prefix, suffix);
    try do
      return --[ tuple ]--[
              name,
              Pervasives.open_out_gen(--[ :: ]--[
                    --[ Open_wronly ]--1,
                    --[ :: ]--[
                      --[ Open_creat ]--3,
                      --[ :: ]--[
                        --[ Open_excl ]--5,
                        mode
                      ]
                    ]
                  ], perms, name)
            ];
    end
    catch (raw_e)do
      var e = Caml_js_exceptions.internalToOCamlException(raw_e);
      if (e[0] == Caml_builtin_exceptions.sys_error) then do
        if (counter >= 1000) then do
          throw e;
        end
         end 
        _counter = counter + 1 | 0;
        continue ;
      end else do
        throw e;
      end end 
    end
  end;
end

var current_dir_name$3 = match[0];

var parent_dir_name = match[1];

var is_relative$2 = match[4];

var is_implicit$2 = match[5];

var check_suffix$2 = match[6];

var basename$3 = match[9];

var dirname$3 = match[10];

var quote$2 = match[8];

exports.current_dir_name = current_dir_name$3;
exports.parent_dir_name = parent_dir_name;
exports.dir_sep = dir_sep;
exports.concat = concat;
exports.is_relative = is_relative$2;
exports.is_implicit = is_implicit$2;
exports.check_suffix = check_suffix$2;
exports.chop_suffix = chop_suffix;
exports.extension = extension;
exports.remove_extension = remove_extension;
exports.chop_extension = chop_extension;
exports.basename = basename$3;
exports.dirname = dirname$3;
exports.temp_file = temp_file;
exports.open_temp_file = open_temp_file;
exports.get_temp_dir_name = get_temp_dir_name;
exports.set_temp_dir_name = set_temp_dir_name;
exports.temp_dir_name = temp_dir_name$2;
exports.quote = quote$2;
--[ match Not a pure module ]--
