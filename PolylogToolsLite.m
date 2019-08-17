GatherCiTiList[expr_] := 
  Block[{temp = Expand[expr]}, 
   temp = GatherBy[List @@ CollectCiTi[temp, 1], Last];
   temp = CleanUp /@ temp;
   Return[temp];];
CleanUp[list_List] := {list[[1, 2]], Total[list[[All, 1]]]}
CollectCiTi[sum_Plus, a_] := CollectCiTi[#, a] & /@ sum;
CollectCiTi[a_. ct_CiTi | a_. ct_CiTiWedge | a_. ct_CiTiWedgeX, b_] :=
   CollectCiTi[a, ct b];
CollectCiTi[sum_Plus, a_] := CollectCiTi[#, a] & /@ sum;
CollectCiTi[a_. ct_CiTi | a_. ct_CiTiWedge | a_. ct_CiTiWedgeX, b_] :=
   CollectCiTi[a, ct b];
CleanUp[list_List] := {list[[1, 2]], Total[list[[All, 1]]]}

shuffleLists[s1_, s2_] := 
 Module[{ss, sr, s1l, s2l, p, pp, tp, 
   pres}, {ss, sr} = {Join[s1, s2], 
    Range@((s1l = Length@s1) + (s2l = Length@s2))};
  p = Permutations[Join[ConstantArray[1, s1l], ConstantArray[0, s2l]]];
  pp = (Accumulate@Transpose[p] // Transpose) p;
  tp = Clip[p, {1, 0}, {1, 0}];
  pres = pp + 
    Clip[(Accumulate@Transpose[tp] // Transpose) tp + s1l, {s1l + 1, 
      Max[sr]}, {0, 0}];
  ss[[#]] & /@ pres]

symbolFlatShuffle[a_symbolFlat, b_symbolFlat] := 
 add @@ (symbolFlat @@@ shuffleLists[List @@ a, List @@ b])

(* --------- *)

Format[CiTi[l___], StandardForm] := CircleTimes[l]
Format[CiTiWedge[l___], StandardForm] := Wedge[l]

makelabel[node_] := 
  Module[{a, b, 
    c}, (c = ({(node /. CircleTimes -> List)[[1]]} // Flatten)[[1, 1]];
    b = ({(node /. CircleTimes -> List)[[-1]]} // Flatten)[[1, 1]];
    a = ({(node /. CircleTimes -> List)[[-1]]} // Flatten)[[-1, -1]];
    If[a === c, Return[1]];
    If[a === b, Return[1/(c - b)]];
    If[b === c, Return[(a - b)/1]];
    Return[(a - b)/(c - b)])];

symbolFlat[a_, symbolFlat[b___]] := symbolFlat[a, b]
symbolFlat[a_, symbolFlat[c___], symbolFlat[b___]] := 
 symbolFlat[a, symbolFlatShuffle[symbolFlat[b], symbolFlat[c]]]

symbolFlat[a_, b_add] := symbolFlat[a, #1] & /@ b
symbolFlat[a_, b_add, c_] := symbolFlat[a, #1, c] & /@ b
symbolFlat[a_, b_, c_add] := symbolFlat[a, b, #1] & /@ c

SetAttributes[bracketings, {Flat, OneIdentity}]
e : CircleTimes[___, _List, ___] := Distribute[Unevaluated[e], List]

symbolG[inputarguments___, 1] := 
  Module[{fullarguments, labelindex, labels, parenthesizedlist, 
    trees, treeswithlabel, symbolTerms, tensor}, (
    fullarguments = Join[{0}, Reverse[{inputarguments}], {1}];
    labels = 
     lab @@@ Table[{fullarguments[[labelindex]], 
        fullarguments[[labelindex + 1]]}, {labelindex, 1, 
        Length[fullarguments] - 1}];
    parenthesizedlist = (bracketings @@ (Range[
           Length[labels]])) //. {bracketings[x__] :> 
         ReplaceList[bracketings[x], 
          bracketings[u_, v_] :> CircleTimes[u, v]]} // Flatten;
    trees = parenthesizedlist /. {x_Integer :> labels[[x]]};
    treeswithlabel = ((trees //. 
         CircleTimes[leftbranch_, rightbranch_] :> 
          symbol[makelabel[{leftbranch, rightbranch}], leftbranch, 
           rightbranch])) /. {lab[___] :> Sequence[]};
    symbolTerms = treeswithlabel /. symbol -> symbolFlat;
    tensor = 
     Plus @@ ((symbolTerms /. {symbolFlat -> CiTi, add -> List}) // 
        Flatten);
    Return[tensor // ReduceCiTiList // torsionCiTi // flatCiTi]
    )];

CreateTensor[expr_] := expr /. G -> symbolG;

expandProducts[
   expr_] := (expr /. 
    Times[CiTi[l___], CiTi[m__]] :> 
     Plus @@ (CiTi @@@ shuffleLists[{l}, {m}]));
factorCiTi[expr_] := expr /. CiTi[l___] :> CiTi @@ Factor[{l}];
torsionCiTi[expr_] := expr /. CiTi[___, 1 | -1, ___] :> 0
flatCiTi[expr_] := 
 expr /. CiTi[l___] :> CiTi @@ (Sort[Factor[{-#, #}]][[2]] & /@ {l})
ReduceCiTiList[
   expr_] := (expr /. (CiTi[l___] :> 
        CiTiRed @@ (FactorList[#][[2 ;; All]] & /@ {l})) /. 
     CiTiRed -> CiTi) // Expand;

flatTensor = flatCiTi;

CiTiRed[a___, b_List, c___] := 
  Plus @@ (#[[2]] CiTiRed[a, #[[1]], c] & /@ (b));

CiTiSadd[a___, b_Plus, c___] := CiTiSadd[a, #, c] & /@ b
CiTiSadd[a___, Times[lambda_, b_CiTiSadd], c___]  := 
  lambda CiTiSadd[a, b, c];
CiTiSadd[a___, 0, c___]  := 0;

CiTiDadd[a___, b_Plus, c___] := CiTiDadd[a, #, c] & /@ b
CiTiDadd[a___, Times[lambda_, b_CiTi], c___]  := 
  lambda CiTiDadd[a, b, c];
CiTiDadd[a___, 0, c___]  := 0;

CiTiSh[a_, b_] := 1/2 CiTiSadd[a, b] - 1/2 CiTiSadd[b, a]
CiTiSh[a_, l__, 
   b_] := ((Length[{a, l, b}] - 1)/
      Length[{a, l, b}]) (CiTiSadd[CiTiSh[a, l], b] - 
      CiTiSadd[CiTiSh[l, b], a]) // Expand;

CiTiSh[a_] := 0;

CiTiWedge[a___, b_Plus, c___] := CiTiWedge[a, #, c] & /@ b
CiTiWedge[a___, Times[lambda_, b_CiTiWedge | b_CiTi], c___]  := 
  lambda CiTiWedge[a, b, c];
CiTiWedge[___, 0, ___] := 0;
CiTiWedge[l___] /; Sort[{l}] =!= {l} := 
 Signature[{l}] CiTiWedge @@ Sort[{l}]
CiTiWedge[___, a_, l___, a_, ___] := 0

SetAttributes[CiTiFlat, {Flat}];

SetAttributes[CiTiWedgeFlat, {Flat}];

sh[expr_] := (expr // Expand) /. {Times[a_CiTi, b_CiTi, ___] :> 0, 
     CiTi[l__] :> CiTiSh @@ (CiTiEl /@ {l})} /. {CiTiEl -> Identity, 
    CiTiSadd -> CiTiFlat} /. CiTiFlat -> CiTi

CiTiDel[{l___}] := Block[{t = {l}}, (
     split = Table[{Take[t, k], Drop[t, k]}, {k, 2, Length[t] - 2}];
    split = Map[flatTensor[sh[CiTi @@ #]] &, split, {2}];
    split = Plus @@ Apply[CiTiDadd, split, {1}];
    Return[split /. CiTiDadd -> CiTiWedge];
    )];

del[expr_] := ((expr // Expand) /. 
     CiTi[l___] :> (CiTiDel[CiTiEl /@ {l}]) /. {CiTiEl -> Identity}) //
   Expand