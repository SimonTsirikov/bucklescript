console.log = print;

Curry = require "./curry";

function MakeComparableU(M) do
  return M;
end end

function MakeComparable(M) do
  cmp = M.cmp;
  cmp_1 = Curry.__2(cmp);
  return do
          cmp: cmp_1
        end;
end end

function comparableU(cmp) do
  return do
          cmp: cmp
        end;
end end

function comparable(cmp) do
  cmp_1 = Curry.__2(cmp);
  return do
          cmp: cmp_1
        end;
end end

function MakeHashableU(M) do
  return M;
end end

function MakeHashable(M) do
  hash = M.hash;
  hash_1 = Curry.__1(hash);
  eq = M.eq;
  eq_1 = Curry.__2(eq);
  return do
          hash: hash_1,
          eq: eq_1
        end;
end end

function hashableU(hash, eq) do
  return do
          hash: hash,
          eq: eq
        end;
end end

function hashable(hash, eq) do
  hash_1 = Curry.__1(hash);
  eq_1 = Curry.__2(eq);
  return do
          hash: hash_1,
          eq: eq_1
        end;
end end

exports.MakeComparableU = MakeComparableU;
exports.MakeComparable = MakeComparable;
exports.comparableU = comparableU;
exports.comparable = comparable;
exports.MakeHashableU = MakeHashableU;
exports.MakeHashable = MakeHashable;
exports.hashableU = hashableU;
exports.hashable = hashable;
--[[ No side effect ]]
