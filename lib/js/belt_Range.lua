'use strict';

Curry = require("./curry.lua");

function forEachU(s, f, action) do
  for i = s , f , 1 do
    action(i);
  end
  return --[[ () ]]0;
end end

function forEach(s, f, action) do
  return forEachU(s, f, Curry.__1(action));
end end

function everyU(_s, f, p) do
  while(true) do
    s = _s;
    if (s > f) then do
      return true;
    end else if (p(s)) then do
      _s = s + 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end end

function every(s, f, p) do
  return everyU(s, f, Curry.__1(p));
end end

function everyByU(s, f, step, p) do
  if (step > 0) then do
    _s = s;
    f$1 = f;
    step$1 = step;
    p$1 = p;
    while(true) do
      s$1 = _s;
      if (s$1 > f$1) then do
        return true;
      end else if (p$1(s$1)) then do
        _s = s$1 + step$1 | 0;
        continue ;
      end else do
        return false;
      end end  end 
    end;
  end else do
    return true;
  end end 
end end

function everyBy(s, f, step, p) do
  return everyByU(s, f, step, Curry.__1(p));
end end

function someU(_s, f, p) do
  while(true) do
    s = _s;
    if (s > f) then do
      return false;
    end else if (p(s)) then do
      return true;
    end else do
      _s = s + 1 | 0;
      continue ;
    end end  end 
  end;
end end

function some(s, f, p) do
  return someU(s, f, Curry.__1(p));
end end

function someByU(s, f, step, p) do
  if (step > 0) then do
    _s = s;
    f$1 = f;
    step$1 = step;
    p$1 = p;
    while(true) do
      s$1 = _s;
      if (s$1 > f$1) then do
        return false;
      end else if (p$1(s$1)) then do
        return true;
      end else do
        _s = s$1 + step$1 | 0;
        continue ;
      end end  end 
    end;
  end else do
    return false;
  end end 
end end

function someBy(s, f, step, p) do
  return someByU(s, f, step, Curry.__1(p));
end end

exports.forEachU = forEachU;
exports.forEach = forEach;
exports.everyU = everyU;
exports.every = every;
exports.everyByU = everyByU;
exports.everyBy = everyBy;
exports.someU = someU;
exports.some = some;
exports.someByU = someByU;
exports.someBy = someBy;
--[[ No side effect ]]
