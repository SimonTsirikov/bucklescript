__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";

suites_000 = --[[ tuple ]]{
  "setTimeout/clearTimeout sanity check",
  (function(param) do
      handle = __setTimeout((function(param) do
              return --[[ () ]]0;
            end end), 0);
      __clearTimeout(handle);
      return --[[ Ok ]]Block.__(4, {true});
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "setInerval/clearInterval sanity check",
    (function(param) do
        handle = __setInterval((function(param) do
                return --[[ () ]]0;
              end end), 0);
        __clearInterval(handle);
        return --[[ Ok ]]Block.__(4, {true});
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "encodeURI",
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    __encodeURI("[-=-]"),
                    "%5B-=-%5D"
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "decodeURI",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      __decodeURI("%5B-=-%5D"),
                      "[-=-]"
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "encodeURIComponent",
          (function(param) do
              return --[[ Eq ]]Block.__(0, {
                        __encodeURIComponent("[-=-]"),
                        "%5B-%3D-%5D"
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "decodeURIComponent",
            (function(param) do
                return --[[ Eq ]]Block.__(0, {
                          __decodeURIComponent("%5B-%3D-%5D"),
                          "[-=-]"
                        });
              end end)
          },
          --[[ [] ]]0
        }
      }
    }
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Js_global_test", suites);

exports = {};
exports.suites = suites;
return exports;
--[[  Not a pure module ]]
