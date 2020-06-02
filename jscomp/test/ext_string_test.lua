--[['use strict';]]

List = require "../../lib/js/list";
Bytes = require "../../lib/js/bytes";
Curry = require "../../lib/js/curry";
__String = require "../../lib/js/string";
Caml_bytes = require "../../lib/js/caml_bytes";
Caml_int32 = require "../../lib/js/caml_int32";
Caml_string = require "../../lib/js/caml_string";
Ext_bytes_test = require "./ext_bytes_test";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function split_by(keep_emptyOpt, is_delim, str) do
  keep_empty = keep_emptyOpt ~= undefined and keep_emptyOpt or false;
  len = #str;
  _acc = --[[ [] ]]0;
  _last_pos = len;
  _pos = len - 1 | 0;
  while(true) do
    pos = _pos;
    last_pos = _last_pos;
    acc = _acc;
    if (pos == -1) then do
      if (last_pos == 0 and not keep_empty) then do
        return acc;
      end else do
        return --[[ :: ]]{
                __String.sub(str, 0, last_pos),
                acc
              };
      end end 
    end else if (Curry._1(is_delim, Caml_string.get(str, pos))) then do
      new_len = (last_pos - pos | 0) - 1 | 0;
      if (new_len ~= 0 or keep_empty) then do
        v = __String.sub(str, pos + 1 | 0, new_len);
        _pos = pos - 1 | 0;
        _last_pos = pos;
        _acc = --[[ :: ]]{
          v,
          acc
        };
        ::continue:: ;
      end else do
        _pos = pos - 1 | 0;
        _last_pos = pos;
        ::continue:: ;
      end end 
    end else do
      _pos = pos - 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function trim(s) do
  i = 0;
  j = #s;
  while((function () do
          tmp = false;
          if (i < j) then do
            u = s.charCodeAt(i);
            tmp = u == --[[ "\t" ]]9 or u == --[[ "\n" ]]10 or u == --[[ " " ]]32;
          end
           end 
          return tmp;
        end end)()) do
    i = i + 1 | 0;
  end;
  k = j - 1 | 0;
  while((function () do
          tmp = false;
          if (k >= i) then do
            u = s.charCodeAt(k);
            tmp = u == --[[ "\t" ]]9 or u == --[[ "\n" ]]10 or u == --[[ " " ]]32;
          end
           end 
          return tmp;
        end end)()) do
    k = k - 1 | 0;
  end;
  return __String.sub(s, i, (k - i | 0) + 1 | 0);
end end

function split(keep_empty, str, on) do
  if (str == "") then do
    return --[[ [] ]]0;
  end else do
    return split_by(keep_empty, (function (x) do
                  return x == on;
                end end), str);
  end end 
end end

function quick_split_by_ws(str) do
  return split_by(false, (function (x) do
                if (x == --[[ "\t" ]]9 or x == --[[ "\n" ]]10) then do
                  return true;
                end else do
                  return x == --[[ " " ]]32;
                end end 
              end end), str);
end end

function starts_with(s, beg) do
  beg_len = #beg;
  s_len = #s;
  if (beg_len <= s_len) then do
    i = 0;
    while(i < beg_len and s[i] == beg[i]) do
      i = i + 1 | 0;
    end;
    return i == beg_len;
  end else do
    return false;
  end end 
end end

function ends_with_index(s, end_) do
  s_finish = #s - 1 | 0;
  s_beg = #end_ - 1 | 0;
  if (s_beg > s_finish) then do
    return -1;
  end else do
    _j = s_finish;
    _k = s_beg;
    while(true) do
      k = _k;
      j = _j;
      if (k < 0) then do
        return j + 1 | 0;
      end else if (s[j] == end_[k]) then do
        _k = k - 1 | 0;
        _j = j - 1 | 0;
        ::continue:: ;
      end else do
        return -1;
      end end  end 
    end;
  end end 
end end

function ends_with(s, end_) do
  return ends_with_index(s, end_) >= 0;
end end

function ends_with_then_chop(s, beg) do
  i = ends_with_index(s, beg);
  if (i >= 0) then do
    return __String.sub(s, 0, i);
  end
   end 
end end

function check_any_suffix_case(s, suffixes) do
  return List.exists((function (x) do
                return ends_with(s, x);
              end end), suffixes);
end end

