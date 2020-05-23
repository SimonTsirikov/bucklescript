'use strict';

var Block = require("./block.js");
var Caml_primitive = require("./caml_primitive.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

var for_in = (function(o,foo){
        for (var x in o) { foo(x) }});

function caml_obj_block(tag, size) do
  var v = new Array(size);
  v.tag = tag;
  return v;
end

function caml_obj_dup(x) do
  if (Array.isArray(x)) do
    var len = #x | 0;
    var v = new Array(len);
    for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
      v[i] = x[i];
    end
    v.tag = x.tag | 0;
    return v;
  end else do
    return Object.assign(({}), x);
  end
end

function caml_obj_truncate(x, new_size) do
  var len = #x | 0;
  if (new_size <= 0 or new_size > len) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Obj.truncate"
        ];
  end
  if (len ~= new_size) do
    for(var i = new_size ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
      x[i] = 0;
    end
    x.length = new_size;
    return --[ () ]--0;
  end else do
    return 0;
  end
end

function caml_lazy_make_forward(x) do
  return Block.__(250, [x]);
end

function caml_lazy_make(fn) do
  var block = [fn];
  block.tag = 246;
  return block;
end

var caml_update_dummy = (function(x,y){
  for (var k in y){
    x[k] = y[k]
  }
  return 0;
  });

function caml_compare(_a, _b) do
  while(true) do
    var b = _b;
    var a = _a;
    if (a == b) do
      return 0;
    end else do
      var a_type = typeof a;
      var b_type = typeof b;
      switch (a_type) do
        case "boolean" :
            if (b_type == "boolean") do
              return Caml_primitive.caml_bool_compare(a, b);
            end
            break;
        case "function" :
            if (b_type == "function") do
              throw [
                    Caml_builtin_exceptions.invalid_argument,
                    "compare: functional value"
                  ];
            end
            break;
        case "number" :
            if (b_type == "number") do
              return Caml_primitive.caml_int_compare(a, b);
            end
            break;
        case "string" :
            if (b_type == "string") do
              return Caml_primitive.caml_string_compare(a, b);
            end else do
              return 1;
            end
        case "undefined" :
            return -1;
        default:
          
      end
      switch (b_type) do
        case "string" :
            return -1;
        case "undefined" :
            return 1;
        default:
          if (a_type == "boolean") do
            return 1;
          end else if (b_type == "boolean") do
            return -1;
          end else if (a_type == "function") do
            return 1;
          end else if (b_type == "function") do
            return -1;
          end else if (a_type == "number") do
            if (b == null or b.tag == 256) do
              return 1;
            end else do
              return -1;
            end
          end else if (b_type == "number") do
            if (a == null or a.tag == 256) do
              return -1;
            end else do
              return 1;
            end
          end else if (a == null) do
            if (b.tag == 256) do
              return 1;
            end else do
              return -1;
            end
          end else if (b == null) do
            if (a.tag == 256) do
              return -1;
            end else do
              return 1;
            end
          end else do
            var tag_a = a.tag | 0;
            var tag_b = b.tag | 0;
            if (tag_a == 250) do
              _a = a[0];
              continue ;
            end else if (tag_b == 250) do
              _b = b[0];
              continue ;
            end else if (tag_a == 256) do
              if (tag_b == 256) do
                return Caml_primitive.caml_int_compare(a[1], b[1]);
              end else do
                return -1;
              end
            end else if (tag_a == 248) do
              return Caml_primitive.caml_int_compare(a[1], b[1]);
            end else do
              if (tag_a == 251) do
                throw [
                      Caml_builtin_exceptions.invalid_argument,
                      "equal: abstract value"
                    ];
              end
              if (tag_a ~= tag_b) do
                if (tag_a < tag_b) do
                  return -1;
                end else do
                  return 1;
                end
              end else do
                var len_a = #a | 0;
                var len_b = #b | 0;
                if (len_a == len_b) do
                  if (Array.isArray(a)) do
                    var a$1 = a;
                    var b$1 = b;
                    var _i = 0;
                    var same_length = len_a;
                    while(true) do
                      var i = _i;
                      if (i == same_length) do
                        return 0;
                      end else do
                        var res = caml_compare(a$1[i], b$1[i]);
                        if (res ~= 0) do
                          return res;
                        end else do
                          _i = i + 1 | 0;
                          continue ;
                        end
                      end
                    end;
                  end else if ((a instanceof Date && b instanceof Date)) do
                    return (a - b);
                  end else do
                    var a$2 = a;
                    var b$2 = b;
                    var min_key_lhs = do
                      contents: undefined
                    end;
                    var min_key_rhs = do
                      contents: undefined
                    end;
                    var do_key = function (param, key) do
                      var min_key = param[2];
                      var b = param[1];
                      if (!b.hasOwnProperty(key) or caml_compare(param[0][key], b[key]) > 0) do
                        var match = min_key.contents;
                        if (match ~= undefined and key >= match) do
                          return 0;
                        end else do
                          min_key.contents = key;
                          return --[ () ]--0;
                        end
                      end else do
                        return 0;
                      end
                    end;
                    var partial_arg = --[ tuple ]--[
                      a$2,
                      b$2,
                      min_key_rhs
                    ];
                    var do_key_a = (function(partial_arg)do
                    return function do_key_a(param) do
                      return do_key(partial_arg, param);
                    end
                    end(partial_arg));
                    var partial_arg$1 = --[ tuple ]--[
                      b$2,
                      a$2,
                      min_key_lhs
                    ];
                    var do_key_b = (function(partial_arg$1)do
                    return function do_key_b(param) do
                      return do_key(partial_arg$1, param);
                    end
                    end(partial_arg$1));
                    for_in(a$2, do_key_a);
                    for_in(b$2, do_key_b);
                    var match = min_key_lhs.contents;
                    var match$1 = min_key_rhs.contents;
                    if (match ~= undefined) do
                      if (match$1 ~= undefined) do
                        return Caml_primitive.caml_string_compare(match, match$1);
                      end else do
                        return -1;
                      end
                    end else if (match$1 ~= undefined) do
                      return 1;
                    end else do
                      return 0;
                    end
                  end
                end else if (len_a < len_b) do
                  var a$3 = a;
                  var b$3 = b;
                  var _i$1 = 0;
                  var short_length = len_a;
                  while(true) do
                    var i$1 = _i$1;
                    if (i$1 == short_length) do
                      return -1;
                    end else do
                      var res$1 = caml_compare(a$3[i$1], b$3[i$1]);
                      if (res$1 ~= 0) do
                        return res$1;
                      end else do
                        _i$1 = i$1 + 1 | 0;
                        continue ;
                      end
                    end
                  end;
                end else do
                  var a$4 = a;
                  var b$4 = b;
                  var _i$2 = 0;
                  var short_length$1 = len_b;
                  while(true) do
                    var i$2 = _i$2;
                    if (i$2 == short_length$1) do
                      return 1;
                    end else do
                      var res$2 = caml_compare(a$4[i$2], b$4[i$2]);
                      if (res$2 ~= 0) do
                        return res$2;
                      end else do
                        _i$2 = i$2 + 1 | 0;
                        continue ;
                      end
                    end
                  end;
                end
              end
            end
          end
      end
    end
  end;
end

function caml_equal(_a, _b) do
  while(true) do
    var b = _b;
    var a = _a;
    if (a == b) do
      return true;
    end else do
      var a_type = typeof a;
      if (a_type == "string" or a_type == "number" or a_type == "boolean" or a_type == "undefined" or a == null) do
        return false;
      end else do
        var b_type = typeof b;
        if (a_type == "function" or b_type == "function") do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "equal: functional value"
              ];
        end
        if (b_type == "number" or b_type == "undefined" or b == null) do
          return false;
        end else do
          var tag_a = a.tag | 0;
          var tag_b = b.tag | 0;
          if (tag_a == 250) do
            _a = a[0];
            continue ;
          end else if (tag_b == 250) do
            _b = b[0];
            continue ;
          end else if (tag_a == 248) do
            return a[1] == b[1];
          end else do
            if (tag_a == 251) do
              throw [
                    Caml_builtin_exceptions.invalid_argument,
                    "equal: abstract value"
                  ];
            end
            if (tag_a ~= tag_b) do
              return false;
            end else if (tag_a == 256) do
              return a[1] == b[1];
            end else do
              var len_a = #a | 0;
              var len_b = #b | 0;
              if (len_a == len_b) do
                if (Array.isArray(a)) do
                  var a$1 = a;
                  var b$1 = b;
                  var _i = 0;
                  var same_length = len_a;
                  while(true) do
                    var i = _i;
                    if (i == same_length) do
                      return true;
                    end else if (caml_equal(a$1[i], b$1[i])) do
                      _i = i + 1 | 0;
                      continue ;
                    end else do
                      return false;
                    end
                  end;
                end else if ((a instanceof Date && b instanceof Date)) do
                  return !(a > b or a < b);
                end else do
                  var a$2 = a;
                  var b$2 = b;
                  var result = do
                    contents: true
                  end;
                  var do_key_a = (function(b$2,result)do
                  return function do_key_a(key) do
                    if (b$2.hasOwnProperty(key)) do
                      return 0;
                    end else do
                      result.contents = false;
                      return --[ () ]--0;
                    end
                  end
                  end(b$2,result));
                  var do_key_b = (function(a$2,b$2,result)do
                  return function do_key_b(key) do
                    if (!a$2.hasOwnProperty(key) or !caml_equal(b$2[key], a$2[key])) do
                      result.contents = false;
                      return --[ () ]--0;
                    end else do
                      return 0;
                    end
                  end
                  end(a$2,b$2,result));
                  for_in(a$2, do_key_a);
                  if (result.contents) do
                    for_in(b$2, do_key_b);
                  end
                  return result.contents;
                end
              end else do
                return false;
              end
            end
          end
        end
      end
    end
  end;
