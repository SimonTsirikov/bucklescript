

import * as Block from "./block.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

for_in = (function(o,foo){
        for (var x in o) { foo(x) }});

function caml_obj_block(tag, size) do
  v = new Array(size);
  v.tag = tag;
  return v;
end end

function caml_obj_dup(x) do
  if (Array.isArray(x)) then do
    len = #x | 0;
    v = new Array(len);
    for i = 0 , len - 1 | 0 , 1 do
      v[i] = x[i];
    end
    v.tag = x.tag | 0;
    return v;
  end else do
    return Object.assign(({}), x);
  end end 
end end

function caml_obj_truncate(x, new_size) do
  len = #x | 0;
  if (new_size <= 0 or new_size > len) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Obj.truncate"
    })
  end
   end 
  if (len ~= new_size) then do
    for i = new_size , len - 1 | 0 , 1 do
      x[i] = 0;
    end
    x.length = new_size;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function caml_lazy_make_forward(x) do
  return Block.__(250, {x});
end end

function caml_lazy_make(fn) do
  block = {fn};
  block.tag = 246;
  return block;
end end

caml_update_dummy = (function(x,y){
  for (var k in y){
    x[k] = y[k]
  }
  return 0;
  });

function caml_compare(_a, _b) do
  while(true) do
    b = _b;
    a = _a;
    if (a == b) then do
      return 0;
    end else do
      a_type = typeof a;
      b_type = typeof b;
      local ___conditional___=(a_type);
      do
         if ___conditional___ == "boolean" then do
            if (b_type == "boolean") then do
              return Caml_primitive.caml_bool_compare(a, b);
            end
             end  end else 
         if ___conditional___ == "function" then do
            if (b_type == "function") then do
              error({
                Caml_builtin_exceptions.invalid_argument,
                "compare: functional value"
              })
            end
             end  end else 
         if ___conditional___ == "number" then do
            if (b_type == "number") then do
              return Caml_primitive.caml_int_compare(a, b);
            end
             end  end else 
         if ___conditional___ == "string" then do
            if (b_type == "string") then do
              return Caml_primitive.caml_string_compare(a, b);
            end else do
              return 1;
            end end  end end end end end end end end 
         if ___conditional___ == "undefined" then do
            return -1; end end 
        
      end
      local ___conditional___=(b_type);
      do
         if ___conditional___ == "string" then do
            return -1; end end 
         if ___conditional___ == "undefined" then do
            return 1; end end 
        if (a_type == "boolean") then do
            return 1;
          end else if (b_type == "boolean") then do
            return -1;
          end else if (a_type == "function") then do
            return 1;
          end else if (b_type == "function") then do
            return -1;
          end else if (a_type == "number") then do
            if (b == nil or b.tag == 256) then do
              return 1;
            end else do
              return -1;
            end end 
          end else if (b_type == "number") then do
            if (a == nil or a.tag == 256) then do
              return -1;
            end else do
              return 1;
            end end 
          end else if (a == nil) then do
            if (b.tag == 256) then do
              return 1;
            end else do
              return -1;
            end end 
          end else if (b == nil) then do
            if (a.tag == 256) then do
              return -1;
            end else do
              return 1;
            end end 
          end else do
            tag_a = a.tag | 0;
            tag_b = b.tag | 0;
            if (tag_a == 250) then do
              _a = a[0];
              ::continue:: ;
            end else if (tag_b == 250) then do
              _b = b[0];
              ::continue:: ;
            end else if (tag_a == 256) then do
              if (tag_b == 256) then do
                return Caml_primitive.caml_int_compare(a[1], b[1]);
              end else do
                return -1;
              end end 
            end else if (tag_a == 248) then do
              return Caml_primitive.caml_int_compare(a[1], b[1]);
            end else do
              if (tag_a == 251) then do
                error({
                  Caml_builtin_exceptions.invalid_argument,
                  "equal: abstract value"
                })
              end
               end 
              if (tag_a ~= tag_b) then do
                if (tag_a < tag_b) then do
                  return -1;
                end else do
                  return 1;
                end end 
              end else do
                len_a = #a | 0;
                len_b = #b | 0;
                if (len_a == len_b) then do
                  if (Array.isArray(a)) then do
                    a_1 = a;
                    b_1 = b;
                    _i = 0;
                    same_length = len_a;
                    while(true) do
                      i = _i;
                      if (i == same_length) then do
                        return 0;
                      end else do
                        res = caml_compare(a_1[i], b_1[i]);
                        if (res ~= 0) then do
                          return res;
                        end else do
                          _i = i + 1 | 0;
                          ::continue:: ;
                        end end 
                      end end 
                    end;
                  end else if ((a instanceof Date && b instanceof Date)) then do
                    return (a - b);
                  end else do
                    a_2 = a;
                    b_2 = b;
                    min_key_lhs = do
                      contents: undefined
                    end;
                    min_key_rhs = do
                      contents: undefined
                    end;
                    do_key = function(param, key) do
                      min_key = param[2];
                      b = param[1];
                      if (not b.hasOwnProperty(key) or caml_compare(param[0][key], b[key]) > 0) then do
                        match = min_key.contents;
                        if (match ~= undefined and key >= match) then do
                          return 0;
                        end else do
                          min_key.contents = key;
                          return --[[ () ]]0;
                        end end 
                      end else do
                        return 0;
                      end end 
                    end end;
                    partial_arg = --[[ tuple ]]{
                      a_2,
                      b_2,
                      min_key_rhs
                    };
                    do_key_a = (function(partial_arg)do
                    return function do_key_a(param) do
                      return do_key(partial_arg, param);
                    end end
                    end end)(partial_arg);
                    partial_arg_1 = --[[ tuple ]]{
                      b_2,
                      a_2,
                      min_key_lhs
                    };
                    do_key_b = (function(partial_arg_1)do
                    return function do_key_b(param) do
                      return do_key(partial_arg_1, param);
                    end end
                    end end)(partial_arg_1);
                    for_in(a_2, do_key_a);
                    for_in(b_2, do_key_b);
                    match = min_key_lhs.contents;
                    match_1 = min_key_rhs.contents;
                    if (match ~= undefined) then do
                      if (match_1 ~= undefined) then do
                        return Caml_primitive.caml_string_compare(match, match_1);
                      end else do
                        return -1;
                      end end 
                    end else if (match_1 ~= undefined) then do
                      return 1;
                    end else do
                      return 0;
                    end end  end 
                  end end  end 
                end else if (len_a < len_b) then do
                  a_3 = a;
                  b_3 = b;
                  _i_1 = 0;
                  short_length = len_a;
                  while(true) do
                    i_1 = _i_1;
                    if (i_1 == short_length) then do
                      return -1;
                    end else do
                      res_1 = caml_compare(a_3[i_1], b_3[i_1]);
                      if (res_1 ~= 0) then do
                        return res_1;
                      end else do
                        _i_1 = i_1 + 1 | 0;
                        ::continue:: ;
                      end end 
                    end end 
                  end;
                end else do
                  a_4 = a;
                  b_4 = b;
                  _i_2 = 0;
                  short_length_1 = len_b;
                  while(true) do
                    i_2 = _i_2;
                    if (i_2 == short_length_1) then do
                      return 1;
                    end else do
                      res_2 = caml_compare(a_4[i_2], b_4[i_2]);
                      if (res_2 ~= 0) then do
                        return res_2;
                      end else do
                        _i_2 = i_2 + 1 | 0;
                        ::continue:: ;
                      end end 
                    end end 
                  end;
                end end  end 
              end end 
            end end  end  end  end 
          end end  end  end  end  end  end  end  end 
          
      end
    end end 
  end;
