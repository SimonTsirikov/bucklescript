__console = {log = print};

List = require "......lib.js.list";
Curry = require "......lib.js.curry";

function from_pair_suites(name, suites) do
  __console.log(--[[ tuple ]]{
        name,
        "testing"
      });
  return List.iter((function(param) do
                name = param[1];
                match = Curry._1(param[2], --[[ () ]]0);
                local ___conditional___=(match.tag | 0);
                do
                   if ___conditional___ == 0--[[ Eq ]] then do
                      __console.log(--[[ tuple ]]{
                            name,
                            match[1],
                            "eq?",
                            match[2]
                          });
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 1--[[ Neq ]] then do
                      __console.log(--[[ tuple ]]{
                            name,
                            match[1],
                            "neq?",
                            match[2]
                          });
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 2--[[ StrictEq ]] then do
                      __console.log(--[[ tuple ]]{
                            name,
                            match[1],
                            "strict_eq?",
                            match[2]
                          });
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 3--[[ StrictNeq ]] then do
                      __console.log(--[[ tuple ]]{
                            name,
                            match[1],
                            "strict_neq?",
                            match[2]
                          });
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 4--[[ Ok ]] then do
                      __console.log(--[[ tuple ]]{
                            name,
                            match[1],
                            "ok?"
                          });
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 5--[[ Approx ]] then do
                      __console.log(--[[ tuple ]]{
                            name,
                            match[1],
                            "~",
                            match[2]
                          });
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 6--[[ ApproxThreshold ]] then do
                      __console.log(--[[ tuple ]]{
                            name,
                            match[2],
                            "~",
                            match[3],
                            " (",
                            match[1],
                            ")"
                          });
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 7--[[ ThrowAny ]] then do
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 8--[[ Fail ]] then do
                      __console.log("failed");
                      return --[[ () ]]0; end end 
                   if ___conditional___ == 9--[[ FailWith ]] then do
                      __console.log("failed: " .. match[1]);
                      return --[[ () ]]0; end end 
                  
                end
              end end), suites);
end end

exports = {};
exports.from_pair_suites = from_pair_suites;
return exports;
--[[ No side effect ]]
