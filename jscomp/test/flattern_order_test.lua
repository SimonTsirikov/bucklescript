__console = {log = print};


function even(_n) do
  while(true) do
    n = _n;
    if (n == 0) then do
      return true;
    end else do
      _n = n - 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function even2(n) do
  if (n == 0) then do
    return true;
  end else do
    n_1 = n - 1 | 0;
    if (n_1 == 1) then do
      return true;
    end else do
      return even2(n_1 - 1 | 0);
    end end 
  end end 
end end

v = {
  contents = 0
};

function obj_get(param) do
  return v.contents;
end end

function obj_set(i) do
  v.contents = i;
  return --[[ () ]]0;
end end

obj = {
  get = obj_get,
  set = obj_set
};

exports = {};
exports.even = even;
exports.even2 = even2;
exports.v = v;
exports.obj = obj;
return exports;
--[[ No side effect ]]
