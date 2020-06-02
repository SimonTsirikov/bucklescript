console = {log = print};

List = require "../../lib/js/list";
__Array = require "../../lib/js/array";
__String = require "../../lib/js/string";
Set_gen = require "./set_gen";
Caml_primitive = require "../../lib/js/caml_primitive";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function split(x, tree) do
  if (tree) then do
    r = tree[2];
    v = tree[1];
    l = tree[0];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[[ tuple ]]{
              l,
              true,
              r
            };
    end else if (c < 0) then do
      match = split(x, l);
      return --[[ tuple ]]{
              match[0],
              match[1],
              Set_gen.internal_join(match[2], v, r)
            };
    end else do
      match_1 = split(x, r);
      return --[[ tuple ]]{
              Set_gen.internal_join(l, v, match_1[0]),
              match_1[1],
              match_1[2]
            };
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            false,
            --[[ Empty ]]0
          };
  end end 
end end

function add(x, tree) do
  if (tree) then do
    r = tree[2];
    v = tree[1];
    l = tree[0];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return tree;
    end else if (c < 0) then do
      return Set_gen.internal_bal(add(x, l), v, r);
    end else do
      return Set_gen.internal_bal(l, v, add(x, r));
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ Empty ]]0,
            x,
            --[[ Empty ]]0,
            1
          };
  end end 
end end

function union(s1, s2) do
  if (s1) then do
    if (s2) then do
      h2 = s2[3];
      v2 = s2[1];
      h1 = s1[3];
      v1 = s1[1];
      if (h1 >= h2) then do
        if (h2 == 1) then do
          return add(v2, s1);
        end else do
          match = split(v1, s2);
          return Set_gen.internal_join(union(s1[0], match[0]), v1, union(s1[2], match[2]));
        end end 
      end else if (h1 == 1) then do
        return add(v1, s2);
      end else do
        match_1 = split(v2, s1);
        return Set_gen.internal_join(union(match_1[0], s2[0]), v2, union(match_1[2], s2[2]));
      end end  end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end end

function inter(s1, s2) do
  if (s1 and s2) then do
    r1 = s1[2];
    v1 = s1[1];
    l1 = s1[0];
    match = split(v1, s2);
    l2 = match[0];
    if (match[1]) then do
      return Set_gen.internal_join(inter(l1, l2), v1, inter(r1, match[2]));
    end else do
      return Set_gen.internal_concat(inter(l1, l2), inter(r1, match[2]));
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function diff(s1, s2) do
  if (s1) then do
    if (s2) then do
      r1 = s1[2];
      v1 = s1[1];
      l1 = s1[0];
      match = split(v1, s2);
      l2 = match[0];
      if (match[1]) then do
        return Set_gen.internal_concat(diff(l1, l2), diff(r1, match[2]));
      end else do
        return Set_gen.internal_join(diff(l1, l2), v1, diff(r1, match[2]));
      end end 
    end else do
      return s1;
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function mem(x, _tree) do
  while(true) do
    tree = _tree;
    if (tree) then do
      c = Caml_primitive.caml_string_compare(x, tree[1]);
      if (c == 0) then do
        return true;
      end else do
        _tree = c < 0 and tree[0] or tree[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function remove(x, tree) do
  if (tree) then do
    r = tree[2];
    v = tree[1];
    l = tree[0];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return Set_gen.internal_merge(l, r);
    end else if (c < 0) then do
      return Set_gen.internal_bal(remove(x, l), v, r);
    end else do
      return Set_gen.internal_bal(l, v, remove(x, r));
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function compare(s1, s2) do
  return Set_gen.compare(__String.compare, s1, s2);
end end

function equal(s1, s2) do
  return Set_gen.compare(__String.compare, s1, s2) == 0;
end end

function subset(_s1, _s2) do
  while(true) do
    s2 = _s2;
    s1 = _s1;
    if (s1) then do
      if (s2) then do
        r2 = s2[2];
        l2 = s2[0];
        r1 = s1[2];
        v1 = s1[1];
        l1 = s1[0];
        c = Caml_primitive.caml_string_compare(v1, s2[1]);
        if (c == 0) then do
          if (subset(l1, l2)) then do
            _s2 = r2;
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (c < 0) then do
          if (subset(--[[ Node ]]{
                  l1,
                  v1,
                  --[[ Empty ]]0,
                  0
                }, l2)) then do
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (subset(--[[ Node ]]{
                --[[ Empty ]]0,
                v1,
                r1,
                0
              }, r2)) then do
          _s1 = l1;
          ::continue:: ;
        end else do
          return false;
        end end  end  end 
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function find(x, _tree) do
  while(true) do
    tree = _tree;
    if (tree) then do
      v = tree[1];
      c = Caml_primitive.caml_string_compare(x, v);
      if (c == 0) then do
        return v;
      end else do
        _tree = c < 0 and tree[0] or tree[2];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function of_list(l) do
  if (l) then do
    match = l[1];
    x0 = l[0];
    if (match) then do
      match_1 = match[1];
      x1 = match[0];
      if (match_1) then do
        match_2 = match_1[1];
        x2 = match_1[0];
        if (match_2) then do
          match_3 = match_2[1];
          x3 = match_2[0];
          if (match_3) then do
            if (match_3[1]) then do
              return Set_gen.of_sorted_list(List.sort_uniq(__String.compare, l));
            end else do
              return add(match_3[0], add(x3, add(x2, add(x1, Set_gen.singleton(x0)))));
            end end 
          end else do
            return add(x3, add(x2, add(x1, Set_gen.singleton(x0))));
          end end 
        end else do
          return add(x2, add(x1, Set_gen.singleton(x0)));
        end end 
      end else do
        return add(x1, Set_gen.singleton(x0));
      end end 
    end else do
      return Set_gen.singleton(x0);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function of_array(l) do
  return __Array.fold_left((function(acc, x) do
                return add(x, acc);
              end end), --[[ Empty ]]0, l);
end end

function invariant(t) do
  Set_gen.check(t);
  return Set_gen.is_ordered(__String.compare, t);
end end

compare_elt = __String.compare;

empty = --[[ Empty ]]0;

is_empty = Set_gen.is_empty;

iter = Set_gen.iter;

fold = Set_gen.fold;

for_all = Set_gen.for_all;

exists = Set_gen.exists;

singleton = Set_gen.singleton;

cardinal = Set_gen.cardinal;

elements = Set_gen.elements;

min_elt = Set_gen.min_elt;

max_elt = Set_gen.max_elt;

choose = Set_gen.choose;

partition = Set_gen.partition;

filter = Set_gen.filter;

of_sorted_list = Set_gen.of_sorted_list;

of_sorted_array = Set_gen.of_sorted_array;

exports = {}
exports.compare_elt = compare_elt;
exports.empty = empty;
exports.is_empty = is_empty;
exports.iter = iter;
exports.fold = fold;
exports.for_all = for_all;
exports.exists = exists;
exports.singleton = singleton;
exports.cardinal = cardinal;
exports.elements = elements;
exports.min_elt = min_elt;
exports.max_elt = max_elt;
exports.choose = choose;
exports.partition = partition;
exports.filter = filter;
exports.of_sorted_list = of_sorted_list;
exports.of_sorted_array = of_sorted_array;
exports.split = split;
exports.add = add;
exports.union = union;
exports.inter = inter;
exports.diff = diff;
exports.mem = mem;
exports.remove = remove;
exports.compare = compare;
exports.equal = equal;
exports.subset = subset;
exports.find = find;
exports.of_list = of_list;
exports.of_array = of_array;
exports.invariant = invariant;
--[[ No side effect ]]
