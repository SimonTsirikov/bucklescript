console = {log = print};


v1 = do
  localeMatcher: "best fit",
  formatMatcher: "basic",
  day: "2-digit",
  timeZoneName: "short"
end;

exports = {}
exports.v1 = v1;
--[[ No side effect ]]
