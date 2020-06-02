console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
__Buffer = require "../../lib/js/buffer";
Printf = require "../../lib/js/printf";
Caml_obj = require "../../lib/js/caml_obj";
Caml_int64 = require "../../lib/js/caml_int64";
Caml_format = require "../../lib/js/caml_format";
CamlinternalLazy = require "../../lib/js/camlinternalLazy";

n0 = --[[ int64 ]]{
  --[[ hi ]]0,
  --[[ lo ]]0
};

n1 = --[[ int64 ]]{
  --[[ hi ]]0,
  --[[ lo ]]1
};

n2 = --[[ int64 ]]{
  --[[ hi ]]0,
  --[[ lo ]]2
};

n3 = --[[ int64 ]]{
  --[[ hi ]]0,
  --[[ lo ]]3
};

n5 = --[[ int64 ]]{
  --[[ hi ]]0,
  --[[ lo ]]5
};

$percent = Caml_int64.mod_;

$star = Caml_int64.mul;

$slash = Caml_int64.div;

$plus = Caml_int64.add;

digit = Caml_format.caml_int64_of_string("1000000000000000000");

function mul(n, param) do
  pl = param[0];
  return --[[ tuple ]]{
          Caml_int64.mod_(Caml_int64.mul(n, pl), digit),
          Caml_int64.add(Caml_int64.mul(n, param[1]), Caml_int64.div(Caml_int64.mul(n, pl), digit))
        };
end end

function cmp(param, param_1) do
  ph = param_1[1];
  nh = param[1];
  if (Caml_obj.caml_lessthan(nh, ph)) then do
    return -1;
  end else if (Caml_obj.caml_greaterthan(nh, ph)) then do
    return 1;
  end else do
    pl = param_1[0];
    nl = param[0];
    if (Caml_obj.caml_lessthan(nl, pl)) then do
      return -1;
    end else if (Caml_obj.caml_greaterthan(nl, pl)) then do
      return 1;
    end else do
      return 0;
    end end  end 
  end end  end 
end end

function x2(p) do
  return mul(n2, p);
end end

function x3(p) do
  return mul(n3, p);
end end

function x5(p) do
  return mul(n5, p);
end end

nn1 = --[[ tuple ]]{
  n1,
  n0
};

buf = __Buffer.create(5000);

