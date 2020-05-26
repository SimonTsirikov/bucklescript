

import * as Caml_array from "./caml_array.js";

function app(_f, _args) do
  while(true) do
    var args = _args;
    var f = _f;
    var init_arity = #f;
    var arity = init_arity == 0 ? 1 : init_arity;
    var len = #args;
    var d = arity - len | 0;
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
      end
      end(f,args));
    end end  end 
  end;
end

function curry_1(o, a0, arity) do
  local ___conditional___=(arity);
  do
     if ___conditional___ = 1 then do
        return o(a0);end end end 
     if ___conditional___ = 2 then do
        return (function (param) do
            return o(a0, param);
          end);end end end 
     if ___conditional___ = 3 then do
        return (function (param, param$1) do
            return o(a0, param, param$1);
          end);end end end 
     if ___conditional___ = 4 then do
        return (function (param, param$1, param$2) do
            return o(a0, param, param$1, param$2);
          end);end end end 
     if ___conditional___ = 5 then do
        return (function (param, param$1, param$2, param$3) do
            return o(a0, param, param$1, param$2, param$3);
          end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1, param$2, param$3, param$4) do
            return o(a0, param, param$1, param$2, param$3, param$4);
          end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2, param$3, param$4, param$5) do
            return o(a0, param, param$1, param$2, param$3, param$4, param$5);
          end);end end end 
     do
    else do
      return app(o, [a0]);
      end end
      
  end
end

function _1(o, a0) do
  var arity = #o;
  if (arity == 1) then do
    return o(a0);
  end else do
    return curry_1(o, a0, arity);
  end end 
end

function __1(o) do
  var arity = #o;
  if (arity == 1) then do
    return o;
  end else do
    return (function (a0) do
        return _1(o, a0);
      end);
  end end 
end

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
          end);end end end 
     if ___conditional___ = 4 then do
        return (function (param, param$1) do
            return o(a0, a1, param, param$1);
          end);end end end 
     if ___conditional___ = 5 then do
        return (function (param, param$1, param$2) do
            return o(a0, a1, param, param$1, param$2);
          end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1, param$2, param$3) do
            return o(a0, a1, param, param$1, param$2, param$3);
          end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2, param$3, param$4) do
            return o(a0, a1, param, param$1, param$2, param$3, param$4);
          end);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1
                ]);
      end end
      
  end
end

function _2(o, a0, a1) do
  var arity = #o;
  if (arity == 2) then do
    return o(a0, a1);
  end else do
    return curry_2(o, a0, a1, arity);
  end end 
end

function __2(o) do
  var arity = #o;
  if (arity == 2) then do
    return o;
  end else do
    return (function (a0, a1) do
        return _2(o, a0, a1);
      end);
  end end 
end

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
          end);end end end 
     if ___conditional___ = 5 then do
        return (function (param, param$1) do
            return o(a0, a1, a2, param, param$1);
          end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1, param$2) do
            return o(a0, a1, a2, param, param$1, param$2);
          end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2, param$3) do
            return o(a0, a1, a2, param, param$1, param$2, param$3);
          end);end end end 
     do
    else do
      return app(o, [
                  a0,
                  a1,
                  a2
                ]);
      end end
      
  end
end

function _3(o, a0, a1, a2) do
  var arity = #o;
  if (arity == 3) then do
    return o(a0, a1, a2);
  end else do
    return curry_3(o, a0, a1, a2, arity);
  end end 
end

function __3(o) do
  var arity = #o;
  if (arity == 3) then do
    return o;
  end else do
    return (function (a0, a1, a2) do
        return _3(o, a0, a1, a2);
      end);
  end end 
end

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
          end);end end end 
     if ___conditional___ = 6 then do
        return (function (param, param$1) do
            return o(a0, a1, a2, a3, param, param$1);
          end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1, param$2) do
            return o(a0, a1, a2, a3, param, param$1, param$2);
          end);end end end 
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
end

function _4(o, a0, a1, a2, a3) do
  var arity = #o;
  if (arity == 4) then do
    return o(a0, a1, a2, a3);
  end else do
    return curry_4(o, a0, a1, a2, a3, arity);
  end end 
end

function __4(o) do
  var arity = #o;
  if (arity == 4) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3) do
        return _4(o, a0, a1, a2, a3);
      end);
  end end 
end

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
          end);end end end 
     if ___conditional___ = 7 then do
        return (function (param, param$1) do
            return o(a0, a1, a2, a3, a4, param, param$1);
          end);end end end 
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
end

function _5(o, a0, a1, a2, a3, a4) do
  var arity = #o;
  if (arity == 5) then do
    return o(a0, a1, a2, a3, a4);
  end else do
    return curry_5(o, a0, a1, a2, a3, a4, arity);
  end end 
end

function __5(o) do
  var arity = #o;
  if (arity == 5) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4) do
        return _5(o, a0, a1, a2, a3, a4);
      end);
  end end 
end

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
          end);end end end 
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
end

function _6(o, a0, a1, a2, a3, a4, a5) do
  var arity = #o;
  if (arity == 6) then do
    return o(a0, a1, a2, a3, a4, a5);
  end else do
    return curry_6(o, a0, a1, a2, a3, a4, a5, arity);
  end end 
end

function __6(o) do
  var arity = #o;
  if (arity == 6) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4, a5) do
        return _6(o, a0, a1, a2, a3, a4, a5);
      end);
  end end 
end

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
end

function _7(o, a0, a1, a2, a3, a4, a5, a6) do
  var arity = #o;
  if (arity == 7) then do
    return o(a0, a1, a2, a3, a4, a5, a6);
  end else do
    return curry_7(o, a0, a1, a2, a3, a4, a5, a6, arity);
  end end 
end

function __7(o) do
  var arity = #o;
  if (arity == 7) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4, a5, a6) do
        return _7(o, a0, a1, a2, a3, a4, a5, a6);
      end);
  end end 
end

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
end

function _8(o, a0, a1, a2, a3, a4, a5, a6, a7) do
  var arity = #o;
  if (arity == 8) then do
    return o(a0, a1, a2, a3, a4, a5, a6, a7);
  end else do
    return curry_8(o, a0, a1, a2, a3, a4, a5, a6, a7, arity);
  end end 
end

function __8(o) do
  var arity = #o;
  if (arity == 8) then do
    return o;
  end else do
    return (function (a0, a1, a2, a3, a4, a5, a6, a7) do
        return _8(o, a0, a1, a2, a3, a4, a5, a6, a7);
      end);
  end end 
end

export do
  app ,
  curry_1 ,
  _1 ,
  __1 ,
  curry_2 ,
  _2 ,
  __2 ,
  curry_3 ,
  _3 ,
  __3 ,
  curry_4 ,
  _4 ,
  __4 ,
  curry_5 ,
  _5 ,
  __5 ,
  curry_6 ,
  _6 ,
  __6 ,
  curry_7 ,
  _7 ,
  __7 ,
  curry_8 ,
  _8 ,
  __8 ,
  
end
--[ No side effect ]--
