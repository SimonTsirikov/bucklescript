__console = {log = print};

Caml_primitive = require "......lib.js.caml_primitive";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function getcompare(x) do
  return x;
end end

function Make(M) do
  return M;
end end

Comparable = {
  getcompare = getcompare,
  Make = Make
};

function height(param) do
  if (param) then do
    return param[5];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]]{
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal(l, x, d, r) do
  hl = l and l[5] or 0;
  hr = r and r[5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[4];
      ld = l[3];
      lv = l[2];
      ll = l[1];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[1]), lr[2], lr[3], create(lr[4], x, d, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[4];
      rd = r[3];
      rv = r[2];
      rl = r[1];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[1]), rl[2], rl[3], create(rl[4], rv, rd, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add(x, data, compare, param) do
  if (param) then do
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = compare(x, v);
    if (c == 0) then do
      return --[[ Node ]]{
              l,
              x,
              data,
              r,
              param[5]
            };
    end else if (c < 0) then do
      return bal(add(x, data, compare, l), v, d, r);
    end else do
      return bal(l, v, d, add(x, data, compare, r));
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ Empty ]]0,
            x,
            data,
            --[[ Empty ]]0,
            1
          };
  end end 
end end

function add_1(x, data, v) do
  X = v.compare;
  return {
          compare = v.compare,
          data = add(x, data, X.compare, v.data)
        };
end end

function empty(v) do
  return {
          compare = v,
          data = --[[ Empty ]]0
        };
end end

compare = Caml_primitive.caml_int_compare;

V0 = {
  compare = compare
};

compare_1 = Caml_primitive.caml_int_compare;

V1 = {
  compare = compare_1
};

v0 = {
  compare = V0,
  data = --[[ Empty ]]0
};

v1 = {
  compare = V1,
  data = --[[ Empty ]]0
};

v3 = add_1(3, "a", v0);

__console.log(v3);

exports = {};
exports.Comparable = Comparable;
exports.height = height;
exports.create = create;
exports.bal = bal;
exports.add = add_1;
exports.empty = empty;
exports.V0 = V0;
exports.V1 = V1;
exports.v0 = v0;
exports.v1 = v1;
exports.v3 = v3;
return exports;
--[[ v3 Not a pure module ]]