end end

function caml_equal(_a, _b) do
  while(true) do
    b = _b;
    a = _a;
    if (a == b) then do
      return true;
    end else do
      a_type = typeof a;
      if (a_type == "string" or a_type == "number" or a_type == "boolean" or a_type == "undefined" or a == null) then do
        return false;
      end else do
        b_type = typeof b;
        if (a_type == "function" or b_type == "function") then do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "equal: functional value"
          })
        end
         end 
        if (b_type == "number" or b_type == "undefined" or b == null) then do
          return false;
        end else do
          tag_a = a.tag | 0;
          tag_b = b.tag | 0;
          if (tag_a == 250) then do
            _a = a[0];
            ::continue:: ;
          end else if (tag_b == 250) then do
            _b = b[0];
            ::continue:: ;
          end else if (tag_a == 248) then do
            return a[1] == b[1];
          end else do
            if (tag_a == 251) then do
              error({
                Caml_builtin_exceptions.invalid_argument,
                "equal: abstract value"
              })
            end
             end 
            if (tag_a ~= tag_b) then do
              return false;
            end else if (tag_a == 256) then do
              return a[1] == b[1];
            end else do
              len_a = #a | 0;
              len_b = #b | 0;
              if (len_a == len_b) then do
                if (Array.isArray(a)) then do
                  a_1 = a;
                  b_1 = b;
                  _i = 0;
                  same_length = len_a;
                  while(true) do
                    i = _i;
                    if (i == same_length) then do
                      return true;
                    end else if (caml_equal(a_1[i], b_1[i])) then do
                      _i = i + 1 | 0;
                      ::continue:: ;
                    end else do
                      return false;
                    end end  end 
                  end;
                end else if ((a instanceof Date && b instanceof Date)) then do
                  return not (a > b or a < b);
                end else do
                  a_2 = a;
                  b_2 = b;
                  result = do
                    contents: true
                  end;
                  do_key_a = (function(b_2,result)do
                  return function do_key_a(key) do
                    if (b_2.hasOwnProperty(key)) then do
                      return 0;
                    end else do
                      result.contents = false;
                      return --[[ () ]]0;
                    end end 
                  end end
                  end end)(b_2,result);
                  do_key_b = (function(a_2,b_2,result)do
                  return function do_key_b(key) do
                    if (not a_2.hasOwnProperty(key) or not caml_equal(b_2[key], a_2[key])) then do
                      result.contents = false;
                      return --[[ () ]]0;
                    end else do
                      return 0;
                    end end 
                  end end
                  end end)(a_2,b_2,result);
                  for_in(a_2, do_key_a);
                  if (result.contents) then do
                    for_in(b_2, do_key_b);
                  end
                   end 
                  return result.contents;
                end end  end 
              end else do
                return false;
              end end 
            end end  end 
          end end  end  end 
        end end 
      end end 
    end end 
  end;
