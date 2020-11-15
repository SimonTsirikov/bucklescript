

local Sys = require "..sys.lua";
local Block = require "..block.lua";
local Bytes = require "..bytes.lua";
local Curry = require "..curry.lua";
local __Buffer = require "..buffer.lua";
local Printf = require "..printf.lua";
local Random = require "..random.lua";
local __String = require "..string.lua";
local Caml_obj = require "..caml_obj.lua";
local Caml_sys = require "..caml_sys.lua";
local Caml_bytes = require "..caml_bytes.lua";
local Pervasives = require "..pervasives.lua";
local Caml_string = require "..caml_string.lua";
local CamlinternalLazy = require "..camlinternalLazy.lua";
local Caml_js_exceptions = require "..caml_js_exceptions.lua";
local Caml_external_polyfill = require "..caml_external_polyfill.lua";
local Caml_builtin_exceptions = require "..caml_builtin_exceptions.lua";

function generic_basename(is_dir_sep, current_dir_name, name) do
  if (name == "") then do
    return current_dir_name;
  end else do
    _n = #name - 1 | 0;
    while(true) do
      n = _n;
      if (n < 0) then do
        return __String.sub(name, 0, 1);
      end else if (Curry._2(is_dir_sep, name, n)) then do
        _n = n - 1 | 0;
        ::continue:: ;
      end else do
        _n_1 = n;
        p = n + 1 | 0;
        while(true) do
          n_1 = _n_1;
          if (n_1 < 0) then do
            return __String.sub(name, 0, p);
          end else if (Curry._2(is_dir_sep, name, n_1)) then do
            return __String.sub(name, n_1 + 1 | 0, (p - n_1 | 0) - 1 | 0);
          end else do
            _n_1 = n_1 - 1 | 0;
            ::continue:: ;
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
        return __String.sub(name, 0, 1);
      end else if (Curry._2(is_dir_sep, name, n)) then do
        _n = n - 1 | 0;
        ::continue:: ;
      end else do
        _n_1 = n;
        while(true) do
          n_1 = _n_1;
          if (n_1 < 0) then do
            return current_dir_name;
          end else if (Curry._2(is_dir_sep, name, n_1)) then do
            _n_2 = n_1;
            while(true) do
              n_2 = _n_2;
              if (n_2 < 0) then do
                return __String.sub(name, 0, 1);
              end else if (Curry._2(is_dir_sep, name, n_2)) then do
                _n_2 = n_2 - 1 | 0;
                ::continue:: ;
              end else do
                return __String.sub(name, 0, n_2 + 1 | 0);
              end end  end 
            end;
          end else do
            _n_1 = n_1 - 1 | 0;
            ::continue:: ;
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
  if (is_relative(n) and (#n < 2 or __String.sub(n, 0, 2) ~= "./")) then do
    if (#n < 3) then do
      return true;
    end else do
      return __String.sub(n, 0, 3) ~= "../";
    end end 
  end else do
    return false;
  end end 
end end

function check_suffix(name, suff) do
  if (#name >= #suff) then do
    return __String.sub(name, #name - #suff | 0, #suff) == suff;
  end else do
    return false;
  end end 
end end

temp_dir_name;

xpcall(function() do
  temp_dir_name = Caml_sys.caml_sys_getenv("TMPDIR");
end end,function(exn) do
  if (exn == Caml_builtin_exceptions.not_found) then do
    temp_dir_name = "/tmp";
  end else do
    error(exn)
  end end 
end end)

function quote(param) do
  quotequote = "'\\''";
  s = param;
  l = #s;
  b = __Buffer.create(l + 20 | 0);
  __Buffer.add_char(b, --[[ "'" ]]39);
  for i = 0 , l - 1 | 0 , 1 do
    if (Caml_string.get(s, i) == --[[ "'" ]]39) then do
      __Buffer.add_string(b, quotequote);
    end else do
      __Buffer.add_char(b, Caml_string.get(s, i));
    end end 
  end
  __Buffer.add_char(b, --[[ "'" ]]39);
  return __Buffer.contents(b);
end end

function basename(param) do
  return generic_basename(is_dir_sep, current_dir_name, param);
end end

function dirname(param) do
  return generic_dirname(is_dir_sep, current_dir_name, param);
end end

current_dir_name_1 = ".";

function is_dir_sep_1(s, i) do
  c = Caml_string.get(s, i);
  if (c == --[[ "/" ]]47 or c == --[[ "\\" ]]92) then do
    return true;
  end else do
    return c == --[[ ":" ]]58;
  end end 
end end

function is_relative_1(n) do
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

function is_implicit_1(n) do
  if (is_relative_1(n) and (#n < 2 or __String.sub(n, 0, 2) ~= "./") and (#n < 2 or __String.sub(n, 0, 2) ~= ".\\") and (#n < 3 or __String.sub(n, 0, 3) ~= "../")) then do
    if (#n < 3) then do
      return true;
    end else do
      return __String.sub(n, 0, 3) ~= "..\\";
    end end 
  end else do
    return false;
  end end 
end end

function check_suffix_1(name, suff) do
  if (#name >= #suff) then do
    s = __String.sub(name, #name - #suff | 0, #suff);
    return Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(s))) == Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(suff)));
  end else do
    return false;
  end end 
end end

temp_dir_name_1;

xpcall(function() do
  temp_dir_name_1 = Caml_sys.caml_sys_getenv("TEMP");
end end,function(exn_1) do
  if (exn_1 == Caml_builtin_exceptions.not_found) then do
    temp_dir_name_1 = ".";
  end else do
    error(exn_1)
  end end 
end end)

function quote_1(s) do
  l = #s;
  b = __Buffer.create(l + 20 | 0);
  __Buffer.add_char(b, --[[ "\"" ]]34);
  loop = function(_i) do
    while(true) do
      i = _i;
      if (i == l) then do
        return __Buffer.add_char(b, --[[ "\"" ]]34);
      end else do
        c = Caml_string.get(s, i);
        if (c ~= 34 and c ~= 92) then do
          __Buffer.add_char(b, c);
          _i = i + 1 | 0;
          ::continue:: ;
        end else do
          _n = 0;
          _i_1 = i;
          while(true) do
            i_1 = _i_1;
            n = _n;
            if (i_1 == l) then do
              __Buffer.add_char(b, --[[ "\"" ]]34);
              return add_bs(n);
            end else do
              match = Caml_string.get(s, i_1);
              if (match ~= 34) then do
                if (match ~= 92) then do
                  add_bs(n);
                  return loop(i_1);
                end else do
                  _i_1 = i_1 + 1 | 0;
                  _n = n + 1 | 0;
                  ::continue:: ;
                end end 
              end else do
                add_bs((n << 1) + 1 | 0);
                __Buffer.add_char(b, --[[ "\"" ]]34);
                return loop(i_1 + 1 | 0);
              end end 
            end end 
          end;
        end end 
      end end 
    end;
  end end;
  add_bs = function(n) do
    for _j = 1 , n , 1 do
      __Buffer.add_char(b, --[[ "\\" ]]92);
    end
    return --[[ () ]]0;
  end end;
  loop(0);
  return __Buffer.contents(b);
end end

function has_drive(s) do
  is_letter = function(param) do
    if (param >= 91) then do
      return not (param > 122 or param < 97);
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
    return --[[ tuple ]]{
            __String.sub(s, 0, 2),
            __String.sub(s, 2, #s - 2 | 0)
          };
  end else do
    return --[[ tuple ]]{
            "",
            s
          };
  end end 
end end

function dirname_1(s) do
  match = drive_and_path(s);
  dir = generic_dirname(is_dir_sep_1, current_dir_name_1, match[2]);
  return match[1] .. dir;
end end

function basename_1(s) do
  match = drive_and_path(s);
  return generic_basename(is_dir_sep_1, current_dir_name_1, match[2]);
end end

current_dir_name_2 = ".";

function basename_2(param) do
  return generic_basename(is_dir_sep_1, current_dir_name_2, param);
end end

function dirname_2(param) do
  return generic_dirname(is_dir_sep_1, current_dir_name_2, param);
end end

match;

local ___conditional___=(Sys.os_type);
do
   if ___conditional___ == "Cygwin" then do
      match = --[[ tuple ]]{
        current_dir_name_2,
        "..",
        "/",
        is_dir_sep_1,
        is_relative_1,
        is_implicit_1,
        check_suffix_1,
        temp_dir_name,
        quote,
        basename_2,
        dirname_2
      }; end else 
   if ___conditional___ == "Win32" then do
      match = --[[ tuple ]]{
        current_dir_name_1,
        "..",
        "\\",
        is_dir_sep_1,
        is_relative_1,
        is_implicit_1,
        check_suffix_1,
        temp_dir_name_1,
        quote_1,
        basename_1,
        dirname_1
      }; end else 
   end end end end
  match = --[[ tuple ]]{
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
    };
    
end

temp_dir_name_2 = match[8];

is_dir_sep_2 = match[4];

dir_sep = match[3];

function concat(dirname, filename) do
  l = #dirname;
  if (l == 0 or Curry._2(is_dir_sep_2, dirname, l - 1 | 0)) then do
    return dirname .. filename;
  end else do
    return dirname .. (dir_sep .. filename);
  end end 
end end

function chop_suffix(name, suff) do
  n = #name - #suff | 0;
  if (n < 0) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Filename.chop_suffix"
    })
  end
   end 
  return __String.sub(name, 0, n);
end end

function extension_len(name) do
  _i = #name - 1 | 0;
  while(true) do
    i = _i;
    if (i < 0 or Curry._2(is_dir_sep_2, name, i)) then do
      return 0;
    end else if (Caml_string.get(name, i) == --[[ "." ]]46) then do
      i0 = i;
      _i_1 = i - 1 | 0;
      while(true) do
        i_1 = _i_1;
        if (i_1 < 0 or Curry._2(is_dir_sep_2, name, i_1)) then do
          return 0;
        end else if (Caml_string.get(name, i_1) == --[[ "." ]]46) then do
          _i_1 = i_1 - 1 | 0;
          ::continue:: ;
        end else do
          return #name - i0 | 0;
        end end  end 
      end;
    end else do
      _i = i - 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function extension(name) do
  l = extension_len(name);
  if (l == 0) then do
    return "";
  end else do
    return __String.sub(name, #name - l | 0, l);
  end end 
end end

function chop_extension(name) do
  l = extension_len(name);
  if (l == 0) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Filename.chop_extension"
    })
  end
   end 
  return __String.sub(name, 0, #name - l | 0);
end end

function remove_extension(name) do
  l = extension_len(name);
  if (l == 0) then do
    return name;
  end else do
    return __String.sub(name, 0, #name - l | 0);
  end end 
end end

prng = Caml_obj.caml_lazy_make((function(param) do
        return Random.State.make_self_init(--[[ () ]]0);
      end end));

function temp_file_name(temp_dir, prefix, suffix) do
  rnd = Random.State.bits(CamlinternalLazy.force(prng)) & 16777215;
  return concat(temp_dir, Curry._3(Printf.sprintf(--[[ Format ]]{
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ Int ]]Block.__(4, {
                              --[[ Int_x ]]6,
                              --[[ Lit_padding ]]Block.__(0, {
                                  --[[ Zeros ]]2,
                                  6
                                }),
                              --[[ No_precision ]]0,
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                })
                            })
                        }),
                      "%s%06x%s"
                    }), prefix, rnd, suffix));
