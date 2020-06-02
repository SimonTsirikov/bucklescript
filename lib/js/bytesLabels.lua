console = {log = print};

Bytes = require "./bytes";

make = Bytes.make;

init = Bytes.init;

empty = Bytes.empty;

copy = Bytes.copy;

of_string = Bytes.of_string;

to_string = Bytes.to_string;

sub = Bytes.sub;

sub_string = Bytes.sub_string;

extend = Bytes.extend;

fill = Bytes.fill;

blit = Bytes.blit;

blit_string = Bytes.blit_string;

concat = Bytes.concat;

cat = Bytes.cat;

iter = Bytes.iter;

iteri = Bytes.iteri;

map = Bytes.map;

mapi = Bytes.mapi;

trim = Bytes.trim;

escaped = Bytes.escaped;

index = Bytes.index;

index_opt = Bytes.index_opt;

rindex = Bytes.rindex;

rindex_opt = Bytes.rindex_opt;

index_from = Bytes.index_from;

index_from_opt = Bytes.index_from_opt;

rindex_from = Bytes.rindex_from;

rindex_from_opt = Bytes.rindex_from_opt;

contains = Bytes.contains;

contains_from = Bytes.contains_from;

rcontains_from = Bytes.rcontains_from;

uppercase = Bytes.uppercase;

lowercase = Bytes.lowercase;

capitalize = Bytes.capitalize;

uncapitalize = Bytes.uncapitalize;

uppercase_ascii = Bytes.uppercase_ascii;

lowercase_ascii = Bytes.lowercase_ascii;

capitalize_ascii = Bytes.capitalize_ascii;

uncapitalize_ascii = Bytes.uncapitalize_ascii;

compare = Bytes.compare;

equal = Bytes.equal;

unsafe_to_string = Bytes.unsafe_to_string;

unsafe_of_string = Bytes.unsafe_of_string;

exports = {}
exports.make = make;
exports.init = init;
exports.empty = empty;
exports.copy = copy;
exports.of_string = of_string;
exports.to_string = to_string;
exports.sub = sub;
exports.sub_string = sub_string;
exports.extend = extend;
exports.fill = fill;
exports.blit = blit;
exports.blit_string = blit_string;
exports.concat = concat;
exports.cat = cat;
exports.iter = iter;
exports.iteri = iteri;
exports.map = map;
exports.mapi = mapi;
exports.trim = trim;
exports.escaped = escaped;
exports.index = index;
exports.index_opt = index_opt;
exports.rindex = rindex;
exports.rindex_opt = rindex_opt;
exports.index_from = index_from;
exports.index_from_opt = index_from_opt;
exports.rindex_from = rindex_from;
exports.rindex_from_opt = rindex_from_opt;
exports.contains = contains;
exports.contains_from = contains_from;
exports.rcontains_from = rcontains_from;
exports.uppercase = uppercase;
exports.lowercase = lowercase;
exports.capitalize = capitalize;
exports.uncapitalize = uncapitalize;
exports.uppercase_ascii = uppercase_ascii;
exports.lowercase_ascii = lowercase_ascii;
exports.capitalize_ascii = capitalize_ascii;
exports.uncapitalize_ascii = uncapitalize_ascii;
exports.compare = compare;
exports.equal = equal;
exports.unsafe_to_string = unsafe_to_string;
exports.unsafe_of_string = unsafe_of_string;
--[[ No side effect ]]
