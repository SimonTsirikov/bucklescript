

import * as Curry from "./curry.js";

function MakeComparableU(M) do
  return M;
end

function MakeComparable(M) do
  cmp = M.cmp;
  cmp$1 = Curry.__2(cmp);
  return do
          cmp: cmp$1
        end;
end

function comparableU(cmp) do
  return do
          cmp: cmp
        end;
end

function comparable(cmp) do
  cmp$1 = Curry.__2(cmp);
  return do
          cmp: cmp$1
        end;
end

function MakeHashableU(M) do
  return M;
end

function MakeHashable(M) do
  hash = M.hash;
  hash$1 = Curry.__1(hash);
  eq = M.eq;
  eq$1 = Curry.__2(eq);
  return do
          hash: hash$1,
          eq: eq$1
        end;
end

function hashableU(hash, eq) do
  return do
          hash: hash,
          eq: eq
        end;
end

function hashable(hash, eq) do
  hash$1 = Curry.__1(hash);
  eq$1 = Curry.__2(eq);
  return do
          hash: hash$1,
          eq: eq$1
        end;
end

export do
  MakeComparableU ,
  MakeComparable ,
  comparableU ,
  comparable ,
  MakeHashableU ,
  MakeHashable ,
  hashableU ,
  hashable ,
  
end
--[ No side effect ]--
