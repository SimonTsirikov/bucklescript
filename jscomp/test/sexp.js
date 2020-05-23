'use strict';

var List = require("../../lib/js/list.js");
var Curry = require("../../lib/js/curry.js");
var Hashtbl = require("../../lib/js/hashtbl.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_format = require("../../lib/js/caml_format.js");
var Caml_option = require("../../lib/js/caml_option.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var equal = Caml_obj.caml_equal;

var compare = Caml_obj.caml_compare;

var hash = Hashtbl.hash;

function of_int(x) do
  return --[ `Atom ]--[
          726615281,
          String(x)
        ];
end

function of_float(x) do
  return --[ `Atom ]--[
          726615281,
          Pervasives.string_of_float(x)
        ];
end

function of_bool(x) do
  return --[ `Atom ]--[
          726615281,
          x ? "true" : "false"
        ];
end

function atom(x) do
  return --[ `Atom ]--[
          726615281,
          x
        ];
end

function of_list(l) do
  return --[ `List ]--[
          848054398,
          l
        ];
end

function of_rev_list(l) do
  return --[ `List ]--[
          848054398,
          List.rev(l)
        ];
end

function of_pair(param) do
  return --[ `List ]--[
          848054398,
          --[ :: ]--[
            param[0],
            --[ :: ]--[
              param[1],
              --[ [] ]--0
            ]
          ]
        ];
end

function of_triple(param) do
  return --[ `List ]--[
          848054398,
          --[ :: ]--[
            param[0],
            --[ :: ]--[
              param[1],
              --[ :: ]--[
                param[2],
                --[ [] ]--0
              ]
            ]
          ]
        ];
end

function of_quad(param) do
  return --[ `List ]--[
          848054398,
          --[ :: ]--[
            param[0],
            --[ :: ]--[
              param[1],
              --[ :: ]--[
                param[2],
                --[ :: ]--[
                  param[3],
                  --[ [] ]--0
                ]
              ]
            ]
          ]
        ];
end

function of_variant(name, args) do
  return --[ `List ]--[
          848054398,
          --[ :: ]--[
            --[ `Atom ]--[
              726615281,
              name
            ],
            args
          ]
        ];
end

function of_field(name, t) do
  return --[ `List ]--[
          848054398,
          --[ :: ]--[
            --[ `Atom ]--[
              726615281,
              name
            ],
            --[ :: ]--[
              t,
              --[ [] ]--0
            ]
          ]
        ];
end

function of_record(l) do
  return --[ `List ]--[
          848054398,
          List.map((function (param) do
                  return of_field(param[0], param[1]);
                end), l)
        ];
end

function $$return(x) do
  return Caml_option.some(x);
end

function $great$pipe$eq(e, f) do
  if (e ~= undefined) do
    return Caml_option.some(Curry._1(f, Caml_option.valFromOption(e)));
  end
  
end

function $great$great$eq(e, f) do
  if (e ~= undefined) do
    return Curry._1(f, Caml_option.valFromOption(e));
  end
  
end

function map_opt(f, l) do
  var _acc = --[ [] ]--0;
  var _l = l;
  while(true) do
    var l$1 = _l;
    var acc = _acc;
    if (l$1) do
      var match = Curry._1(f, l$1[0]);
      if (match ~= undefined) do
        _l = l$1[1];
        _acc = --[ :: ]--[
          Caml_option.valFromOption(match),
          acc
        ];
        continue ;
      end else do
        return ;
      end
    end else do
      return List.rev(acc);
    end
  end;
end

function list_any(f, e) do
  if (e[0] >= 848054398) do
    var f$1 = f;
    var _l = e[1];
    while(true) do
      var l = _l;
      if (l) do
        var res = Curry._1(f$1, l[0]);
        if (res ~= undefined) do
          return res;
        end else do
          _l = l[1];
          continue ;
        end
      end else do
        return ;
      end
    end;
  end
  
end

function list_all(f, e) do
  if (e[0] >= 848054398) do
    var f$1 = f;
    var _acc = --[ [] ]--0;
    var _l = e[1];
    while(true) do
      var l = _l;
      var acc = _acc;
      if (l) do
        var tl = l[1];
        var match = Curry._1(f$1, l[0]);
        _l = tl;
        if (match ~= undefined) do
          _acc = --[ :: ]--[
            Caml_option.valFromOption(match),
            acc
          ];
          continue ;
        end else do
          continue ;
        end
      end else do
        return List.rev(acc);
      end
    end;
  end else do
    return --[ [] ]--0;
  end
end

function _try_atom(e, f) do
  if (e[0] >= 848054398) do
    return ;
  end else do
    try do
      return Caml_option.some(Curry._1(f, e[1]));
    end
    catch (exn)do
      return ;
    end
  end
end

function to_int(e) do
  return _try_atom(e, Caml_format.caml_int_of_string);
end

function to_bool(e) do
  return _try_atom(e, Pervasives.bool_of_string);
end

function to_float(e) do
  return _try_atom(e, Caml_format.caml_float_of_string);
end

function to_string(e) do
  return _try_atom(e, (function (x) do
                return x;
              end));
end

function to_pair(e) do
  if (typeof e == "number" or e[0] ~= 848054398) do
    return ;
  end else do
    var match = e[1];
    if (match) do
      var match$1 = match[1];
      if (match$1 and !match$1[1]) do
        return --[ tuple ]--[
                match[0],
                match$1[0]
              ];
      end else do
        return ;
      end
    end else do
      return ;
    end
  end
end

function to_pair_with(f1, f2, e) do
  return $great$great$eq(to_pair(e), (function (param) do
                var y = param[1];
                return $great$great$eq(Curry._1(f1, param[0]), (function (x) do
                              return $great$great$eq(Curry._1(f2, y), (function (y) do
                                            return --[ tuple ]--[
                                                    x,
                                                    y
                                                  ];
                                          end));
                            end));
              end));
end

function to_triple(e) do
  if (typeof e == "number" or e[0] ~= 848054398) do
    return ;
  end else do
    var match = e[1];
    if (match) do
      var match$1 = match[1];
      if (match$1) do
        var match$2 = match$1[1];
        if (match$2 and !match$2[1]) do
          return --[ tuple ]--[
                  match[0],
                  match$1[0],
                  match$2[0]
                ];
        end else do
          return ;
        end
      end else do
        return ;
      end
    end else do
      return ;
    end
  end
end

function to_triple_with(f1, f2, f3, e) do
  return $great$great$eq(to_triple(e), (function (param) do
                var z = param[2];
                var y = param[1];
                return $great$great$eq(Curry._1(f1, param[0]), (function (x) do
                              return $great$great$eq(Curry._1(f2, y), (function (y) do
                                            return $great$great$eq(Curry._1(f3, z), (function (z) do
                                                          return --[ tuple ]--[
                                                                  x,
                                                                  y,
                                                                  z
                                                                ];
                                                        end));
                                          end));
                            end));
              end));
end

function to_list(e) do
  if (e[0] >= 848054398) do
    return Caml_option.some(e[1]);
  end
  
end

function to_list_with(f, e) do
  if (e[0] >= 848054398) do
    return map_opt(f, e[1]);
  end
  
end

function get_field(name, e) do
  if (e[0] >= 848054398) do
    var name$1 = name;
    var _l = e[1];
    while(true) do
      var l = _l;
      if (l) do
        var match = l[0];
        if (typeof match == "number") do
          _l = l[1];
          continue ;
        end else if (match[0] ~= 848054398) do
          _l = l[1];
          continue ;
        end else do
          var match$1 = match[1];
          if (match$1) do
            var match$2 = match$1[0];
            if (typeof match$2 == "number") do
              _l = l[1];
              continue ;
            end else if (match$2[0] ~= 726615281) do
              _l = l[1];
              continue ;
            end else do
              var match$3 = match$1[1];
              if (match$3) do
                if (match$3[1]) do
                  _l = l[1];
                  continue ;
                end else if (Caml_obj.caml_equal(name$1, match$2[1])) do
                  return match$3[0];
                end else do
                  _l = l[1];
                  continue ;
                end
              end else do
                _l = l[1];
                continue ;
              end
            end
          end else do
            _l = l[1];
            continue ;
          end
        end
      end else do
        return ;
      end
    end;
  end
  
end

function field(name, f, e) do
  return $great$great$eq(get_field(name, e), f);
end

function _get_field_list(name, _l) do
  while(true) do
    var l = _l;
    if (l) do
      var match = l[0];
      if (typeof match == "number") do
        _l = l[1];
        continue ;
      end else if (match[0] ~= 848054398) do
        _l = l[1];
        continue ;
      end else do
        var match$1 = match[1];
        if (match$1) do
          var match$2 = match$1[0];
          if (typeof match$2 == "number") do
            _l = l[1];
            continue ;
          end else if (match$2[0] ~= 726615281) do
            _l = l[1];
            continue ;
          end else if (Caml_obj.caml_equal(name, match$2[1])) do
            return match$1[1];
          end else do
            _l = l[1];
            continue ;
          end
        end else do
          _l = l[1];
          continue ;
        end
      end
    end else do
      return ;
    end
  end;
end

function field_list(name, f, e) do
  if (e[0] >= 848054398) do
    return $great$great$eq(_get_field_list(name, e[1]), f);
  end
  
end

function _get_variant(s, args, _l) do
  while(true) do
    var l = _l;
    if (l) do
      var match = l[0];
      if (Caml_obj.caml_equal(s, match[0])) do
        return Curry._1(match[1], args);
      end else do
        _l = l[1];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function get_variant(l, e) do
  if (e[0] >= 848054398) do
    var match = e[1];
    if (match) do
      var match$1 = match[0];
      if (typeof match$1 == "number" or match$1[0] ~= 726615281) do
        return ;
      end else do
        return _get_variant(match$1[1], match[1], l);
      end
    end else do
      return ;
    end
  end else do
    return _get_variant(e[1], --[ [] ]--0, l);
  end
end

function get_exn(e) do
  if (e ~= undefined) do
    return Caml_option.valFromOption(e);
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "CCSexp.Traverse.get_exn"
        ];
  end
end

var of_unit = --[ `List ]--[
  848054398,
  --[ [] ]--0
];

var Traverse = do
  map_opt: map_opt,
  list_any: list_any,
  list_all: list_all,
  to_int: to_int,
  to_string: to_string,
  to_bool: to_bool,
  to_float: to_float,
  to_list: to_list,
  to_list_with: to_list_with,
  to_pair: to_pair,
  to_pair_with: to_pair_with,
  to_triple: to_triple,
  to_triple_with: to_triple_with,
  get_field: get_field,
  field: field,
  get_variant: get_variant,
  field_list: field_list,
  $great$great$eq: $great$great$eq,
  $great$pipe$eq: $great$pipe$eq,
  $$return: $$return,
  get_exn: get_exn
end;

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
--[ No side effect ]--
