'use strict';


undefinedHeader = [];

function some(x) do
  if (x == undefined) then do
    block = --[ tuple ]--[
      undefinedHeader,
      0
    ];
    block.tag = 256;
    return block;
  end else if (x ~= null and x[0] == undefinedHeader) then do
    nid = x[1] + 1 | 0;
    block$1 = --[ tuple ]--[
      undefinedHeader,
      nid
    ];
    block$1.tag = 256;
    return block$1;
  end else do
    return x;
  end end  end 
end

function nullable_to_opt(x) do
  if (x == null or x == undefined) then do
    return ;
  end else do
    return some(x);
  end end 
end

function undefined_to_opt(x) do
  if (x == undefined) then do
    return ;
  end else do
    return some(x);
  end end 
end

function null_to_opt(x) do
  if (x == null) then do
    return ;
  end else do
    return some(x);
  end end 
end

function valFromOption(x) do
  if (x ~= null and x[0] == undefinedHeader) then do
    depth = x[1];
    if (depth == 0) then do
      return ;
    end else do
      return --[ tuple ]--[
              undefinedHeader,
              depth - 1 | 0
            ];
    end end 
  end else do
    return x;
  end end 
end

function option_get(x) do
  if (x == undefined) then do
    return ;
  end else do
    return valFromOption(x);
  end end 
end

function option_get_unwrap(x) do
  if (x == undefined) then do
    return ;
  end else do
    return valFromOption(x)[1];
  end end 
end

exports.nullable_to_opt = nullable_to_opt;
exports.undefined_to_opt = undefined_to_opt;
exports.null_to_opt = null_to_opt;
exports.valFromOption = valFromOption;
exports.some = some;
exports.option_get = option_get;
exports.option_get_unwrap = option_get_unwrap;
--[ No side effect ]--