end end

function caml_equal_null(x, y) do
  if (y ~= nil) then do
    return caml_equal(x, y);
  end else do
    return x == y;
  end end 
end end

function caml_equal_undefined(x, y) do
  if (y ~= undefined) then do
    return caml_equal(x, y);
  end else do
    return x == y;
  end end 
end end

function caml_equal_nullable(x, y) do
  if (y == nil) then do
    return x == y;
  end else do
    return caml_equal(x, y);
  end end 
end end

function caml_notequal(a, b) do
  return not caml_equal(a, b);
end end

function caml_greaterequal(a, b) do
  return caml_compare(a, b) >= 0;
end end

function caml_greaterthan(a, b) do
  return caml_compare(a, b) > 0;
end end

function caml_lessequal(a, b) do
  return caml_compare(a, b) <= 0;
end end

function caml_lessthan(a, b) do
  return caml_compare(a, b) < 0;
end end

function caml_min(x, y) do
  if (caml_compare(x, y) <= 0) then do
    return x;
  end else do
    return y;
  end end 
end end

function caml_max(x, y) do
  if (caml_compare(x, y) >= 0) then do
    return x;
  end else do
    return y;
  end end 
end end

function caml_obj_set_tag(prim, prim_1) do
  prim.tag = prim_1;
  return --[[ () ]]0;
end end

export do
  caml_obj_block ,
  caml_obj_dup ,
  caml_obj_truncate ,
  caml_lazy_make_forward ,
  caml_lazy_make ,
  caml_update_dummy ,
  caml_compare ,
  caml_equal ,
  caml_equal_null ,
  caml_equal_undefined ,
  caml_equal_nullable ,
  caml_notequal ,
  caml_greaterequal ,
  caml_greaterthan ,
  caml_lessthan ,
  caml_lessequal ,
  caml_min ,
  caml_max ,
  caml_obj_set_tag ,
  
end
--[[ No side effect ]]
