console = {log = print};

Sys = require "../../lib/js/sys";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Bytes = require "../../lib/js/bytes";
Curry = require "../../lib/js/curry";
Format = require "../../lib/js/format";
__String = require "../../lib/js/string";
Caml_obj = require "../../lib/js/caml_obj";
Caml_sys = require "../../lib/js/caml_sys";
Filename = require "../../lib/js/filename";
Caml_bytes = require "../../lib/js/caml_bytes";
Pervasives = require "../../lib/js/pervasives";
Test_literals = require "./test_literals";
Ext_string_test = require "./ext_string_test";
CamlinternalLazy = require "../../lib/js/camlinternalLazy";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Ext_pervasives_test = require "./ext_pervasives_test";
Caml_external_polyfill = require "../../lib/js/caml_external_polyfill";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

node_sep = "/";

node_parent = "..";

node_current = ".";

cwd = Caml_obj.caml_lazy_make((function(param) do
        return Caml_sys.caml_sys_getcwd(--[[ () ]]0);
      end end));

function path_as_directory(x) do
  if (x == "" or Ext_string_test.ends_with(x, Filename.dir_sep)) then do
    return x;
  end else do
    return x .. Filename.dir_sep;
  end end 
end end

function absolute_path(s) do
  s_1 = s;
  s_2 = Curry._1(Filename.is_relative, s_1) and Filename.concat(CamlinternalLazy.force(cwd), s_1) or s_1;
  aux = function(_s) do
    while(true) do
      s = _s;
      base = Curry._1(Filename.basename, s);
      dir = Curry._1(Filename.dirname, s);
      if (dir == s) then do
        return dir;
      end else if (base == Filename.current_dir_name) then do
        _s = dir;
        ::continue:: ;
      end else if (base == Filename.parent_dir_name) then do
        return Curry._1(Filename.dirname, aux(dir));
      end else do
        return Filename.concat(aux(dir), base);
      end end  end  end 
    end;
  end end;
  return aux(s_2);
end end

function chop_extension(locOpt, name) do
  loc = locOpt ~= undefined and locOpt or "";
  xpcall(function() do
    return Filename.chop_extension(name);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) then do
      return Curry._2(Format.ksprintf(Pervasives.invalid_arg, --[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "Filename.chop_extension ( ",
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " : ",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          " )",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                })
                            })
                        }),
                      "Filename.chop_extension ( %s : %s )"
                    }), loc, name);
    end else do
      error(exn)
    end end 
  end end)
end end

function chop_extension_if_any(fname) do
  xpcall(function() do
    return Filename.chop_extension(fname);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) then do
      return fname;
    end else do
      error(exn)
    end end 
  end end)
end end

os_path_separator_char = Filename.dir_sep.charCodeAt(0);

function relative_path(file_or_dir_1, file_or_dir_2) do
  relevant_dir1 = file_or_dir_1[0] >= 781515420 and Curry._1(Filename.dirname, file_or_dir_1[1]) or file_or_dir_1[1];
  relevant_dir2 = file_or_dir_2[0] >= 781515420 and Curry._1(Filename.dirname, file_or_dir_2[1]) or file_or_dir_2[1];
  dir1 = Ext_string_test.split(undefined, relevant_dir1, os_path_separator_char);
  dir2 = Ext_string_test.split(undefined, relevant_dir2, os_path_separator_char);
  go = function(_dir1, _dir2) do
    while(true) do
      dir2 = _dir2;
      dir1 = _dir1;
      if (dir1 and dir2 and dir1[0] == dir2[0]) then do
        _dir2 = dir2[1];
        _dir1 = dir1[1];
        ::continue:: ;
      end
       end 
      return Pervasives.$at(List.map((function(param) do
                        return node_parent;
                      end end), dir2), dir1);
    end;
  end end;
  ys = go(dir1, dir2);
  if (ys and ys[0] == node_parent) then do
    return __String.concat(node_sep, ys);
  end else do
    return __String.concat(node_sep, --[[ :: ]]{
                node_current,
                ys
              });
  end end 
end end

