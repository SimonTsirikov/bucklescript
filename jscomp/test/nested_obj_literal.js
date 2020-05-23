'use strict';


var structural_obj = do
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

exports.structural_obj = structural_obj;
exports.f_record = f_record;
--[ No side effect ]--
