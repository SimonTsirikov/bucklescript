'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
$$String = require("../../lib/js/string.js");
Filename = require("../../lib/js/filename.js");
Caml_string = require("../../lib/js/caml_string.js");

function generic_basename(is_dir_sep, current_dir_name, name) do
  if (name == "") then do
    return current_dir_name;
  end else do
    _n = #name - 1 | 0;
    while(true) do
      n = _n;
      if (n < 0) then do
        return $$String.sub(name, 0, 1);
      end else if (Curry._2(is_dir_sep, name, n)) then do
        _n = n - 1 | 0;
        continue ;
      end else do
        _n$1 = n;
        p = n + 1 | 0;
        while(true) do
          n$1 = _n$1;
          if (n$1 < 0) then do
            return $$String.sub(name, 0, p);
          end else if (Curry._2(is_dir_sep, name, n$1)) then do
            return $$String.sub(name, n$1 + 1 | 0, (p - n$1 | 0) - 1 | 0);
          end else do
            _n$1 = n$1 - 1 | 0;
            continue ;
          end end  end 
        end;
      end end  end 
    end;
  end end 
end end

function basename(param) do
  return generic_basename((function (s, i) do
                return Caml_string.get(s, i) == --[[ "/" ]]47;
              end end), Filename.current_dir_name, param);
end end

suites_000 = --[[ tuple ]][
  "basename",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                basename("b/c/a.b"),
                "a.b"
              ]);
    end end)
];

suites = --[[ :: ]][
  suites_000,
  --[[ [] ]]0
];

Mt.from_pair_suites("Inline_regression_test", suites);

exports.generic_basename = generic_basename;
exports.basename = basename;
exports.suites = suites;
--[[  Not a pure module ]]
