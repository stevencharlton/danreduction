rule41to32 =
  IIi[{4, 1}, {cri[{a_, b_, c_, d_, e_}]}] :> 
    ( - 1/3 IIi[{3, 2}, {cri[{a, b, c, d, e}]}]
      - 1/3 IIi[{3, 2}, {cri[{a, b, c, e, d}]}] );

rule14to32 = 
  IIi[{1, 4}, {cri[{a_, b_, c_, d_, e_}]}] :>
    ( - 4 IIi[{5}, {cri[{a, b, c, e}]}]
      - IIi[{5}, {cri[{a, b, d, e}]}]
      - 1/3 IIi[{3, 2}, {cri[{a, b, d, c, e}]}]
      - 1/3 IIi[{3, 2}, {cri[{a, b, d, e, c}]}] );

rule23to32 =
 IIi[{2, 3}, {cri[{a_, b_, c_, d_, e_}]}] :>
  ( + IIi[{5}, {cri[{a, b, c, d}]}]
    - IIi[{3, 2}, {cri[{b, a, d, c, e}]}] );
   
rule221to311 =
  IIi[{2, 2, 1}, {cri[{a_, b_, c_, d_, e_, f_}]}] :>
    ( - IIi[{3, 1, 1}, {cri[{a, b, c, d, e, f}]}]
      - IIi[{3, 1, 1}, {cri[{a, b, c, d, f, e}]}]
      - IIi[{3, 1, 1}, {cri[{a, b, c, f, d, e}]}]
      - IIi[{3, 1, 1}, {cri[{a, b, c, f, e, d}]}] );

rule131to311 =
  IIi[{1, 3, 1}, {cri[{a_, b_, c_, d_, e_, f_}]}] :>
    IIi[{3, 1, 1}, {cri[{a, b, c, f, e, d}]}];

rule113to311 =
IIi[{1, 1, 3}, {cri[{a_, b_, c_, d_, e_, f_}]}] :> 
  ( + IIi[{3, 1, 1}, {cri[{a, b, d, c, f, e}]}]
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, e, f}]}]
    + 1/3 IIi[{3, 2}, {cri[{a, b, e, d, f}]}]
    + 1/3 IIi[{3, 2}, {cri[{a, b, e, c, f}]}]
    + 1/3 IIi[{3, 2}, {cri[{a, b, e, f, c}]}]
    + 1/3 IIi[{3, 2}, {cri[{b, a, f, e, c}]}]
    - 1/3 IIi[{3, 2}, {cri[{b, a, e, f, d}]}]
    - 1/3 IIi[{3, 2}, {cri[{b, a, e, f, c}]}]
    + 16/ 3 IIi[{5}, {cri[{a, b, f, c}]}]
    - 4/3 IIi[{5}, {cri[{a, b, e, c}]}]
    + 7/3 IIi[{5}, {cri[{a, b, e, f}]}]
    + 2 IIi[{5}, {cri[{a, b, d, f}]}]
    - 4/3 IIi[{5}, {cri[{a, b, d, e}]}] );

rule122to311 =
IIi[{1, 2, 2}, {cri[{a_, b_, c_, d_, e_, f_}]}] :> 
  ( - IIi[{3, 1, 1}, {cri[{a, b, c, f, e, d}]}]
    - IIi[{3, 1, 1}, {cri[{a, b, d, c, e, f}]}]
    - IIi[{3, 1, 1}, {cri[{a, b, d, c, f, e}]}]
    - IIi[{3, 1, 1}, {cri[{a, b, d, e, c, f}]}]
    - 2 IIi[{3, 2}, {cri[{a, b, c, e, f}]}]
    + IIi[{3, 2}, {cri[{a, b, c, f, e}]}]
    - 2 IIi[{3, 2}, {cri[{a, b, e, c, f}]}] 
    - IIi[{3, 2}, {cri[{a, b, e, f, d}]}]
    - IIi[{3, 2}, {cri[{a, b, f, e, d}]}]
    - 12 IIi[{5}, {cri[{a, b, c, f}]}]
    - 6 IIi[{5}, {cri[{a, b, d, e}]}]
    - 6 IIi[{5}, {cri[{a, b, d, f}]}]
    - 6 IIi[{5}, {cri[{a, b, e, f}]}] );

