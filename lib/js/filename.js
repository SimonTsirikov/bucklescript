'use strict';

Sys = require("./sys.js");
Block = require("./block.js");
Bytes = require("./bytes.js");
Curry = require("./curry.js");
$$Buffer = require("./buffer.js");
Printf = require("./printf.js");
Random = require("./random.js");
$$String = require("./string.js");
Caml_obj = require("./caml_obj.js");
Caml_sys = require("./caml_sys.js");
Caml_bytes = require("./caml_bytes.js");
Pervasives = require("./pervasives.js");
Caml_string = require("./caml_string.js");
CamlinternalLazy = require("./camlinternalLazy.js");
Caml_js_exceptions = require("./caml_js_exceptions.js");
Caml_external_polyfill = require("./caml_external_polyfill.js");
Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function generic_basename(is_dir_sep, current_dir_name, name) do
  if (name == "") then do
    return current_dir_name;
  end else do
    _n = #name - 1 | 0;
    while(true) do
      n = _n;
      if (n < 0) then do
        return $$String.sub(name, 0, 1);
      end else if (Curry._2(is_dir_sep, name, n)) then do
        _n = n - 1 | 0;
        continue ;
      end else do
        _n$1 = n;
        p = n + 1 | 0;
        while(true) do
          n$1 = _n$1;
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
end end

function generic_dirname(is_dir_sep, current_dir_name, name) do
  if (name == "") then do
    return current_dir_name;
  end else do
    _n = #name - 1 | 0;
    while(true) do
      n = _n;
      if (n < 0) then do
        return $$String.sub(name, 0, 1);
      end else if (Curry._2(is_dir_sep, name, n)) then do
        _n = n - 1 | 0;
        continue ;
      end else do
        _n$1 = n;
        while(true) do
          n$1 = _n$1;
          if (n$1 < 0) then do
            return current_dir_name;
          end else if (Curry._2(is_dir_sep, name, n$1)) then do
            _n$2 = n$1;
            while(true) do
              n$2 = _n$2;
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
end end

current_dir_name = ".";

function is_dir_sep(s, i) do
  return Caml_string.get(s, i) == --[[ "/" ]]47;
end end