function check_any_suffix_case_then_chop(s, suffixes) do
  _suffixes = suffixes;
  while(true) do
    suffixes$1 = _suffixes;
    if (suffixes$1) then do
      id = ends_with_index(s, suffixes$1[0]);
      if (id >= 0) then do
        return __String.sub(s, 0, id);
      end else do
        _suffixes = suffixes$1[1];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function escaped(s) do
  needs_escape = function (_i) do
    while(true) do
      i = _i;
      if (i >= #s) then do
        return false;
      end else do
        match = s.charCodeAt(i);
        if (match >= 32) then do
          switcher = match - 34 | 0;
          if (switcher > 58 or switcher < 0) then do
            if (switcher >= 93) then do
              return true;
            end else do
              _i = i + 1 | 0;
              ::continue:: ;
            end end 
          end else if (switcher > 57 or switcher < 1) then do
            return true;
          end else do
            _i = i + 1 | 0;
            ::continue:: ;
          end end  end 
        end else do
          return true;
        end end 
      end end 
    end;
  end end;
  if (needs_escape(0)) then do
    return Caml_bytes.bytes_to_string(Ext_bytes_test.escaped(Caml_bytes.bytes_of_string(s)));
  end else do
    return s;
  end end 
end end

function unsafe_for_all_range(s, _start, finish, p) do
  while(true) do
    start = _start;
    if (start > finish) then do
      return true;
    end else if (Curry._1(p, s.charCodeAt(start))) then do
      _start = start + 1 | 0;
      ::continue:: ;
    end else do
      return false;
    end end  end 
  end;
end end

function for_all_range(s, start, finish, p) do
  len = #s;
  if (start < 0 or finish >= len) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Ext_string_test.for_all_range"
    })
  end
   end 
  return unsafe_for_all_range(s, start, finish, p);
end end

