'use strict';

Caml_option = require("../../lib/js/caml_option.lua");
Js_undefined = require("../../lib/js/js_undefined.lua");
Belt_MutableQueue = require("../../lib/js/belt_MutableQueue.lua");
Belt_MutableStack = require("../../lib/js/belt_MutableStack.lua");

function inOrder(v) do
  current = v;
  s = do
    root: null
  end;
  q = Belt_MutableQueue.make(--[[ () ]]0);
  while(current ~= undefined) do
    v$1 = current;
    Belt_MutableStack.push(s, v$1);
    current = v$1.left;
  end;
  while(s.root ~= null) do
    current = Belt_MutableStack.popUndefined(s);
    v$2 = current;
    Belt_MutableQueue.add(q, v$2.value);
    current = v$2.right;
    while(current ~= undefined) do
      v$3 = current;
      Belt_MutableStack.push(s, v$3);
      current = v$3.left;
    end;
  end;
  return Belt_MutableQueue.toArray(q);
end end

function inOrder3(v) do
  current = v;
  s = do
    root: null
  end;
  q = Belt_MutableQueue.make(--[[ () ]]0);
  while(current ~= undefined) do
    v$1 = current;
    Belt_MutableStack.push(s, v$1);
    current = v$1.left;
  end;
  Belt_MutableStack.dynamicPopIter(s, (function (popped) do
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
  s = do
    root: null
  end;
  q = Belt_MutableQueue.make(--[[ () ]]0);
  while(todo) do
    if (cursor ~= undefined) then do
      v$1 = cursor;
      Belt_MutableStack.push(s, v$1);
      cursor = v$1.left;
    end else if (s.root ~= null) then do
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
  return do
          value: a,
          left: Js_undefined.fromOption(l),
          right: Js_undefined.fromOption(r)
        end;
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
