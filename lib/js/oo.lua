console = {log = print};

CamlinternalOO = require "./camlinternalOO";

copy = CamlinternalOO.copy;

new_method = CamlinternalOO.public_method_label;

public_method_label = CamlinternalOO.public_method_label;

exports = {}
exports.copy = copy;
exports.new_method = new_method;
exports.public_method_label = public_method_label;
--[[ No side effect ]]