function pr(param) do
  nh = param[1];
  nl = param[0];
  if (Caml_int64.compare(nh, n0) == 0) then do
    return Curry._1(Printf.bprintf(buf, --[[ Format ]]{
                    --[[ Int64 ]]Block.__(7, {
                        --[[ Int_d ]]0,
                        --[[ No_padding ]]0,
                        --[[ No_precision ]]0,
                        --[[ Char_literal ]]Block.__(12, {
                            --[[ "\n" ]]10,
                            --[[ End_of_format ]]0
                          })
                      }),
                    "%Ld\n"
                  }), nl);
  end else do
    return Curry._2(Printf.bprintf(buf, --[[ Format ]]{
                    --[[ Int64 ]]Block.__(7, {
                        --[[ Int_d ]]0,
                        --[[ No_padding ]]0,
                        --[[ No_precision ]]0,
                        --[[ Int64 ]]Block.__(7, {
                            --[[ Int_d ]]0,
                            --[[ Lit_padding ]]Block.__(0, {
                                --[[ Zeros ]]2,
                                18
                              }),
                            --[[ No_precision ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ "\n" ]]10,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    "%Ld%018Ld\n"
                  }), nh, nl);
  end end 
end end

function map(f, l) do
  return Caml_obj.caml_lazy_make((function(param) do
                match = CamlinternalLazy.force(l);
                return --[[ Cons ]]{
                        Curry._1(f, match[0]),
                        map(f, match[1])
                      };
              end end));
end end

function merge(cmp, l1, l2) do
  return Caml_obj.caml_lazy_make((function(param) do
                match = CamlinternalLazy.force(l1);
                match_1 = CamlinternalLazy.force(l2);
                ll2 = match_1[1];
                x2 = match_1[0];
                ll1 = match[1];
                x1 = match[0];
                c = Curry._2(cmp, x1, x2);
                if (c == 0) then do
                  return --[[ Cons ]]{
                          x1,
                          merge(cmp, ll1, ll2)
                        };
                end else if (c < 0) then do
                  return --[[ Cons ]]{
                          x1,
                          merge(cmp, ll1, l2)
                        };
                end else do
                  return --[[ Cons ]]{
                          x2,
                          merge(cmp, l1, ll2)
                        };
                end end  end 
              end end));
end end

function iter_interval(f, _l, _param) do
  while(true) do
    param = _param;
    l = _l;
    stop = param[1];
    if (stop == 0) then do
      return --[[ () ]]0;
    end else do
      start = param[0];
      match = CamlinternalLazy.force(l);
      if (start <= 0) then do
        Curry._1(f, match[0]);
      end
       end 
      _param = --[[ tuple ]]{
        start - 1 | 0,
        stop - 1 | 0
      };
      _l = match[1];
      ::continue:: ;
    end end 
  end;
end end

hamming = Caml_obj.caml_lazy_make((function(param) do
        return --[[ Cons ]]{
                nn1,
                merge(cmp, ham2, merge(cmp, ham3, ham5))
              };
      end end));

ham2 = Caml_obj.caml_lazy_make((function(param) do
        return CamlinternalLazy.force(map(x2, hamming));
      end end));

ham3 = Caml_obj.caml_lazy_make((function(param) do
        return CamlinternalLazy.force(map(x3, hamming));
      end end));

ham5 = Caml_obj.caml_lazy_make((function(param) do
        return CamlinternalLazy.force(map(x5, hamming));
      end end));

iter_interval(pr, hamming, --[[ tuple ]]{
      88000,
      88100
    });

Mt.from_pair_suites("Hamming_test", --[[ :: ]]{
      --[[ tuple ]]{
        "output",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      __Buffer.contents(buf),
                      "6726050156250000000000000000000000000\n6729216728661136606575523242669244416\n6730293634611118019721084375000000000\n6731430439413948088320000000000000000\n6733644878411293029785156250000000000\n6736815026358904613608094481682268160\n6739031236724077363200000000000000000\n6743282904874568941599068856042651648\n6744421903677486140423997176256921600\n6746640616477458432000000000000000000\n6750000000000000000000000000000000000\n6750897085400702945836103937453588480\n6752037370304563380023474956271616000\n6754258588364960445000000000000000000\n6755399441055744000000000000000000000\n6757621765136718750000000000000000000\n6758519863481752323552044362431792300\n6759661435938757375539248533340160000\n6761885162088395001166534423828125000\n6763027302973440000000000000000000000\n6765252136392518877983093261718750000\n6767294110289640371843415775641600000\n6768437164792816653010961694720000000\n6770663777894400000000000000000000000\n6774935403077748181101173538816000000\n6776079748261363229431903027200000000\n6778308875544000000000000000000000000\n6782585324034592562287109312160000000\n6783730961356018699387011072000000000\n6785962605658597412109375000000000000\n6789341568946838378906250000000000000\n6791390813820928754681118720000000000\n6794772480000000000000000000000000000\n6799059315411241693033267200000000000\n6800207735332289107722240000000000000\n6802444800000000000000000000000000000\n6806736475893120841673472000000000000\n6807886192552970708582400000000000000\n6810125783203125000000000000000000000\n6814422305043756994967597929687500000\n6815573319906622439424000000000000000\n6817815439391434192657470703125000000\n6821025214188390921278195662703296512\n6821210263296961784362792968750000000\n6823269127183128330240000000000000000\n6828727177473454717179297140960133120\n6830973624183426662400000000000000000\n6834375000000000000000000000000000000\n6835283298968211732659055236671758336\n6836437837433370422273768393225011200\n6838686820719522450562500000000000000\n6839841934068940800000000000000000000\n6842092037200927734375000000000000000\n6844157203887991842733489140006912000\n6845313241232438768082197309030400000\n6847565144260608000000000000000000000\n6849817788097425363957881927490234375\n6851885286668260876491458472837120000\n6853042629352726861173598715904000000\n6855297075118080000000000000000000000\n6859622095616220033364938208051200000\n6860780745114630269799801815040000000\n6863037736488300000000000000000000000\n6866455078125000000000000000000000000\n6867367640585024969315698178562000000\n6868527598372968933129348710400000000\n6870787138229329879760742187500000000\n6871947673600000000000000000000000000\n6874208338558673858642578125000000000\n6876283198993690364114632704000000000\n6879707136000000000000000000000000000\n6884047556853882214196183040000000000\n6885210332023942721568768000000000000\n6887475360000000000000000000000000000\n6891820681841784852194390400000000000\n6892984769959882842439680000000000000\n6895252355493164062500000000000000000\n6899602583856803957404692903808593750\n6900767986405455219916800000000000000\n6903038132383827120065689086914062500\n6906475391588173806667327880859375000\n6908559991272917434368000000000000000\n6912000000000000000000000000000000000\n6914086267191872901144038355222134784\n6916360794485719495680000000000000000\n6917529027641081856000000000000000000\n6919804687500000000000000000000000000\n6921893310401287552552190498140323840\n6924170405978516481194531250000000000\n6925339958244802560000000000000000000\n6927618187665939331054687500000000000\n6929709168936591740767657754256998400\n6930879656747844252683224775393280000\n6933159708563865600000000000000000000\n6937533852751614137447601703747584000\n6938705662219635946938268699852800000\n6940988288557056000000000000000000000\n6945367371811422783781999935651840000\n6946540504428563148172299337728000000\n6948825708194403750000000000000000000\n"
                    });
          end end)
      },
      --[[ [] ]]0
    });

exports = {}
exports.n0 = n0;
exports.n1 = n1;
exports.n2 = n2;
exports.n3 = n3;
exports.n5 = n5;
exports.$percent = $percent;
exports.$star = $star;
exports.$slash = $slash;
exports.$plus = $plus;
exports.digit = digit;
exports.mul = mul;
exports.cmp = cmp;
exports.x2 = x2;
exports.x3 = x3;
exports.x5 = x5;
exports.nn1 = nn1;
exports.buf = buf;
exports.pr = pr;
exports.map = map;
exports.merge = merge;
exports.iter_interval = iter_interval;
exports.hamming = hamming;
exports.ham2 = ham2;
exports.ham3 = ham3;
exports.ham5 = ham5;
--[[ digit Not a pure module ]]