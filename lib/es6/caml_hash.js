

import * as Caml_hash_primitive from "./caml_hash_primitive.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function push_back(q, v) do
  cell = do
    content: v,
    next: undefined
  end;
  match = q.last;
  if (match ~= undefined) then do
    q.length = q.length + 1 | 0;
    match.next = cell;
    q.last = cell;
    return --[ () ]--0;
  end else do
    q.length = 1;
    q.first = cell;
    q.last = cell;
    return --[ () ]--0;
  end end 
end

function unsafe_pop(q) do
  cell = q.first;
  next = cell.next;
  if (next == undefined) then do
    q.length = 0;
    q.first = undefined;
    q.last = undefined;
  end else do
    q.length = q.length - 1 | 0;
    q.first = next;
  end end 
  return cell.content;
end

function caml_hash(count, _limit, seed, obj) do
  hash = seed;
  if (typeof obj == "number") then do
    u = obj | 0;
    hash = Caml_hash_primitive.caml_hash_mix_int(hash, (u + u | 0) + 1 | 0);
    return Caml_hash_primitive.caml_hash_final_mix(hash);
  end else if (typeof obj == "string") then do
    hash = Caml_hash_primitive.caml_hash_mix_string(hash, obj);
    return Caml_hash_primitive.caml_hash_final_mix(hash);
  end else do
    queue = do
      length: 0,
      first: undefined,
      last: undefined
    end;
    num = count;
    push_back(queue, obj);
    num = num - 1 | 0;
    while(queue.length ~= 0 and num > 0) do
      obj$1 = unsafe_pop(queue);
      if (typeof obj$1 == "number") then do
        u$1 = obj$1 | 0;
        hash = Caml_hash_primitive.caml_hash_mix_int(hash, (u$1 + u$1 | 0) + 1 | 0);
        num = num - 1 | 0;
      end else if (typeof obj$1 == "string") then do
        hash = Caml_hash_primitive.caml_hash_mix_string(hash, obj$1);
        num = num - 1 | 0;
      end else if (typeof obj$1 ~= "boolean" and typeof obj$1 ~= "undefined") then do
        if (typeof obj$1 == "symbol") then do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "caml_hash.ml",
                  128,
                  8
                ]
              ];
        end
         end 
        if (typeof obj$1 ~= "function") then do
          size = obj$1.length;
          if (size ~= undefined) then do
            obj_tag = obj$1.tag | 0;
            tag = (size << 10) | obj_tag;
            if (tag == 248) then do
              hash = Caml_hash_primitive.caml_hash_mix_int(hash, obj$1[1]);
            end else do
              hash = Caml_hash_primitive.caml_hash_mix_int(hash, tag);
              v = size - 1 | 0;
              block = v < num and v or num;
              for i = 0 , block , 1 do
                push_back(queue, obj$1[i]);
              end
            end end 
          end
           end 
        end
         end 
      end
       end  end  end 
    end;
    return Caml_hash_primitive.caml_hash_final_mix(hash);
  end end  end 
end

export do
  caml_hash ,
  
end
--[ No side effect ]--
