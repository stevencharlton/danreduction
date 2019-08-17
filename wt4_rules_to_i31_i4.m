rule22to13and31 = 
  IIi[{2, 2}, {cri[{a_, b_, c_, d_, e_}]}] :> (
   - IIi[{1, 3}, {cri[{a, b, c, d, e}]}] 
   - IIi[{3, 1}, {cri[{a, b, c, d, e}]}]  
   - IIi[{1, 3}, {cri[{a, b, c, e, d}]}] );
    
rule13to31 = 
  IIi[{1, 3}, {cri[{a_, b_, c_, d_, e_}]}] :> (
  - IIi[{3, 1}, {cri[{b, a, d, c, e}]}] 
  + IIi[{4}, {cri[{a, b, c, d}]}] );

rule31to22 = 
  IIi[{3, 1}, {cri[{a_, b_, c_, d_, e_}]}] :> 
  (- 1/2 IIi[{2, 2}, {cri[{a, b, c, d, e}]}] + 1/2 IIi[{2, 2}, {cri[{a, b, c, e, d}]}]);