end end

current_temp_dir_name = {
  contents = temp_dir_name_2
};

function set_temp_dir_name(s) do
  current_temp_dir_name.contents = s;
  return --[[ () ]]0;
end end

function get_temp_dir_name(param) do
  return current_temp_dir_name.contents;
end end

function temp_file(temp_dirOpt, prefix, suffix) do
  temp_dir = temp_dirOpt ~= nil and temp_dirOpt or current_temp_dir_name.contents;
  _counter = 0;
  while(true) do
    counter = _counter;
    name = temp_file_name(temp_dir, prefix, suffix);
    xpcall(function() do
      Caml_external_polyfill.resolve("caml_sys_close")(Caml_external_polyfill.resolve("caml_sys_open")(name, --[[ :: ]]{
                --[[ Open_wronly ]]1,
                --[[ :: ]]{
                  --[[ Open_creat ]]3,
                  --[[ :: ]]{
                    --[[ Open_excl ]]5,
                    --[[ [] ]]0
                  }
                }
              }, 384));
      return name;
    end end,function(raw_e) do
      e = Caml_js_exceptions.internalToOCamlException(raw_e);
      if (e[1] == Caml_builtin_exceptions.sys_error) then do
        if (counter >= 1000) then do
          error(e)
        end
         end 
        _counter = counter + 1 | 0;
        ::continue:: ;
      end else do
        error(e)
      end end 
    end end)
  end;
