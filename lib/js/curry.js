'use strict';

Caml_array = require("./caml_array.js");

function app(_f, _args) do
  while(true) do
    args = _args;
    f = _f;
    init_arity = #f;
    arity = init_arity == 0 and 1 or init_arity;
    len = #args;
    d = arity - len | 0;
    if (d == 0) then do
      return f.apply(null, args);
    end else if (d < 0) then do
      _args = Caml_array.caml_array_sub(args, arity, -d | 0);
      _f = f.apply(null, Caml_array.caml_array_sub(args, 0, arity));
      continue ;
    end else do
      return (function(f,args)do
      return function (x) do
        return app(f, args.concat([x]));
      end end
      end(f,args));
    end end  end 
  end;
end end

function curry_1(o, a0, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return o(a0);end end end 
     if ___conditional___ = 2 then do
        return (function (param) do
            return o(a0, param);
          end end);end end end 
     if ___conditional___ = 3 then do
        return (function (param, param$1) do
            return o(a0, param, param$1);
          end end);end end end 
     if ___conditional___ = 4 then do
        return (function (param, param$1, param$2) do
            return o(a0, param, param$1, param$2);
          end end);end end end 
     if ___conditional___ = 5 then do
        return (function (param, param$1, param$2, param$3) do
            return o(a0, param, param$1, param$2, param$3);
          end end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1, param$2, param$3, param$4) do
            return o(a0, param, param$1, param$2, param$3, param$4);
          end end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2, param$3, param$4, param$5) do
            return o(a0, param, param$1, param$2, param$3, param$4, param$5);
          end end);end end end 
     do
    else do
      return app(o, [a0]);
      end end
      
  end
end end

function _1(o, a0) do
  arity = #o;
  if (arity == 1) then do
    return o(a0);
  end else do
    return curry_1(o, a0, arity);
  end end 
end end

function __1(o) do
  arity = #o;
  if (arity == 1) then do
    return o;
  end else do
    return (function (a0) do
        return _1(o, a0);
      end end);
  end end 
end end

function curry_2(o, a0, a1, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return app(o(a0), [a1]);end end end 
     if ___conditional___ = 2 then do
        return o(a0, a1);end end end 
     if ___conditional___ = 3 then do
        return (function (param) do
            return o(a0, a1, param);
          end end);end end end 
     if ___conditional___ = 4 then do
        return (function (param, param$1) do
            return o(a0, a1, param, param$1);
          end end);end end end 
     if ___conditional___ = 5 then do
        return (function (param, param$1, param$2) do
            return o(a0, a1, param, param$1, param$2);
          end end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1, param$2, param$3) do
            return o(a0, a1, param, param$1, param$2, param$3);
          end end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2, param$3, param$4) do
            return o(a0, a1, param, param$1, param$2, param$3, param$4);
          end end);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1
                ]);
      end end
      
  end
end end

function _2(o, a0, a1) do
  arity = #o;
  if (arity == 2) then do
    return o(a0, a1);
  end else do
    return curry_2(o, a0, a1, arity);
  end end 
end end

function __2(o) do
  arity = #o;
  if (arity == 2) then do
    return o;
  end else do
    return (function (a0, a1) do
        return _2(o, a0, a1);
      end end);
  end end 
end end

function curry_3(o, a0, a1, a2, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return app(o(a0), [
                    a1,
                    a2
                  ]);end end end 
     if ___conditional___ = 2 then do
        return app(o(a0, a1), [a2]);end end end 
     if ___conditional___ = 3 then do
        return o(a0, a1, a2);end end end 
     if ___conditional___ = 4 then do
        return (function (param) do
            return o(a0, a1, a2, param);
          end end);end end end 
     if ___conditional___ = 5 then do
        return (function (param, param$1) do
            return o(a0, a1, a2, param, param$1);
          end end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1, param$2) do
            return o(a0, a1, a2, param, param$1, param$2);
          end end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2, param$3) do
            return o(a0, a1, a2, param, param$1, param$2, param$3);
          end end);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1,
                  a2
                ]);
      end end
      
  end
end end

function _3(o, a0, a1, a2) do
  arity = #o;
  if (arity == 3) then do
    return o(a0, a1, a2);
  end else do
    return curry_3(o, a0, a1, a2, arity);
  end end 
end end

