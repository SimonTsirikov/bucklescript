--[['use strict';]]

Curry = require "./curry";
Belt_MapDict = require "./belt_MapDict";

function fromArray(data, id) do
  cmp = id.cmp;
  return do
          cmp: cmp,
          data: Belt_MapDict.fromArray(data, cmp)
        end;
end end

function remove(m, x) do
  cmp = m.cmp;
  odata = m.data;
  newData = Belt_MapDict.remove(odata, x, cmp);
  if (newData == odata) then do
    return m;
  end else do
    return do
            cmp: cmp,
            data: newData
          end;
  end end 
end end

function removeMany(m, x) do
  cmp = m.cmp;
  odata = m.data;
  newData = Belt_MapDict.removeMany(odata, x, cmp);
  return do
          cmp: cmp,
          data: newData
        end;
end end

function set(m, key, d) do
  cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_MapDict.set(m.data, key, d, cmp)
        end;
end end

function mergeMany(m, e) do
  cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_MapDict.mergeMany(m.data, e, cmp)
        end;
end end

function updateU(m, key, f) do
  cmp = m.cmp;
  return do
          cmp: cmp,
          data: Belt_MapDict.updateU(m.data, key, f, cmp)
        end;
end end

function update(m, key, f) do
  return updateU(m, key, Curry.__1(f));
end end

function split(m, x) do
  cmp = m.cmp;
  match = Belt_MapDict.split(m.data, x, cmp);
  match_1 = match[0];
  return --[[ tuple ]]{
          --[[ tuple ]]{
            do
              cmp: cmp,
              data: match_1[0]
            end,
            do
              cmp: cmp,
              data: match_1[1]
            end
          },
          match[1]
        };
end end

function mergeU(s1, s2, f) do
  cmp = s1.cmp;
  return do
          cmp: cmp,
          data: Belt_MapDict.mergeU(s1.data, s2.data, f, cmp)
        end;
end end

function merge(s1, s2, f) do
  return mergeU(s1, s2, Curry.__3(f));
end end

function make(id) do
  return do
          cmp: id.cmp,
          data: Belt_MapDict.empty
        end;
end end

function isEmpty(map) do
  return Belt_MapDict.isEmpty(map.data);
end end

function findFirstByU(m, f) do
  return Belt_MapDict.findFirstByU(m.data, f);
end end

function findFirstBy(m, f) do
  return Belt_MapDict.findFirstByU(m.data, Curry.__2(f));
end end

function forEachU(m, f) do
  return Belt_MapDict.forEachU(m.data, f);
end end

function forEach(m, f) do
  return Belt_MapDict.forEachU(m.data, Curry.__2(f));
end end

function reduceU(m, acc, f) do
  return Belt_MapDict.reduceU(m.data, acc, f);
end end

function reduce(m, acc, f) do
  return reduceU(m, acc, Curry.__3(f));
end end

function everyU(m, f) do
  return Belt_MapDict.everyU(m.data, f);
end end

function every(m, f) do
  return Belt_MapDict.everyU(m.data, Curry.__2(f));
end end

function someU(m, f) do
  return Belt_MapDict.someU(m.data, f);
end end

function some(m, f) do
  return Belt_MapDict.someU(m.data, Curry.__2(f));
end end

function keepU(m, f) do
  return do
          cmp: m.cmp,
          data: Belt_MapDict.keepU(m.data, f)
        end;
end end

function keep(m, f) do
  return keepU(m, Curry.__2(f));
end end

function partitionU(m, p) do
  cmp = m.cmp;
  match = Belt_MapDict.partitionU(m.data, p);
  return --[[ tuple ]]{
          do
            cmp: cmp,
            data: match[0]
          end,
          do
            cmp: cmp,
            data: match[1]
          end
        };
end end

function partition(m, p) do
  return partitionU(m, Curry.__2(p));
end end

function mapU(m, f) do
  return do
          cmp: m.cmp,
          data: Belt_MapDict.mapU(m.data, f)
        end;
end end

function map(m, f) do
  return mapU(m, Curry.__1(f));
end end

function mapWithKeyU(m, f) do
  return do
          cmp: m.cmp,
          data: Belt_MapDict.mapWithKeyU(m.data, f)
        end;
end end

