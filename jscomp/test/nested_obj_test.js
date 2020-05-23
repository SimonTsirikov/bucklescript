'use strict';


var f = do
  x: do
    y: do
      z: 3
    end
  end
end;

var f2_000 = --[ :: ]--[
  do
    x: do
      y: do
        z: 3
      end
    end
  end,
  --[ :: ]--[
    do
      x: do
        y: do
          z: 31
        end
      end
    end,
    --[ [] ]--0
  ]
];

var f2_001 = [
  do
    x: do
      y: do
        z: 3
      end
    end
  end,
  do
    x: do
      y: do
        z: 31
      end
    end
  end
];

var f2 = --[ tuple ]--[
  f2_000,
  f2_001
];

var f3 = do
  x: do
    y: do
      z: 3
    end
  end
end;

var f_record = do
  x: do
    y: do
      z: 3
    end
  end
end;

exports.f_record = f_record;
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
--[ No side effect ]--