function node_relative_path(node_modules_shorten, file1, dep_file) do
  file2 = dep_file[1];
  v = Ext_string_test.find(undefined, Test_literals.node_modules, file2);
  len = #file2;
  if (node_modules_shorten and v >= 0) then do
    skip = function(_i) do
      while(true) do
        i = _i;
        if (i >= len) then do
          return Curry._1(Ext_pervasives_test.failwithf("File \"ext_filename_test.ml\", line 162, characters 43-50", --[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "invalid path: ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "invalid path: %s"
                        }), file2);
        end else do
          curr_char = file2.charCodeAt(i);
          if (curr_char == os_path_separator_char or curr_char == --[[ "." ]]46) then do
            _i = i + 1 | 0;
            ::continue:: ;
          end else do
            return i;
          end end 
        end end 
      end;
    end end;
    return Ext_string_test.tail_from(file2, skip(v + Test_literals.node_modules_length | 0));
  end else do
    return relative_path(dep_file[0] >= 781515420 and --[[ `File ]]{
                  781515420,
                  absolute_path(dep_file[1])
                } or --[[ `Dir ]]{
                  3405101,
                  absolute_path(dep_file[1])
                }, file1[0] >= 781515420 and --[[ `File ]]{
                  781515420,
                  absolute_path(file1[1])
                } or --[[ `Dir ]]{
                  3405101,
                  absolute_path(file1[1])
                }) .. (node_sep .. Curry._1(Filename.basename, file2));
  end end 
end end

function find_root_filename(_cwd, filename) do
  while(true) do
    cwd = _cwd;
    if (Caml_external_polyfill.resolve("caml_sys_file_exists")(Filename.concat(cwd, filename))) then do
      return cwd;
    end else do
      cwd$prime = Curry._1(Filename.dirname, cwd);
      if (#cwd$prime < #cwd) then do
        _cwd = cwd$prime;
        ::continue:: ;
      end else do
        return Curry._2(Ext_pervasives_test.failwithf("File \"ext_filename_test.ml\", line 205, characters 13-20", --[[ Format ]]{
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " not found from ",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ End_of_format ]]0
                                  })
                              })
                          }),
                        "%s not found from %s"
                      }), filename, cwd);
      end end 
    end end 
  end;
end end

function find_package_json_dir(cwd) do
  return find_root_filename(cwd, Test_literals.bsconfig_json);
end end

package_dir = Caml_obj.caml_lazy_make((function(param) do
        cwd_1 = CamlinternalLazy.force(cwd);
        return find_root_filename(cwd_1, Test_literals.bsconfig_json);
      end end));

function module_name_of_file(file) do
  s = Filename.chop_extension(Curry._1(Filename.basename, file));
  return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s)));
end end

function module_name_of_file_if_any(file) do
  s = chop_extension_if_any(Curry._1(Filename.basename, file));
  return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s)));
end end

function combine(p1, p2) do
  if (p1 == "" or p1 == Filename.current_dir_name) then do
    return p2;
  end else if (p2 == "" or p2 == Filename.current_dir_name) then do
    return p1;
  end else if (Curry._1(Filename.is_relative, p2)) then do
    return Filename.concat(p1, p2);
  end else do
    return p2;
  end end  end  end 
end end

function split_aux(p) do
  _p = p;
  _acc = --[[ [] ]]0;
  while(true) do
    acc = _acc;
    p_1 = _p;
    dir = Curry._1(Filename.dirname, p_1);
    if (dir == p_1) then do
      return --[[ tuple ]]{
              dir,
              acc
            };
    end else do
      new_path = Curry._1(Filename.basename, p_1);
      if (new_path == Filename.dir_sep) then do
        _p = dir;
        ::continue:: ;
      end else do
        _acc = --[[ :: ]]{
          new_path,
          acc
        };
        _p = dir;
        ::continue:: ;
      end end 
    end end 
  end;
end end

