console = {log = print};

List = require "../../lib/js/list";
Curry = require "../../lib/js/curry";
Hashtbl = require "../../lib/js/hashtbl";
Caml_obj = require "../../lib/js/caml_obj";
Pervasives = require "../../lib/js/pervasives";
Caml_format = require "../../lib/js/caml_format";
Caml_option = require "../../lib/js/caml_option";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

equal = Caml_obj.caml_equal;

compare = Caml_obj.caml_compare;

hash = Hashtbl.hash;

function of_int(x) do
  return --[[ `Atom ]]{
          726615281,
          String(x)
        };
end end

function of_float(x) do
  return --[[ `Atom ]]{
          726615281,
          Pervasives.string_of_float(x)
        };
end end

function of_bool(x) do
  return --[[ `Atom ]]{
          726615281,
          x and "true" or "false"
        };
end end

function atom(x) do
  return --[[ `Atom ]]{
          726615281,
          x
        };
end end

function of_list(l) do
  return --[[ `List ]]{
          848054398,
          l
        };
end end

function of_rev_list(l) do
  return --[[ `List ]]{
          848054398,
          List.rev(l)
        };
end end

function of_pair(param) do
  return --[[ `List ]]{
          848054398,
          --[[ :: ]]{
            param[0],
            --[[ :: ]]{
              param[1],
              --[[ [] ]]0
            }
          }
        };
end end

function of_triple(param) do
  return --[[ `List ]]{
          848054398,
          --[[ :: ]]{
            param[0],
            --[[ :: ]]{
              param[1],
              --[[ :: ]]{
                param[2],
                --[[ [] ]]0
              }
            }
          }
        };
end end

