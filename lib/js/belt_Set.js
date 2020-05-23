'use strict';

var Curry = require("./curry.js");
var Belt_SetDict = require("./belt_SetDict.js");

function fromArray(data, id) do
  var cmp = id.cmp;
  return do
          cmp: cmp,
          data: Belt_SetDict.fromArray(data, cmp)
        end;
end

function remove(m, e) do
  var cmp = m.cmp;
  var data = m.data;
  var newData = Belt_SetDict.remove(data, e, cmp);
  if (newData == data) then do
    return m;
  end else do
    return do
            cmp: cmp,
            data: newData
          end;
  end end 
end

function add(m, e) do
  var cmp = m.cmp;
  var data = m.data;
  var newData = Belt_SetDict.add(data, e, cmp);
  if (newData == data) then do
    return m;
  end else do
    return do
            cmp: cmp,
            data: newData
          end;
  end end 
end

function mergeMany(m, e) do
  var cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_SetDict.mergeMany(m.data, e, cmp)
        end;
end

function removeMany(m, e) do
  var cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_SetDict.removeMany(m.data, e, cmp)
        end;
end

function union(m, n) do
  var cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_SetDict.union(m.data, n.data, cmp)
        end;
end

function intersect(m, n) do
  var cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_SetDict.intersect(m.data, n.data, cmp)
        end;
end

function diff(m, n) do
  var cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_SetDict.diff(m.data, n.data, cmp)
        end;
end

function subset(m, n) do
  var cmp = m.cmp;
  return Belt_SetDict.subset(m.data, n.data, cmp);
end

function split(m, e) do
  var cmp = m.cmp;
  var match = Belt_SetDict.split(m.data, e, cmp);
  var match$1 = match[0];
  return --[ tuple ]--[
          --[ tuple ]--[
            do
              cmp: cmp,
              data: match$1[0]
            end,
            do
              cmp: cmp,
              data: match$1[1]
            end
          ],
          match[1]
        ];
end

function make(id) do
  return do
          cmp: id.cmp,
          data: Belt_SetDict.empty
        end;
end

function isEmpty(m) do
  return Belt_SetDict.isEmpty(m.data);
end

function cmp(m, n) do
  var cmp$1 = m.cmp;
  return Belt_SetDict.cmp(m.data, n.data, cmp$1);
end

function eq(m, n) do
  return Belt_SetDict.eq(m.data, n.data, m.cmp);
end

function forEachU(m, f) do
  return Belt_SetDict.forEachU(m.data, f);
end

function forEach(m, f) do
  return Belt_SetDict.forEachU(m.data, Curry.__1(f));
end

function reduceU(m, acc, f) do
  return Belt_SetDict.reduceU(m.data, acc, f);
end

function reduce(m, acc, f) do
  return reduceU(m, acc, Curry.__2(f));
end

function everyU(m, f) do
  return Belt_SetDict.everyU(m.data, f);
end

function every(m, f) do
  return Belt_SetDict.everyU(m.data, Curry.__1(f));
end

function someU(m, f) do
  return Belt_SetDict.someU(m.data, f);
end

function some(m, f) do
  return Belt_SetDict.someU(m.data, Curry.__1(f));
end

function keepU(m, f) do
  return do
          cmp: m.cmp,
          data: Belt_SetDict.keepU(m.data, f)
        end;
end

function keep(m, f) do
  return keepU(m, Curry.__1(f));
end

function partitionU(m, f) do
  var match = Belt_SetDict.partitionU(m.data, f);
  var cmp = m.cmp;
  return --[ tuple ]--[
          do
            cmp: cmp,
            data: match[0]
          end,
          do
            cmp: cmp,
            data: match[1]
          end
        ];
end

function partition(m, f) do
  return partitionU(m, Curry.__1(f));
end

function size(m) do
  return Belt_SetDict.size(m.data);
end

function toList(m) do
  return Belt_SetDict.toList(m.data);
end

function toArray(m) do
  return Belt_SetDict.toArray(m.data);
end

function minimum(m) do
  return Belt_SetDict.minimum(m.data);
end

function minUndefined(m) do
  return Belt_SetDict.minUndefined(m.data);
end

function maximum(m) do
  return Belt_SetDict.maximum(m.data);
end

function maxUndefined(m) do
  return Belt_SetDict.maxUndefined(m.data);
end

function get(m, e) do
  return Belt_SetDict.get(m.data, e, m.cmp);
end

function getUndefined(m, e) do
  return Belt_SetDict.getUndefined(m.data, e, m.cmp);
end

function getExn(m, e) do
  return Belt_SetDict.getExn(m.data, e, m.cmp);
end

function has(m, e) do
  return Belt_SetDict.has(m.data, e, m.cmp);
end

function fromSortedArrayUnsafe(xs, id) do
  return do
          cmp: id.cmp,
          data: Belt_SetDict.fromSortedArrayUnsafe(xs)
        end;
end

function getData(prim) do
  return prim.data;
end

function getId(m) do
  var cmp = m.cmp;
  return do
          cmp: cmp
        end;
end

function packIdData(id, data) do
  return do
          cmp: id.cmp,
          data: data
        end;
end

function checkInvariantInternal(d) do
  return Belt_SetDict.checkInvariantInternal(d.data);
end

var Int = --[ alias ]--0;

var $$String = --[ alias ]--0;

var Dict = --[ alias ]--0;

exports.Int = Int;
exports.$$String = $$String;
exports.Dict = Dict;
exports.make = make;
exports.fromArray = fromArray;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.isEmpty = isEmpty;
exports.has = has;
exports.add = add;
exports.mergeMany = mergeMany;
exports.remove = remove;
exports.removeMany = removeMany;
exports.union = union;
exports.intersect = intersect;
exports.diff = diff;
exports.subset = subset;
exports.cmp = cmp;
exports.eq = eq;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.keepU = keepU;
exports.keep = keep;
exports.partitionU = partitionU;
exports.partition = partition;
exports.size = size;
exports.toArray = toArray;
exports.toList = toList;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getExn = getExn;
exports.split = split;
exports.checkInvariantInternal = checkInvariantInternal;
exports.getData = getData;
exports.getId = getId;
exports.packIdData = packIdData;
--[ No side effect ]--