end end

function open_temp_file(modeOpt, permsOpt, temp_dirOpt, prefix, suffix) do
  mode = modeOpt ~= nil and modeOpt or --[[ :: ]]{
      --[[ Open_text ]]7,
      --[[ [] ]]0
    };
  perms = permsOpt ~= nil and permsOpt or 384;
  temp_dir = temp_dirOpt ~= nil and temp_dirOpt or current_temp_dir_name.contents;
  _counter = 0;
  while(true) do
    counter = _counter;
    name = temp_file_name(temp_dir, prefix, suffix);
    xpcall(function() do
      return --[[ tuple ]]{
              name,
              Pervasives.open_out_gen(--[[ :: ]]{
                    --[[ Open_wronly ]]1,
                    --[[ :: ]]{
                      --[[ Open_creat ]]3,
                      --[[ :: ]]{
                        --[[ Open_excl ]]5,
                        mode
                      }
                    }
                  }, perms, name)
            };
    end end,function(raw_e) do
      e = Caml_js_exceptions.internalToOCamlException(raw_e);
      if (e[1] == Caml_builtin_exceptions.sys_error) then do
        if (counter >= 1000) then do
          error(e)
        end
         end 
        _counter = counter + 1 | 0;
        ::continue:: ;
      end else do
        error(e)
      end end 
    end end)
  end;
end end

current_dir_name_3 = match[1];

parent_dir_name = match[2];

is_relative_2 = match[5];

is_implicit_2 = match[6];

check_suffix_2 = match[7];

basename_3 = match[10];

dirname_3 = match[11];

quote_2 = match[9];

export do
  current_dir_name_3 as current_dir_name,
  parent_dir_name ,
  dir_sep ,
  concat ,
  is_relative_2 as is_relative,
  is_implicit_2 as is_implicit,
  check_suffix_2 as check_suffix,
  chop_suffix ,
  extension ,
  remove_extension ,
  chop_extension ,
  basename_3 as basename,
  dirname_3 as dirname,
  temp_file ,
  open_temp_file ,
  get_temp_dir_name ,
  set_temp_dir_name ,
  temp_dir_name_2 as temp_dir_name,
  quote_2 as quote,
  
end
--[[ match Not a pure module ]]