function is_relative(n) do
  if (#n < 1) then do
    return true;
  end else do
    return Caml_string.get(n, 0) ~= --[[ "/" ]]47;
  end end 
end end

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
end end

function check_suffix(name, suff) do
  if (#name >= #suff) then do
    return $$String.sub(name, #name - #suff | 0, #suff) == suff;
  end else do
    return false;
  end end 
end end

temp_dir_name;

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
  quotequote = "'\\''";
  s = param;
  l = #s;
  b = $$Buffer.create(l + 20 | 0);
  $$Buffer.add_char(b, --[[ "'" ]]39);
  for i = 0 , l - 1 | 0 , 1 do
    if (Caml_string.get(s, i) == --[[ "'" ]]39) then do
      $$Buffer.add_string(b, quotequote);
    end else do
      $$Buffer.add_char(b, Caml_string.get(s, i));
    end end 
  end
  $$Buffer.add_char(b, --[[ "'" ]]39);
  return $$Buffer.contents(b);
end end

function basename(param) do
  return generic_basename(is_dir_sep, current_dir_name, param);
end end

function dirname(param) do
  return generic_dirname(is_dir_sep, current_dir_name, param);
end end

current_dir_name$1 = ".";

function is_dir_sep$1(s, i) do
  c = Caml_string.get(s, i);
  if (c == --[[ "/" ]]47 or c == --[[ "\\" ]]92) then do
    return true;
  end else do
    return c == --[[ ":" ]]58;
  end end 
end end

function is_relative$1(n) do
  if ((#n < 1 or Caml_string.get(n, 0) ~= --[[ "/" ]]47) and (#n < 1 or Caml_string.get(n, 0) ~= --[[ "\\" ]]92)) then do
    if (#n < 2) then do
      return true;
    end else do
      return Caml_string.get(n, 1) ~= --[[ ":" ]]58;
    end end 
  end else do
    return false;
  end end 
end end

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
end end

function check_suffix$1(name, suff) do
  if (#name >= #suff) then do
    s = $$String.sub(name, #name - #suff | 0, #suff);
    return Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(s))) == Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(suff)));
  end else do
    return false;
  end end 
end end

temp_dir_name$1;

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
  l = #s;
  b = $$Buffer.create(l + 20 | 0);
  $$Buffer.add_char(b, --[[ "\"" ]]34);
  loop = function (_i) do
    while(true) do
      i = _i;
      if (i == l) then do
        return $$Buffer.add_char(b, --[[ "\"" ]]34);
      end else do
        c = Caml_string.get(s, i);
        if (c ~= 34 and c ~= 92) then do
          $$Buffer.add_char(b, c);
          _i = i + 1 | 0;
          continue ;
        end else do
          _n = 0;
          _i$1 = i;
          while(true) do
            i$1 = _i$1;
            n = _n;
            if (i$1 == l) then do
              $$Buffer.add_char(b, --[[ "\"" ]]34);
              return add_bs(n);
            end else do
              match = Caml_string.get(s, i$1);
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
                $$Buffer.add_char(b, --[[ "\"" ]]34);
                return loop(i$1 + 1 | 0);
              end end 
            end end 
          end;
        end end 
      end end 
    end;
  end end;
  add_bs = function (n) do
    for _j = 1 , n , 1 do
      $$Buffer.add_char(b, --[[ "\\" ]]92);
    end
    return --[[ () ]]0;
  end end;
  loop(0);
  return $$Buffer.contents(b);
end end

function has_drive(s) do
  is_letter = function (param) do
    if (param >= 91) then do
      return !(param > 122 or param < 97);
    end else do
      return param >= 65;
    end end 
  end end;
  if (#s >= 2 and is_letter(Caml_string.get(s, 0))) then do
    return Caml_string.get(s, 1) == --[[ ":" ]]58;
  end else do
    return false;
  end end 
end end

function drive_and_path(s) do
  if (has_drive(s)) then do
    return --[[ tuple ]][
            $$String.sub(s, 0, 2),
            $$String.sub(s, 2, #s - 2 | 0)
          ];
  end else do
    return --[[ tuple ]][
            "",
            s
          ];
  end end 
end end

function dirname$1(s) do
  match = drive_and_path(s);
  dir = generic_dirname(is_dir_sep$1, current_dir_name$1, match[1]);
  return match[0] .. dir;
end end

function basename$1(s) do
  match = drive_and_path(s);
  return generic_basename(is_dir_sep$1, current_dir_name$1, match[1]);
end end

current_dir_name$2 = ".";

function basename$2(param) do
  return generic_basename(is_dir_sep$1, current_dir_name$2, param);
end end

function dirname$2(param) do
  return generic_dirname(is_dir_sep$1, current_dir_name$2, param);
end end

match;

local ___conditional___=(Sys.os_type);
do
   if ___conditional___ = "Cygwin" then do
      match = --[[ tuple ]][
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
      ];end else 
   if ___conditional___ = "Win32" then do
      match = --[[ tuple ]][
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
      ];end else 
   do end end end
  else do
    match = --[[ tuple ]][
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
    end end
    
end

temp_dir_name$2 = match[7];

is_dir_sep$2 = match[3];

dir_sep = match[2];

function concat(dirname, filename) do
  l = #dirname;
  if (l == 0 or Curry._2(is_dir_sep$2, dirname, l - 1 | 0)) then do
    return dirname .. filename;
  end else do
    return dirname .. (dir_sep .. filename);
  end end 
end end

function chop_suffix(name, suff) do
  n = #name - #suff | 0;
  if (n < 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Filename.chop_suffix"
        ];
  end
   end 
  return $$String.sub(name, 0, n);
end end

function extension_len(name) do
  _i = #name - 1 | 0;
  while(true) do
    i = _i;
    if (i < 0 or Curry._2(is_dir_sep$2, name, i)) then do
      return 0;
    end else if (Caml_string.get(name, i) == --[[ "." ]]46) then do
      i0 = i;
      _i$1 = i - 1 | 0;
      while(true) do
        i$1 = _i$1;
        if (i$1 < 0 or Curry._2(is_dir_sep$2, name, i$1)) then do
          return 0;
        end else if (Caml_string.get(name, i$1) == --[[ "." ]]46) then do
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
end end

function extension(name) do
  l = extension_len(name);
  if (l == 0) then do
    return "";
  end else do
    return $$String.sub(name, #name - l | 0, l);
  end end 
end end

function chop_extension(name) do
  l = extension_len(name);
  if (l == 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Filename.chop_extension"
        ];
  end
   end 
  return $$String.sub(name, 0, #name - l | 0);
end end

function remove_extension(name) do
  l = extension_len(name);
  if (l == 0) then do
    return name;
  end else do
    return $$String.sub(name, 0, #name - l | 0);
  end end 
end end

prng = Caml_obj.caml_lazy_make((function (param) do
        return Random.State.make_self_init(--[[ () ]]0);
      end end));

function temp_file_name(temp_dir, prefix, suffix) do
  rnd = Random.State.bits(CamlinternalLazy.force(prng)) & 16777215;
  return concat(temp_dir, Curry._3(Printf.sprintf(--[[ Format ]][
                      --[[ String ]]Block.__(2, [
                          --[[ No_padding ]]0,
                          --[[ Int ]]Block.__(4, [
                              --[[ Int_x ]]6,
                              --[[ Lit_padding ]]Block.__(0, [
                                  --[[ Zeros ]]2,
                                  6
                                ]),
                              --[[ No_precision ]]0,
                              --[[ String ]]Block.__(2, [
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "%s%06x%s"
                    ]), prefix, rnd, suffix));
end end

current_temp_dir_name = do
  contents: temp_dir_name$2
end;

function set_temp_dir_name(s) do
  current_temp_dir_name.contents = s;
  return --[[ () ]]0;
end end

function get_temp_dir_name(param) do
  return current_temp_dir_name.contents;
end end

function temp_file(temp_dirOpt, prefix, suffix) do
  temp_dir = temp_dirOpt ~= undefined and temp_dirOpt or current_temp_dir_name.contents;
  _counter = 0;
  while(true) do
    counter = _counter;
    name = temp_file_name(temp_dir, prefix, suffix);
    try do
      Caml_external_polyfill.resolve("caml_sys_close")(Caml_external_polyfill.resolve("caml_sys_open")(name, --[[ :: ]][
                --[[ Open_wronly ]]1,
                --[[ :: ]][
                  --[[ Open_creat ]]3,
                  --[[ :: ]][
                    --[[ Open_excl ]]5,
                    --[[ [] ]]0
                  ]
                ]
              ], 384));
      return name;
    end
    catch (raw_e)do
      e = Caml_js_exceptions.internalToOCamlException(raw_e);
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
end end

function open_temp_file(modeOpt, permsOpt, temp_dirOpt, prefix, suffix) do
  mode = modeOpt ~= undefined and modeOpt or --[[ :: ]][
      --[[ Open_text ]]7,
      --[[ [] ]]0
    ];
  perms = permsOpt ~= undefined and permsOpt or 384;
  temp_dir = temp_dirOpt ~= undefined and temp_dirOpt or current_temp_dir_name.contents;
  _counter = 0;
  while(true) do
    counter = _counter;
    name = temp_file_name(temp_dir, prefix, suffix);
    try do
      return --[[ tuple ]][
              name,
              Pervasives.open_out_gen(--[[ :: ]][
                    --[[ Open_wronly ]]1,
                    --[[ :: ]][
                      --[[ Open_creat ]]3,
                      --[[ :: ]][
                        --[[ Open_excl ]]5,
                        mode
                      ]
                    ]
                  ], perms, name)
            ];
    end
    catch (raw_e)do
      e = Caml_js_exceptions.internalToOCamlException(raw_e);
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
end end

current_dir_name$3 = match[0];

parent_dir_name = match[1];

is_relative$2 = match[4];

is_implicit$2 = match[5];

check_suffix$2 = match[6];

basename$3 = match[9];

dirname$3 = match[10];

quote$2 = match[8];

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
--[[ match Not a pure module ]]
