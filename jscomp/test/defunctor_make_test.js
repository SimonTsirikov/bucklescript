'use strict';

var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function getcompare(x) do
  return x;
end

function Make(M) do
  return M;
end

var Comparable = do
  getcompare: getcompare,
  Make: Make
end;

function height(param) do
  if (param) then do
    return param[4];
  end else do
    return 0;
  end end 
end

function create(l, x, d, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end

function bal(l, x, d, r) do
  var hl = l and l[4] or 0;
  var hr = r and r[4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      var lr = l[3];
      var ld = l[2];
      var lv = l[1];
      var ll = l[0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[0]), lr[1], lr[2], create(lr[3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      var rr = r[3];
      var rd = r[2];
      var rv = r[1];
      var rl = r[0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[0]), rl[1], rl[2], create(rl[3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[ Node ]--[
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end

function add(x, data, compare, param) do
  if (param) then do
    var r = param[3];
    var d = param[2];
    var v = param[1];
    var l = param[0];
    var c = compare(x, v);
    if (c == 0) then do
      return --[ Node ]--[
              l,
              x,
              data,
              r,
              param[4]
            ];
    end else if (c < 0) then do
      return bal(add(x, data, compare, l), v, d, r);
    end else do
      return bal(l, v, d, add(x, data, compare, r));
    end end  end 
  end else do
    return --[ Node ]--[
            --[ Empty ]--0,
            x,
            data,
            --[ Empty ]--0,
            1
          ];
  end end 
end

function add$1(x, data, v) do
  var X = v.compare;
  return do
          compare: v.compare,
          data: add(x, data, X.compare, v.data)
        end;
end

function empty(v) do
  return do
          compare: v,
          data: --[ Empty ]--0
        end;
end

var compare = Caml_primitive.caml_int_compare;

var V0 = do
  compare: compare
end;

var compare$1 = Caml_primitive.caml_int_compare;

var V1 = do
  compare: compare$1
end;

var v0 = do
  compare: V0,
  data: --[ Empty ]--0
end;

var v1 = do
  compare: V1,
  data: --[ Empty ]--0
end;

var v3 = add$1(3, "a", v0);

console.log(v3);

exports.Comparable = Comparable;
exports.height = height;
exports.create = create;
exports.bal = bal;
exports.add = add$1;
exports.empty = empty;
exports.V0 = V0;
exports.V1 = V1;
exports.v0 = v0;
exports.v1 = v1;
exports.v3 = v3;
--[ v3 Not a pure module ]--