end

function caml_equal_null(x, y) do
  if (y ~= null) do
    return caml_equal(x, y);
  end else do
    return x == y;
  end
end

function caml_equal_undefined(x, y) do
  if (y ~= undefined) do
    return caml_equal(x, y);
  end else do
    return x == y;
  end
end

function caml_equal_nullable(x, y) do
  if (y == null) do
    return x == y;
  end else do
    return caml_equal(x, y);
  end
end

function caml_notequal(a, b) do
  return !caml_equal(a, b);
end

function caml_greaterequal(a, b) do
  return caml_compare(a, b) >= 0;
end

function caml_greaterthan(a, b) do
  return caml_compare(a, b) > 0;
end

function caml_lessequal(a, b) do
  return caml_compare(a, b) <= 0;
end

function caml_lessthan(a, b) do
  return caml_compare(a, b) < 0;
end

function caml_min(x, y) do
  if (caml_compare(x, y) <= 0) do
    return x;
  end else do
    return y;
  end
end

function caml_max(x, y) do
  if (caml_compare(x, y) >= 0) do
    return x;
  end else do
    return y;
  end
end

function caml_obj_set_tag(prim, prim$1) do
  prim.tag = prim$1;
  return --[ () ]--0;
end

exports.caml_obj_block = caml_obj_block;
exports.caml_obj_dup = caml_obj_dup;
exports.caml_obj_truncate = caml_obj_truncate;
exports.caml_lazy_make_forward = caml_lazy_make_forward;
exports.caml_lazy_make = caml_lazy_make;
exports.caml_update_dummy = caml_update_dummy;
exports.caml_compare = caml_compare;
exports.caml_equal = caml_equal;
exports.caml_equal_null = caml_equal_null;
exports.caml_equal_undefined = caml_equal_undefined;
exports.caml_equal_nullable = caml_equal_nullable;
exports.caml_notequal = caml_notequal;
exports.caml_greaterequal = caml_greaterequal;
exports.caml_greaterthan = caml_greaterthan;
exports.caml_lessthan = caml_lessthan;
exports.caml_lessequal = caml_lessequal;
exports.caml_min = caml_min;
exports.caml_max = caml_max;
exports.caml_obj_set_tag = caml_obj_set_tag;
--[ No side effect ]--