function mapWithKey(m, f) do
  return mapWithKeyU(m, Curry.__2(f));
end end

function size(map) do
  return Belt_MapDict.size(map.data);
end end

function toList(map) do
  return Belt_MapDict.toList(map.data);
end end

function toArray(m) do
  return Belt_MapDict.toArray(m.data);
end end

function keysToArray(m) do
  return Belt_MapDict.keysToArray(m.data);
end end

function valuesToArray(m) do
  return Belt_MapDict.valuesToArray(m.data);
end end

function minKey(m) do
  return Belt_MapDict.minKey(m.data);
end end

function minKeyUndefined(m) do
  return Belt_MapDict.minKeyUndefined(m.data);
end end

function maxKey(m) do
  return Belt_MapDict.maxKey(m.data);
end end

function maxKeyUndefined(m) do
  return Belt_MapDict.maxKeyUndefined(m.data);
end end

function minimum(m) do
  return Belt_MapDict.minimum(m.data);
end end

function minUndefined(m) do
  return Belt_MapDict.minUndefined(m.data);
end end

function maximum(m) do
  return Belt_MapDict.maximum(m.data);
end end

function maxUndefined(m) do
  return Belt_MapDict.maxUndefined(m.data);
end end

function get(map, x) do
  return Belt_MapDict.get(map.data, x, map.cmp);
end end

function getUndefined(map, x) do
  return Belt_MapDict.getUndefined(map.data, x, map.cmp);
end end

function getWithDefault(map, x, def) do
  return Belt_MapDict.getWithDefault(map.data, x, def, map.cmp);
end end

function getExn(map, x) do
  return Belt_MapDict.getExn(map.data, x, map.cmp);
end end

function has(map, x) do
  return Belt_MapDict.has(map.data, x, map.cmp);
end end

function checkInvariantInternal(m) do
  return Belt_MapDict.checkInvariantInternal(m.data);
end end

function eqU(m1, m2, veq) do
  return Belt_MapDict.eqU(m1.data, m2.data, m1.cmp, veq);
end end

function eq(m1, m2, veq) do
  return eqU(m1, m2, Curry.__2(veq));
end end

function cmpU(m1, m2, vcmp) do
  return Belt_MapDict.cmpU(m1.data, m2.data, m1.cmp, vcmp);
end end

function cmp(m1, m2, vcmp) do
  return cmpU(m1, m2, Curry.__2(vcmp));
end end

function getData(prim) do
  return prim.data;
end end

function getId(m) do
  cmp = m.cmp;
  return do
          cmp: cmp
        end;
end end

function packIdData(id, data) do
  return do
          cmp: id.cmp,
          data: data
        end;
end end

Int = --[[ alias ]]0;

__String = --[[ alias ]]0;

Dict = --[[ alias ]]0;

exports.Int = Int;
exports.__String = __String;
exports.Dict = Dict;
exports.make = make;
exports.isEmpty = isEmpty;
exports.has = has;
exports.cmpU = cmpU;
exports.cmp = cmp;
exports.eqU = eqU;
exports.eq = eq;
exports.findFirstByU = findFirstByU;
exports.findFirstBy = findFirstBy;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.size = size;
exports.toArray = toArray;
exports.toList = toList;
exports.fromArray = fromArray;
exports.keysToArray = keysToArray;
exports.valuesToArray = valuesToArray;
exports.minKey = minKey;
exports.minKeyUndefined = minKeyUndefined;
exports.maxKey = maxKey;
exports.maxKeyUndefined = maxKeyUndefined;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getWithDefault = getWithDefault;
exports.getExn = getExn;
exports.remove = remove;
exports.removeMany = removeMany;
exports.set = set;
exports.updateU = updateU;
exports.update = update;
exports.mergeMany = mergeMany;
exports.mergeU = mergeU;
exports.merge = merge;
exports.keepU = keepU;
exports.keep = keep;
exports.partitionU = partitionU;
exports.partition = partition;
exports.split = split;
exports.mapU = mapU;
exports.map = map;
exports.mapWithKeyU = mapWithKeyU;
exports.mapWithKey = mapWithKey;
exports.getData = getData;
exports.getId = getId;
exports.packIdData = packIdData;
exports.checkInvariantInternal = checkInvariantInternal;
--[[ No side effect ]]