function __3(o) do
  arity = #o;
  if (arity == 3) then do
    return o;
  end else do
    return (function (a0, a1, a2) do
        return _3(o, a0, a1, a2);
      end end);
  end end 
end end

function curry_4(o, a0, a1, a2, a3, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return app(o(a0), [
                    a1,
                    a2,
                    a3
                  ]);end end end 
     if ___conditional___ = 2 then do
        return app(o(a0, a1), [
                    a2,
                    a3
                  ]);end end end 
     if ___conditional___ = 3 then do
        return app(o(a0, a1, a2), [a3]);end end end 
     if ___conditional___ = 4 then do
        return o(a0, a1, a2, a3);end end end 
     if ___conditional___ = 5 then do
        return (function (param) do
            return o(a0, a1, a2, a3, param);
          end end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1) do
            return o(a0, a1, a2, a3, param, param$1);
          end end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2) do
            return o(a0, a1, a2, a3, param, param$1, param$2);
          end end);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1,
                  a2,
                  a3
                ]);
      end end
      
  end
end end

function _4(o, a0, a1, a2, a3) do
  arity = #o;
  if (arity == 4) then do
    return o(a0, a1, a2, a3);
  end else do
    return curry_4(o, a0, a1, a2, a3, arity);
  end end 
end end

function __4(o) do
  arity = #o;
  if (arity == 4) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3) do
        return _4(o, a0, a1, a2, a3);
      end end);
  end end 
end end

function curry_5(o, a0, a1, a2, a3, a4, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return app(o(a0), [
                    a1,
                    a2,
                    a3,
                    a4
                  ]);end end end 
     if ___conditional___ = 2 then do
        return app(o(a0, a1), [
                    a2,
                    a3,
                    a4
                  ]);end end end 
     if ___conditional___ = 3 then do
        return app(o(a0, a1, a2), [
                    a3,
                    a4
                  ]);end end end 
     if ___conditional___ = 4 then do
        return app(o(a0, a1, a2, a3), [a4]);end end end 
     if ___conditional___ = 5 then do
        return o(a0, a1, a2, a3, a4);end end end 
     if ___conditional___ = 6 then do
        return (function (param) do
            return o(a0, a1, a2, a3, a4, param);
          end end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1) do
            return o(a0, a1, a2, a3, a4, param, param$1);
          end end);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1,
                  a2,
                  a3,
                  a4
                ]);
      end end
      
  end
end end

function _5(o, a0, a1, a2, a3, a4) do
  arity = #o;
  if (arity == 5) then do
    return o(a0, a1, a2, a3, a4);
  end else do
    return curry_5(o, a0, a1, a2, a3, a4, arity);
  end end 
end end

function __5(o) do
  arity = #o;
  if (arity == 5) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4) do
        return _5(o, a0, a1, a2, a3, a4);
      end end);
  end end 
end end

function curry_6(o, a0, a1, a2, a3, a4, a5, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return app(o(a0), [
                    a1,
                    a2,
                    a3,
                    a4,
                    a5
                  ]);end end end 
     if ___conditional___ = 2 then do
        return app(o(a0, a1), [
                    a2,
                    a3,
                    a4,
                    a5
                  ]);end end end 
     if ___conditional___ = 3 then do
        return app(o(a0, a1, a2), [
                    a3,
                    a4,
                    a5
                  ]);end end end 
     if ___conditional___ = 4 then do
        return app(o(a0, a1, a2, a3), [
                    a4,
                    a5
                  ]);end end end 
     if ___conditional___ = 5 then do
        return app(o(a0, a1, a2, a3, a4), [a5]);end end end 
     if ___conditional___ = 6 then do
        return o(a0, a1, a2, a3, a4, a5);end end end 
     if ___conditional___ = 7 then do
        return (function (param) do
            return o(a0, a1, a2, a3, a4, a5, param);
          end end);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1,
                  a2,
                  a3,
                  a4,
                  a5
                ]);
      end end
      
  end
end end

function _6(o, a0, a1, a2, a3, a4, a5) do
  arity = #o;
  if (arity == 6) then do
    return o(a0, a1, a2, a3, a4, a5);
  end else do
    return curry_6(o, a0, a1, a2, a3, a4, a5, arity);
  end end 
end end

function __6(o) do
  arity = #o;
  if (arity == 6) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4, a5) do
        return _6(o, a0, a1, a2, a3, a4, a5);
      end end);
  end end 
end end