function of_quad(param) do
  return --[[ `List ]]{
          848054398,
          --[[ :: ]]{
            param[0],
            --[[ :: ]]{
              param[1],
              --[[ :: ]]{
                param[2],
                --[[ :: ]]{
                  param[3],
                  --[[ [] ]]0
                }
              }
            }
          }
        };
end end

function of_variant(name, args) do
  return --[[ `List ]]{
          848054398,
          --[[ :: ]]{
            --[[ `Atom ]]{
              726615281,
              name
            },
            args
          }
        };
end end

function of_field(name, t) do
  return --[[ `List ]]{
          848054398,
          --[[ :: ]]{
            --[[ `Atom ]]{
              726615281,
              name
            },
            --[[ :: ]]{
              t,
              --[[ [] ]]0
            }
          }
        };
end end

function of_record(l) do
  return --[[ `List ]]{
          848054398,
          List.map((function(param) do
                  return of_field(param[0], param[1]);
                end end), l)
        };
end end

function __return(x) do
  return Caml_option.some(x);
end end

function $great$pipe$eq(e, f) do
  if (e ~= nil) then do
    return Caml_option.some(Curry._1(f, Caml_option.valFromOption(e)));
  end
   end 
end end

function $great$great$eq(e, f) do
  if (e ~= nil) then do
    return Curry._1(f, Caml_option.valFromOption(e));
  end
   end 
end end

function map_opt(f, l) do
  _acc = --[[ [] ]]0;
  _l = l;
  while(true) do
    l_1 = _l;
    acc = _acc;
    if (l_1) then do
      match = Curry._1(f, l_1[0]);
      if (match ~= nil) then do
        _l = l_1[1];
        _acc = --[[ :: ]]{
          Caml_option.valFromOption(match),
          acc
        };
        ::continue:: ;
      end else do
        return ;
      end end 
    end else do
      return List.rev(acc);
    end end 
  end;
end end

function list_any(f, e) do
  if (e[0] >= 848054398) then do
    f_1 = f;
    _l = e[1];
    while(true) do
      l = _l;
      if (l) then do
        res = Curry._1(f_1, l[0]);
        if (res ~= nil) then do
          return res;
        end else do
          _l = l[1];
          ::continue:: ;
        end end 
      end else do
        return ;
      end end 
    end;
  end
   end 
end end

function list_all(f, e) do
  if (e[0] >= 848054398) then do
    f_1 = f;
    _acc = --[[ [] ]]0;
    _l = e[1];
    while(true) do
      l = _l;
      acc = _acc;
      if (l) then do
        tl = l[1];
        match = Curry._1(f_1, l[0]);
        _l = tl;
        if (match ~= nil) then do
          _acc = --[[ :: ]]{
            Caml_option.valFromOption(match),
            acc
          };
          ::continue:: ;
        end else do
          ::continue:: ;
        end end 
      end else do
        return List.rev(acc);
      end end 
    end;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function _try_atom(e, f) do
  if (e[0] >= 848054398) then do
    return ;
  end else do
    xpcall(function() do
      return Caml_option.some(Curry._1(f, e[1]));
    end end,function(exn) do
      return ;
    end end)
  end end 
end end

function to_int(e) do
  return _try_atom(e, Caml_format.caml_int_of_string);
end end

function to_bool(e) do
  return _try_atom(e, Pervasives.bool_of_string);
end end

function to_float(e) do
  return _try_atom(e, Caml_format.caml_float_of_string);
end end

function to_string(e) do
  return _try_atom(e, (function(x) do
                return x;
              end end));
end end

function to_pair(e) do
  if (typeof e == "number" or e[0] ~= 848054398) then do
    return ;
  end else do
    match = e[1];
    if (match) then do
      match_1 = match[1];
      if (match_1 and not match_1[1]) then do
        return --[[ tuple ]]{
                match[0],
                match_1[0]
              };
      end else do
        return ;
      end end 
    end else do
      return ;
    end end 
  end end 
end end

function to_pair_with(f1, f2, e) do
  return $great$great$eq(to_pair(e), (function(param) do
                y = param[1];
                return $great$great$eq(Curry._1(f1, param[0]), (function(x) do
                              return $great$great$eq(Curry._1(f2, y), (function(y) do
                                            return --[[ tuple ]]{
                                                    x,
                                                    y
                                                  };
                                          end end));
                            end end));
              end end));
end end

function to_triple(e) do
  if (typeof e == "number" or e[0] ~= 848054398) then do
    return ;
  end else do
    match = e[1];
    if (match) then do
      match_1 = match[1];
      if (match_1) then do
        match_2 = match_1[1];
        if (match_2 and not match_2[1]) then do
          return --[[ tuple ]]{
                  match[0],
                  match_1[0],
                  match_2[0]
                };
        end else do
          return ;
        end end 
      end else do
        return ;
      end end 
    end else do
      return ;
    end end 
  end end 
end end

function to_triple_with(f1, f2, f3, e) do
  return $great$great$eq(to_triple(e), (function(param) do
                z = param[2];
                y = param[1];
                return $great$great$eq(Curry._1(f1, param[0]), (function(x) do
                              return $great$great$eq(Curry._1(f2, y), (function(y) do
                                            return $great$great$eq(Curry._1(f3, z), (function(z) do
                                                          return --[[ tuple ]]{
                                                                  x,
                                                                  y,
                                                                  z
                                                                };
                                                        end end));
                                          end end));
                            end end));
              end end));
end end

function to_list(e) do
  if (e[0] >= 848054398) then do
    return Caml_option.some(e[1]);
  end
   end 
end end

function to_list_with(f, e) do
  if (e[0] >= 848054398) then do
    return map_opt(f, e[1]);
  end
   end 
end end

function get_field(name, e) do
  if (e[0] >= 848054398) then do
    name_1 = name;
    _l = e[1];
    while(true) do
      l = _l;
      if (l) then do
        match = l[0];
        if (typeof match == "number") then do
          _l = l[1];
          ::continue:: ;
        end else if (match[0] ~= 848054398) then do
          _l = l[1];
          ::continue:: ;
        end else do
          match_1 = match[1];
          if (match_1) then do
            match_2 = match_1[0];
            if (typeof match_2 == "number") then do
              _l = l[1];
              ::continue:: ;
            end else if (match_2[0] ~= 726615281) then do
              _l = l[1];
              ::continue:: ;
            end else do
              match_3 = match_1[1];
              if (match_3) then do
                if (match_3[1]) then do
                  _l = l[1];
                  ::continue:: ;
                end else if (Caml_obj.caml_equal(name_1, match_2[1])) then do
                  return match_3[0];
                end else do
                  _l = l[1];
                  ::continue:: ;
                end end  end 
              end else do
                _l = l[1];
                ::continue:: ;
              end end 
            end end  end 
          end else do
            _l = l[1];
            ::continue:: ;
          end end 
        end end  end 
      end else do
        return ;
      end end 
    end;
  end
   end 
end end

function field(name, f, e) do
  return $great$great$eq(get_field(name, e), f);
end end

function _get_field_list(name, _l) do
  while(true) do
    l = _l;
    if (l) then do
      match = l[0];
      if (typeof match == "number") then do
        _l = l[1];
        ::continue:: ;
      end else if (match[0] ~= 848054398) then do
        _l = l[1];
        ::continue:: ;
      end else do
        match_1 = match[1];
        if (match_1) then do
          match_2 = match_1[0];
          if (typeof match_2 == "number") then do
            _l = l[1];
            ::continue:: ;
          end else if (match_2[0] ~= 726615281) then do
            _l = l[1];
            ::continue:: ;
          end else if (Caml_obj.caml_equal(name, match_2[1])) then do
            return match_1[1];
          end else do
            _l = l[1];
            ::continue:: ;
          end end  end  end 
        end else do
          _l = l[1];
          ::continue:: ;
        end end 
      end end  end 
    end else do
      return ;
    end end 
  end;
end end

function field_list(name, f, e) do
  if (e[0] >= 848054398) then do
    return $great$great$eq(_get_field_list(name, e[1]), f);
  end
   end 
end end

function _get_variant(s, args, _l) do
  while(true) do
    l = _l;
    if (l) then do
      match = l[0];
      if (Caml_obj.caml_equal(s, match[0])) then do
        return Curry._1(match[1], args);
      end else do
        _l = l[1];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function get_variant(l, e) do
  if (e[0] >= 848054398) then do
    match = e[1];
    if (match) then do
      match_1 = match[0];
      if (typeof match_1 == "number" or match_1[0] ~= 726615281) then do
        return ;
      end else do
        return _get_variant(match_1[1], match[1], l);
      end end 
    end else do
      return ;
    end end 
  end else do
    return _get_variant(e[1], --[[ [] ]]0, l);
  end end 
end end

function get_exn(e) do
  if (e ~= nil) then do
    return Caml_option.valFromOption(e);
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "CCSexp.Traverse.get_exn"
    })
  end end 
end end

of_unit = --[[ `List ]]{
  848054398,
  --[[ [] ]]0
};

Traverse = {
  map_opt = map_opt,
  list_any = list_any,
  list_all = list_all,
  to_int = to_int,
  to_string = to_string,
  to_bool = to_bool,
  to_float = to_float,
  to_list = to_list,
  to_list_with = to_list_with,
  to_pair = to_pair,
  to_pair_with = to_pair_with,
  to_triple = to_triple,
  to_triple_with = to_triple_with,
  get_field = get_field,
  field = field,
  get_variant = get_variant,
  field_list = field_list,
  $great$great$eq = $great$great$eq,
  $great$pipe$eq = $great$pipe$eq,
  __return = __return,
  get_exn = get_exn
};

exports = {}
exports.equal = equal;
exports.compare = compare;
exports.hash = hash;
exports.atom = atom;
exports.of_int = of_int;
exports.of_bool = of_bool;
exports.of_list = of_list;
exports.of_rev_list = of_rev_list;
exports.of_float = of_float;
exports.of_unit = of_unit;
exports.of_pair = of_pair;
exports.of_triple = of_triple;
exports.of_quad = of_quad;
exports.of_variant = of_variant;
exports.of_field = of_field;
exports.of_record = of_record;
exports.Traverse = Traverse;
--[[ No side effect ]]