function rel_normalized_absolute_path(from, to_) do
  match = split_aux(from);
  match_1 = split_aux(to_);
  root2 = match_1[0];
  if (match[0] ~= root2) then do
    return root2;
  end else do
    _xss = match[1];
    _yss = match_1[1];
    while(true) do
      yss = _yss;
      xss = _xss;
      if (xss) then do
        xs = xss[1];
        if (yss) then do
          if (xss[0] == yss[0]) then do
            _yss = yss[1];
            _xss = xs;
            ::continue:: ;
          end else do
            start = List.fold_left((function(acc, param) do
                    return Filename.concat(acc, Ext_string_test.parent_dir_lit);
                  end end), Ext_string_test.parent_dir_lit, xs);
            return List.fold_left(Filename.concat, start, yss);
          end end 
        end else do
          return List.fold_left((function(acc, param) do
                        return Filename.concat(acc, Ext_string_test.parent_dir_lit);
                      end end), Ext_string_test.parent_dir_lit, xs);
        end end 
      end else if (yss) then do
        return List.fold_left(Filename.concat, yss[0], yss[1]);
      end else do
        return Ext_string_test.empty;
      end end  end 
    end;
  end end 
end end

function normalize_absolute_path(x) do
  drop_if_exist = function(xs) do
    if (xs) then do
      return xs[1];
    end else do
      return --[[ [] ]]0;
    end end 
  end end;
  normalize_list = function(_acc, _paths) do
    while(true) do
      paths = _paths;
      acc = _acc;
      if (paths) then do
        xs = paths[1];
        x = paths[0];
        _paths = xs;
        if (x == Ext_string_test.current_dir_lit) then do
          ::continue:: ;
        end else if (x == Ext_string_test.parent_dir_lit) then do
          _acc = drop_if_exist(acc);
          ::continue:: ;
        end else do
          _acc = --[[ :: ]]{
            x,
            acc
          };
          ::continue:: ;
        end end  end 
      end else do
        return acc;
      end end 
    end;
  end end;
  match = split_aux(x);
  root = match[0];
  rev_paths = normalize_list(--[[ [] ]]0, match[1]);
  if (rev_paths) then do
    _acc = rev_paths[0];
    _rev_paths = rev_paths[1];
    while(true) do
      rev_paths_1 = _rev_paths;
      acc = _acc;
      if (rev_paths_1) then do
        _rev_paths = rev_paths_1[1];
        _acc = Filename.concat(rev_paths_1[0], acc);
        ::continue:: ;
      end else do
        return Filename.concat(root, acc);
      end end 
    end;
  end else do
    return root;
  end end 
end end

function get_extension(x) do
  pos = Ext_string_test.rindex_neg(x, --[[ "." ]]46);
  if (pos < 0) then do
    return "";
  end else do
    return Ext_string_test.tail_from(x, pos);
  end end 
end end

simple_convert_node_path_to_os_path;

if (Sys.unix) then do
  simple_convert_node_path_to_os_path = (function(x) do
      return x;
    end end);
end else if (Sys.win32 or false) then do
  simple_convert_node_path_to_os_path = Ext_string_test.replace_slash_backward;
end else do
  s = "Unknown OS : " .. Sys.os_type;
  error({
    Caml_builtin_exceptions.failure,
    s
  })
end end  end 

$slash$slash = Filename.concat;

exports = {}
exports.node_sep = node_sep;
exports.node_parent = node_parent;
exports.node_current = node_current;
exports.cwd = cwd;
exports.$slash$slash = $slash$slash;
exports.path_as_directory = path_as_directory;
exports.absolute_path = absolute_path;
exports.chop_extension = chop_extension;
exports.chop_extension_if_any = chop_extension_if_any;
exports.os_path_separator_char = os_path_separator_char;
exports.relative_path = relative_path;
exports.node_relative_path = node_relative_path;
exports.find_root_filename = find_root_filename;
exports.find_package_json_dir = find_package_json_dir;
exports.package_dir = package_dir;
exports.module_name_of_file = module_name_of_file;
exports.module_name_of_file_if_any = module_name_of_file_if_any;
exports.combine = combine;
exports.split_aux = split_aux;
exports.rel_normalized_absolute_path = rel_normalized_absolute_path;
exports.normalize_absolute_path = normalize_absolute_path;
exports.get_extension = get_extension;
exports.simple_convert_node_path_to_os_path = simple_convert_node_path_to_os_path;
--[[ simple_convert_node_path_to_os_path Not a pure module ]]