rule212to311 = IIi[{2, 1, 2}, {cri[{a_, b_, c_, d_, e_, f_}]}] :> 
  ( + IIi[{3, 1, 1}, {cri[{a, b, c, d, f, e}]}] 
    + IIi[{3, 1, 1}, {cri[{a, b, c, f, d, e}]}]
    + IIi[{3, 1, 1}, {cri[{a, b, c, f, e, d}]}]
    + IIi[{3, 1, 1}, {cri[{a, b, d, c, e, f}]}]
    + IIi[{3, 1, 1}, {cri[{a, b, d, e, c, f}]}]
    + IIi[{3, 1, 1}, {cri[{a, b, e, d, c, f}]}] 
    + IIi[{3, 2}, {cri[{a, b, c, d, f}]}]
    + 2 IIi[{3, 2}, {cri[{a, b, c, e, f}]}]
    - IIi[{3, 2}, {cri[{a, b, c, f, d}]}]
    - IIi[{3, 2}, {cri[{a, b, c, f, e}]}]
    + IIi[{3, 2}, {cri[{a, b, d, c, f}]}]
    + IIi[{3, 2}, {cri[{a, b, d, e, f}]}]
    + 2 IIi[{3, 2}, {cri[{a, b, e, c, f}]}]
    + IIi[{3, 2}, {cri[{a, b, e, d, f}]}]
    - IIi[{3, 2}, {cri[{a, b, e, f, c}]}]
    + 12 IIi[{5}, {cri[{a, b, c, f}]}]
    + 6 IIi[{5}, {cri[{a, b, d, f}]}]
    + 12 IIi[{5}, {cri[{a, b, e, f}]}] );
               
rule311to32 = IIi[{3, 1, 1}, {cri[{a_, b_, c_, d_, e_, f_}]}] :> 
  ( + 1/3 IIi[{3, 2}, {cri[{a, b, c, d, e}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, d, f}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, e, d}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, f, d}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, c, b, d, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, c, b, f, d}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, d, b, e, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, d, b, f, e}]}] 
    + 1/3 IIi[{3, 2}, {cri[{b, a, f, c, e}]}] 
    + 1/3 IIi[{3, 2}, {cri[{b, a, f, e, c}]}] 
    - 1/3 IIi[{3, 2}, {cri[{b, f, a, c, e}]}] 
    - 1/3 IIi[{3, 2}, {cri[{b, f, a, e, c}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, e}], cri[{a, c, b, d}]}]
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, e}], cri[{a, d, b, c}]}]
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, f}], cri[{a, d, c, b}]}]
    - 1/3 IIi[{3, 2}, {cri[{a, b, d, f}], cri[{a, e, b, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, b, e, f}], cri[{a, d, e, b}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, b, e, f}], cri[{a, e, d, b}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, c, b, d}], cri[{a, b, c, e}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, d, b, c}], cri[{a, b, c, e}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, d, b, c}], cri[{a, b, f, c}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, d, b, e}], cri[{a, b, f, e}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, d, b, f}], cri[{a, e, b, d}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, e, b, d}], cri[{a, b, f, e}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, e, b, d}], cri[{a, d, b, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, e, b, f}], cri[{a, b, d, f}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, b, c, d}], cri[{a, b, f, e}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, b, e, f}], cri[{a, b, d, c}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, b, e, f}], cri[{a, d, b, c}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, c, b, d}], cri[{a, e, c, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, c, b, d}], cri[{b, c, e, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, c, b, d}], cri[{b, e, c, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, c, d, f}], cri[{a, d, b, e}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, c, d, f}], cri[{a, e, b, d}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, c, d, f}], cri[{a, e, b, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, c, e, f}], cri[{a, d, b, c}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, c, e, f}], cri[{a, d, b, e}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, c, e, f}], cri[{a, e, b, d}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, d, b, c}], cri[{a, b, e, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, d, b, c}], cri[{a, c, e, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, d, b, e}], cri[{a, c, d, f}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, d, b, e}], cri[{a, c, e, f}]}] 
    - 1/3 IIi[{3, 2}, {cri[{a, e, b, d}], cri[{a, c, d, f}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, e, b, d}], cri[{a, c, e, f}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, e, b, f}], cri[{a, c, d, f}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, e, c, f}], cri[{a, c, b, d}]}] 
    + 1/3 IIi[{3, 2}, {cri[{a, f, b, e}], cri[{b, c, d, f}]}] 
    + 1/3 IIi[{3, 2}, {cri[{b, c, d, f}], cri[{a, f, b, e}]}] 
    - 1/3 IIi[{3, 2}, {cri[{b, c, e, f}], cri[{a, c, b, d}]}] 
    - 1/3 IIi[{3, 2}, {cri[{b, e, c, f}], cri[{a, c, b, d}]}] );