function curry_7(o, a0, a1, a2, a3, a4, a5, a6, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return app(o(a0), [
                    a1,
                    a2,
                    a3,
                    a4,
                    a5,
                    a6
                  ]);end end end 
     if ___conditional___ = 2 then do
        return app(o(a0, a1), [
                    a2,
                    a3,
                    a4,
                    a5,
                    a6
                  ]);end end end 
     if ___conditional___ = 3 then do
        return app(o(a0, a1, a2), [
                    a3,
                    a4,
                    a5,
                    a6
                  ]);end end end 
     if ___conditional___ = 4 then do
        return app(o(a0, a1, a2, a3), [
                    a4,
                    a5,
                    a6
                  ]);end end end 
     if ___conditional___ = 5 then do
        return app(o(a0, a1, a2, a3, a4), [
                    a5,
                    a6
                  ]);end end end 
     if ___conditional___ = 6 then do
        return app(o(a0, a1, a2, a3, a4, a5), [a6]);end end end 
     if ___conditional___ = 7 then do
        return o(a0, a1, a2, a3, a4, a5, a6);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1,
                  a2,
                  a3,
                  a4,
                  a5,
                  a6
                ]);
      end end
      
  end
end end

function _7(o, a0, a1, a2, a3, a4, a5, a6) do
  arity = #o;
  if (arity == 7) then do
    return o(a0, a1, a2, a3, a4, a5, a6);
  end else do
    return curry_7(o, a0, a1, a2, a3, a4, a5, a6, arity);
  end end 
end end

function __7(o) do
  arity = #o;
  if (arity == 7) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4, a5, a6) do
        return _7(o, a0, a1, a2, a3, a4, a5, a6);
      end end);
  end end 
end end

function curry_8(o, a0, a1, a2, a3, a4, a5, a6, a7, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return app(o(a0), [
                    a1,
                    a2,
                    a3,
                    a4,
                    a5,
                    a6,
                    a7
                  ]);end end end 
     if ___conditional___ = 2 then do
        return app(o(a0, a1), [
                    a2,
                    a3,
                    a4,
                    a5,
                    a6,
                    a7
                  ]);end end end 
     if ___conditional___ = 3 then do
        return app(o(a0, a1, a2), [
                    a3,
                    a4,
                    a5,
                    a6,
                    a7
                  ]);end end end 
     if ___conditional___ = 4 then do
        return app(o(a0, a1, a2, a3), [
                    a4,
                    a5,
                    a6,
                    a7
                  ]);end end end 
     if ___conditional___ = 5 then do
        return app(o(a0, a1, a2, a3, a4), [
                    a5,
                    a6,
                    a7
                  ]);end end end 
     if ___conditional___ = 6 then do
        return app(o(a0, a1, a2, a3, a4, a5), [
                    a6,
                    a7
                  ]);end end end 
     if ___conditional___ = 7 then do
        return app(o(a0, a1, a2, a3, a4, a5, a6), [a7]);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1,
                  a2,
                  a3,
                  a4,
                  a5,
                  a6,
                  a7
                ]);
      end end
      
  end
end end

function _8(o, a0, a1, a2, a3, a4, a5, a6, a7) do
  arity = #o;
  if (arity == 8) then do
    return o(a0, a1, a2, a3, a4, a5, a6, a7);
  end else do
    return curry_8(o, a0, a1, a2, a3, a4, a5, a6, a7, arity);
  end end 
end end

function __8(o) do
  arity = #o;
  if (arity == 8) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4, a5, a6, a7) do
        return _8(o, a0, a1, a2, a3, a4, a5, a6, a7);
      end end);
  end end 
end end

exports.app = app;
exports.curry_1 = curry_1;
exports._1 = _1;
exports.__1 = __1;
exports.curry_2 = curry_2;
exports._2 = _2;
exports.__2 = __2;
exports.curry_3 = curry_3;
exports._3 = _3;
exports.__3 = __3;
exports.curry_4 = curry_4;
exports._4 = _4;
exports.__4 = __4;
exports.curry_5 = curry_5;
exports._5 = _5;
exports.__5 = __5;
exports.curry_6 = curry_6;
exports._6 = _6;
exports.__6 = __6;
exports.curry_7 = curry_7;
exports._7 = _7;
exports.__7 = __7;
exports.curry_8 = curry_8;
exports._8 = _8;
exports.__8 = __8;
--[ No side effect ]--