function for_all(p, s) do
  return unsafe_for_all_range(s, 0, #s - 1 | 0, p);
end end

function is_empty(s) do
  return #s == 0;
end end

function repeat(n, s) do
  len = #s;
  res = Caml_bytes.caml_create_bytes(Caml_int32.imul(n, len));
  for i = 0 , n - 1 | 0 , 1 do
    __String.blit(s, 0, res, Caml_int32.imul(i, len), len);
  end
  return Bytes.to_string(res);
end end

function unsafe_is_sub(sub, i, s, j, len) do
  if ((j + len | 0) <= #s) then do
    _k = 0;
    while(true) do
      k = _k;
      if (k == len) then do
        return true;
      end else if (sub[i + k | 0] == s[j + k | 0]) then do
        _k = k + 1 | 0;
        ::continue:: ;
      end else do
        return false;
      end end  end 
    end;
  end else do
    return false;
  end end 
end end

Local_exit = Caml_exceptions.create("Ext_string_test.Local_exit");

function find(startOpt, sub, s) do
  start = startOpt ~= undefined and startOpt or 0;
  n = #sub;
  s_len = #s;
  i = start;
  xpcall(function() do
    while((i + n | 0) <= s_len) do
      if (unsafe_is_sub(sub, 0, s, i, n)) then do
        error (Local_exit)
      end
       end 
      i = i + 1 | 0;
    end;
    return -1;
  end end,function(exn) return do
    if (exn == Local_exit) then do
      return i;
    end else do
      error (exn)
    end end 
  end end)
end end

function contain_substring(s, sub) do
  return find(undefined, sub, s) >= 0;
end end

function non_overlap_count(sub, s) do
  sub_len = #sub;
  if (#sub == 0) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Ext_string_test.non_overlap_count"
    })
  end
   end 
  _acc = 0;
  _off = 0;
  while(true) do
    off = _off;
    acc = _acc;
    i = find(off, sub, s);
    if (i < 0) then do
      return acc;
    end else do
      _off = i + sub_len | 0;
      _acc = acc + 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function rfind(sub, s) do
  n = #sub;
  i = #s - n | 0;
  xpcall(function() do
    while(i >= 0) do
      if (unsafe_is_sub(sub, 0, s, i, n)) then do
        error (Local_exit)
      end
       end 
      i = i - 1 | 0;
    end;
    return -1;
  end end,function(exn) return do
    if (exn == Local_exit) then do
      return i;
    end else do
      error (exn)
    end end 
  end end)
end end

function tail_from(s, x) do
  len = #s;
  if (x > len) then do
    s$1 = "Ext_string_test.tail_from " .. (s .. (" : " .. String(x)));
    error ({
      Caml_builtin_exceptions.invalid_argument,
      s$1
    })
  end else do
    return __String.sub(s, x, len - x | 0);
  end end 
end end

function digits_of_str(s, offset, x) do
  _i = 0;
  _acc = 0;
  s$1 = s;
  x$1 = x;
  while(true) do
    acc = _acc;
    i = _i;
    if (i >= x$1) then do
      return acc;
    end else do
      _acc = (Caml_int32.imul(10, acc) + Caml_string.get(s$1, offset + i | 0) | 0) - 48 | 0;
      _i = i + 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function starts_with_and_number(s, offset, beg) do
  beg_len = #beg;
  s_len = #s;
  finish_delim = offset + beg_len | 0;
  if (finish_delim > s_len) then do
    return -1;
  end else do
    i = offset;
    while(i < finish_delim and s[i] == beg[i - offset | 0]) do
      i = i + 1 | 0;
    end;
    if (i == finish_delim) then do
      return digits_of_str(s, finish_delim, 2);
    end else do
      return -1;
    end end 
  end end 
end end

function equal(x, y) do
  return x == y;
end end

function unsafe_concat_with_length(len, sep, l) do
  if (l) then do
    hd = l[0];
    r = Caml_bytes.caml_create_bytes(len);
    hd_len = #hd;
    sep_len = #sep;
    Caml_bytes.caml_blit_string(hd, 0, r, 0, hd_len);
    pos = do
      contents: hd_len
    end;
    List.iter((function (s) do
            s_len = #s;
            Caml_bytes.caml_blit_string(sep, 0, r, pos.contents, sep_len);
            pos.contents = pos.contents + sep_len | 0;
            Caml_bytes.caml_blit_string(s, 0, r, pos.contents, s_len);
            pos.contents = pos.contents + s_len | 0;
            return --[[ () ]]0;
          end end), l[1]);
    return Caml_bytes.bytes_to_string(r);
  end else do
    return "";
  end end 
end end

function rindex_rec(s, _i, c) do
  while(true) do
    i = _i;
    if (i < 0 or s.charCodeAt(i) == c) then do
      return i;
    end else do
      _i = i - 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function rindex_rec_opt(s, _i, c) do
  while(true) do
    i = _i;
    if (i < 0) then do
      return ;
    end else if (s.charCodeAt(i) == c) then do
      return i;
    end else do
      _i = i - 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function rindex_neg(s, c) do
  return rindex_rec(s, #s - 1 | 0, c);
end end

function rindex_opt(s, c) do
  return rindex_rec_opt(s, #s - 1 | 0, c);
end end

function is_valid_module_file(s) do
  len = #s;
  if (len > 0) then do
    match = s.charCodeAt(0);
    if (match >= 91) then do
      if (match > 122 or match < 97) then do
        return false;
      end
       end 
    end else if (match < 65) then do
      return false;
    end
     end  end 
    return unsafe_for_all_range(s, 1, len - 1 | 0, (function (x) do
                  if (x >= 65) then do
                    switcher = x - 91 | 0;
                    if (switcher > 5 or switcher < 0) then do
                      return switcher < 32;
                    end else do
                      return switcher == 4;
                    end end 
                  end else if (x >= 48) then do
                    return x < 58;
                  end else do
                    return x == 39;
                  end end  end 
                end end));
  end else do
    return false;
  end end 
end end

function is_valid_npm_package_name(s) do
  len = #s;
  if (len <= 214 and len > 0) then do
    match = s.charCodeAt(0);
    if (match >= 97) then do
      if (match >= 123) then do
        return false;
      end
       end 
    end else if (match ~= 64) then do
      return false;
    end
     end  end 
    return unsafe_for_all_range(s, 1, len - 1 | 0, (function (x) do
                  if (x >= 58) then do
                    if (x >= 97) then do
                      return x < 123;
                    end else do
                      return x == 95;
                    end end 
                  end else if (x ~= 45) then do
                    return x >= 48;
                  end else do
                    return true;
                  end end  end 
                end end));
  end else do
    return false;
  end end 
end end

function is_valid_source_name(name) do
  match = check_any_suffix_case_then_chop(name, --[[ :: ]]{
        ".ml",
        --[[ :: ]]{
          ".re",
          --[[ :: ]]{
            ".mli",
            --[[ :: ]]{
              ".rei",
              --[[ [] ]]0
            }
          }
        }
      });
  if (match ~= undefined) then do
    if (is_valid_module_file(match)) then do
      return --[[ Good ]]0;
    end else do
      return --[[ Invalid_module_name ]]1;
    end end 
  end else do
    return --[[ Suffix_mismatch ]]2;
  end end 
end end

function unsafe_no_char(x, ch, _i, last_idx) do
  while(true) do
    i = _i;
    if (i > last_idx) then do
      return true;
    end else if (x.charCodeAt(i) ~= ch) then do
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return false;
    end end  end 
  end;
end end

function unsafe_no_char_idx(x, ch, _i, last_idx) do
  while(true) do
    i = _i;
    if (i > last_idx) then do
      return -1;
    end else if (x.charCodeAt(i) ~= ch) then do
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return i;
    end end  end 
  end;
end end

function no_char(x, ch, i, len) do
  str_len = #x;
  if (i < 0 or i >= str_len or len >= str_len) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "Ext_string_test.no_char"
    })
  end
   end 
  return unsafe_no_char(x, ch, i, len);
end end

function no_slash(x) do
  return unsafe_no_char(x, --[[ "/" ]]47, 0, #x - 1 | 0);
end end

function no_slash_idx(x) do
  return unsafe_no_char_idx(x, --[[ "/" ]]47, 0, #x - 1 | 0);
end end

function replace_slash_backward(x) do
  len = #x;
  if (unsafe_no_char(x, --[[ "/" ]]47, 0, len - 1 | 0)) then do
    return x;
  end else do
    return __String.map((function (x) do
                  if (x ~= 47) then do
                    return x;
                  end else do
                    return --[[ "\\" ]]92;
                  end end 
                end end), x);
  end end 
end end

function replace_backward_slash(x) do
  len = #x;
  if (unsafe_no_char(x, --[[ "\\" ]]92, 0, len - 1 | 0)) then do
    return x;
  end else do
    return __String.map((function (x) do
                  if (x ~= 92) then do
                    return x;
                  end else do
                    return --[[ "/" ]]47;
                  end end 
                end end), x);
  end end 
end end

empty = "";

single_space = " ";

function concat_array(sep, s) do
  s_len = #s;
  if (s_len ~= 0) then do
    if (s_len ~= 1) then do
      sep_len = #sep;
      len = 0;
      for i = 0 , s_len - 1 | 0 , 1 do
        len = len + #s[i] | 0;
      end
      target = Caml_bytes.caml_create_bytes(len + Caml_int32.imul(s_len - 1 | 0, sep_len) | 0);
      hd = s[0];
      hd_len = #hd;
      Caml_bytes.caml_blit_string(hd, 0, target, 0, hd_len);
      current_offset = hd_len;
      for i$1 = 1 , s_len - 1 | 0 , 1 do
        Caml_bytes.caml_blit_string(sep, 0, target, current_offset, sep_len);
        cur = s[i$1];
        cur_len = #cur;
        new_off_set = current_offset + sep_len | 0;
        Caml_bytes.caml_blit_string(cur, 0, target, new_off_set, cur_len);
        current_offset = new_off_set + cur_len | 0;
      end
      return Caml_bytes.bytes_to_string(target);
    end else do
      return s[0];
    end end 
  end else do
    return empty;
  end end 
end end

function concat3(a, b, c) do
  a_len = #a;
  b_len = #b;
  c_len = #c;
  len = (a_len + b_len | 0) + c_len | 0;
  target = Caml_bytes.caml_create_bytes(len);
  Caml_bytes.caml_blit_string(a, 0, target, 0, a_len);
  Caml_bytes.caml_blit_string(b, 0, target, a_len, b_len);
  Caml_bytes.caml_blit_string(c, 0, target, a_len + b_len | 0, c_len);
  return Caml_bytes.bytes_to_string(target);
end end

function concat4(a, b, c, d) do
  a_len = #a;
  b_len = #b;
  c_len = #c;
  d_len = #d;
  len = ((a_len + b_len | 0) + c_len | 0) + d_len | 0;
  target = Caml_bytes.caml_create_bytes(len);
  Caml_bytes.caml_blit_string(a, 0, target, 0, a_len);
  Caml_bytes.caml_blit_string(b, 0, target, a_len, b_len);
  Caml_bytes.caml_blit_string(c, 0, target, a_len + b_len | 0, c_len);
  Caml_bytes.caml_blit_string(d, 0, target, (a_len + b_len | 0) + c_len | 0, d_len);
  return Caml_bytes.bytes_to_string(target);
end end

function concat5(a, b, c, d, e) do
  a_len = #a;
  b_len = #b;
  c_len = #c;
  d_len = #d;
  e_len = #e;
  len = (((a_len + b_len | 0) + c_len | 0) + d_len | 0) + e_len | 0;
  target = Caml_bytes.caml_create_bytes(len);
  Caml_bytes.caml_blit_string(a, 0, target, 0, a_len);
  Caml_bytes.caml_blit_string(b, 0, target, a_len, b_len);
  Caml_bytes.caml_blit_string(c, 0, target, a_len + b_len | 0, c_len);
  Caml_bytes.caml_blit_string(d, 0, target, (a_len + b_len | 0) + c_len | 0, d_len);
  Caml_bytes.caml_blit_string(e, 0, target, ((a_len + b_len | 0) + c_len | 0) + d_len | 0, e_len);
  return Caml_bytes.bytes_to_string(target);
end end

function inter2(a, b) do
  return concat3(a, single_space, b);
end end

function inter3(a, b, c) do
  return concat5(a, single_space, b, single_space, c);
end end

function inter4(a, b, c, d) do
  return concat_array(single_space, {
              a,
              b,
              c,
              d
            });
end end

check_suffix_case = ends_with;

check_suffix_case_then_chop = ends_with_then_chop;

single_colon = ":";

parent_dir_lit = "..";

current_dir_lit = ".";

exports.split_by = split_by;
exports.trim = trim;
exports.split = split;
exports.quick_split_by_ws = quick_split_by_ws;
exports.starts_with = starts_with;
exports.ends_with_index = ends_with_index;
exports.ends_with = ends_with;
exports.ends_with_then_chop = ends_with_then_chop;
exports.check_suffix_case = check_suffix_case;
exports.check_suffix_case_then_chop = check_suffix_case_then_chop;
exports.check_any_suffix_case = check_any_suffix_case;
exports.check_any_suffix_case_then_chop = check_any_suffix_case_then_chop;
exports.escaped = escaped;
exports.unsafe_for_all_range = unsafe_for_all_range;
exports.for_all_range = for_all_range;
exports.for_all = for_all;
exports.is_empty = is_empty;
exports.repeat = repeat;
exports.unsafe_is_sub = unsafe_is_sub;
exports.Local_exit = Local_exit;
exports.find = find;
exports.contain_substring = contain_substring;
exports.non_overlap_count = non_overlap_count;
exports.rfind = rfind;
exports.tail_from = tail_from;
exports.digits_of_str = digits_of_str;
exports.starts_with_and_number = starts_with_and_number;
exports.equal = equal;
exports.unsafe_concat_with_length = unsafe_concat_with_length;
exports.rindex_rec = rindex_rec;
exports.rindex_rec_opt = rindex_rec_opt;
exports.rindex_neg = rindex_neg;
exports.rindex_opt = rindex_opt;
exports.is_valid_module_file = is_valid_module_file;
exports.is_valid_npm_package_name = is_valid_npm_package_name;
exports.is_valid_source_name = is_valid_source_name;
exports.unsafe_no_char = unsafe_no_char;
exports.unsafe_no_char_idx = unsafe_no_char_idx;
exports.no_char = no_char;
exports.no_slash = no_slash;
exports.no_slash_idx = no_slash_idx;
exports.replace_slash_backward = replace_slash_backward;
exports.replace_backward_slash = replace_backward_slash;
exports.empty = empty;
exports.single_space = single_space;
exports.single_colon = single_colon;
exports.concat_array = concat_array;
exports.concat3 = concat3;
exports.concat4 = concat4;
exports.concat5 = concat5;
exports.inter2 = inter2;
exports.inter3 = inter3;
exports.inter4 = inter4;
exports.parent_dir_lit = parent_dir_lit;
exports.current_dir_lit = current_dir_lit;
--[[ Ext_bytes_test Not a pure module ]]
