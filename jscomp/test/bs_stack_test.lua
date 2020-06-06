console = {log = print};

Caml_option = require "../../lib/js/caml_option";
Js_undefined = require "../../lib/js/js_undefined";
Belt_MutableQueue = require "../../lib/js/belt_MutableQueue";
Belt_MutableStack = require "../../lib/js/belt_MutableStack";

function inOrder(v) do
  current = v;
  s = {
    root = nil
  };
  q = Belt_MutableQueue.make(--[[ () ]]0);
  while(current ~= undefined) do
    v_1 = current;
    Belt_MutableStack.push(s, v_1);
    current = v_1.left;
  end;
  while(s.root ~= nil) do
    current = Belt_MutableStack.popUndefined(s);
    v_2 = current;
    Belt_MutableQueue.add(q, v_2.value);
    current = v_2.right;
    while(current ~= undefined) do
      v_3 = current;
      Belt_MutableStack.push(s, v_3);
      current = v_3.left;
    end;
  end;
  return Belt_MutableQueue.toArray(q);
end end

function inOrder3(v) do
  current = v;
  s = {
    root = nil
  };
  q = Belt_MutableQueue.make(--[[ () ]]0);
  while(current ~= undefined) do
    v_1 = current;
    Belt_MutableStack.push(s, v_1);
    current = v_1.left;
  end;
  Belt_MutableStack.dynamicPopIter(s, (function(popped) do
          Belt_MutableQueue.add(q, popped.value);
          current = popped.right;
          while(current ~= undefined) do
            v = current;
            Belt_MutableStack.push(s, v);
            current = v.left;
          end;
          return --[[ () ]]0;
        end end));
  return Belt_MutableQueue.toArray(q);
end end

function inOrder2(v) do
  todo = true;
  cursor = v;
  s = {
    root = nil
  };
  q = Belt_MutableQueue.make(--[[ () ]]0);
  while(todo) do
    if (cursor ~= undefined) then do
      v_1 = cursor;
      Belt_MutableStack.push(s, v_1);
      cursor = v_1.left;
    end else if (s.root ~= nil) then do
      cursor = Belt_MutableStack.popUndefined(s);
      current = cursor;
      Belt_MutableQueue.add(q, current.value);
      cursor = current.right;
    end else do
      todo = false;
    end end  end 
  end;
  return --[[ () ]]0;
end end

function n(l, r, a) do
  return {
          value = a,
          left = Js_undefined.fromOption(l),
          right = Js_undefined.fromOption(r)
        };
end end

test1 = n(Caml_option.some(n(Caml_option.some(n(undefined, undefined, 4)), Caml_option.some(n(undefined, undefined, 5)), 2)), Caml_option.some(n(undefined, undefined, 3)), 1);

function pushAllLeft(st1, s1) do
  current = st1;
  while(current ~= undefined) do
    v = current;
    Belt_MutableStack.push(s1, v);
    current = v.left;
  end;
  return --[[ () ]]0;
end end

test2 = n(Caml_option.some(n(Caml_option.some(n(Caml_option.some(n(Caml_option.some(n(undefined, undefined, 4)), undefined, 2)), undefined, 5)), undefined, 1)), undefined, 3);

test3 = n(Caml_option.some(n(Caml_option.some(n(Caml_option.some(n(undefined, undefined, 4)), undefined, 2)), undefined, 5)), Caml_option.some(n(undefined, undefined, 3)), 1);

console.log(inOrder(test1));

console.log(inOrder3(test1));

S = --[[ alias ]]0;

Q = --[[ alias ]]0;

exports = {}
exports.S = S;
exports.Q = Q;
exports.inOrder = inOrder;
exports.inOrder3 = inOrder3;
exports.inOrder2 = inOrder2;
exports.n = n;
exports.test1 = test1;
exports.pushAllLeft = pushAllLeft;
exports.test2 = test2;
exports.test3 = test3;
--[[ test1 Not a pure module ]]
