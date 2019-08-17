(* Dan's reduction procedure *)

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

A[hin : H[a0_, alist_List, x_, alast_], i_, iset_List] := 
  Module[{anewlist}, (
    anewlist = 
     Table[If[MemberQ[iset, k], alist[[i]], alist[[k]]], {k, 1, 
       Length[alist]}];
    Return[H[a0, anewlist, x, alast]];
    )];

B[hin : H[a0_, alist_List, x_, alast_], i_] := Module[{range, sets}, (
    range = Range[1, Length[alist]] // DeleteCases[#, i] &;
    sets = Join[{i}, #] & /@ Subsets[range, {1, Infinity}];
    Return[Sum[(-1)^Length[s] A[hin, i, s], {s, sets}]];
    )];

leadingReduce[hin : H[a0_, alist_List, x_, alast_], y_] := 
  Module[{leading, rest, resttail, resthead, anewlists}, (
    leading = TakeWhile[alist, # === y &];
    rest = Drop[alist, Length[leading]];
    If[rest == {},
     Return[0];
     ];
    
    resttail = Drop[rest, 1];
    resthead = rest[[1]];
    anewlists = 
     Join[{resthead}, #] & /@ shuffleLists[leading, resttail];
    Return[(-1)^Length[leading] Sum[
       H[a0, l, x, alast], {l, anewlists}]];
    )];

leadingReduce[a_Plus, y_] := leadingReduce[#, y] & /@ a;
leadingReduce[lambda_ hin_H, y_] /; NumberQ[lambda] := 
 lambda leadingReduce[hin, y]

boundReduce[hin : H[a0_, alist_List, x_, alast_], y_] := Module[{}, (
    If[alist[[1]] =!= y,
     Return[H[y, alist, x, alast] - H[y, alist, x, a0]],
     Return[hin]
     ]
    )];

boundReduce[a_Plus, y_] := boundReduce[#, y] & /@ a;
boundReduce[lambda_ hin_H, y_] /; NumberQ[lambda] := 
 lambda boundReduce[hin, y]
boundReduce[0, y_] := 0;

Breduce[hin : H[a0_, alist_List, x_, alast_], i_] := 
  Module[{range, sets}, (
    range = Range[1, Length[alist]] // DeleteCases[#, i] &;
    sets = Join[{i}, #] & /@ Subsets[range, {1, Infinity}];
    Return[
     Sum[(-1)^Length[s] boundReduce[
        leadingReduce[A[hin, i, s], alist[[i]]], alist[[i]]], {s, 
       sets}]];
    )];

Drel[hin : H[a0_, alist_List, x_, alast_], i_] := Breduce[hin, i];

Dtranspose[hin : H[a0_, alist_List, x_, alast_], i_, j_] := 
  Module[{alist0, ai, aj, alist1, alist2}, (
    alist0 = alist;
    ai = alist[[i]];
    aj = alist[[j]];
    
    alist1 = alist;
    alist1[[i]] = x;
    alist2 = alist1;
    alist2[[j]] = ai;
    
    Return[
     Drel[H[a0, alist0, x, alast], i] - 
      Drel[H[a0, alist1, ai, alast], j] + 
      Drel[H[a0, alist2, aj, alast], i]];
    )];

Asymb[n_, i_, j_] /; 1 <= i && i < j && j <= n := 
 H[a[0], {Sequence @@ #[[1 ;; i - 1]], a[1], 
     Sequence @@ #[[i ;; j - 2]], a[2], 
     Sequence @@ #[[j - 1 ;; All]]} &@Table[a[k], {k, 3, n}], x, 
  a[n + 1]]

Asymb[n_, i_] /; 1 <= i && i <= n := 
 H[a[0], {Sequence @@ #[[1 ;; i - 1]], a[1], 
     Sequence @@ #[[i ;; All]]} &@Table[a[k], {k, 2, n}], x, a[n + 1]]

R[n_, im_, j_, i_, j_] /; i - im == 1 := 
  Dtranspose[Asymb[n, im, j], im, i];
R[n_, 1, j_, 1, jp_] /; jp - j == 1 := 
  Dtranspose[Asymb[n, 1, j], j, jp];

c[n_, im_, j_, i_, j_] /; i - im == 1 := If[OddQ[i - j], 1, 0];
c[n_, 1, j_, 1, j2_] /; 
  j2 - j == 1 := (-1)^(j) (Floor[n/2] - Floor[j/2])

R[n_, i_] := Dtranspose[Asymb[n, i], i, i + 1]

reduceAll[n_] := 
 1/Floor[n/
     2] * (-Sum[
      c[n, i - 1, j, i, j] R[n, i - 1, j, i, j], {i, 2, n}, {j, 
       i + 1, n}] + 
    Sum[c[n, 1, j, 1, j + 1] R[n, 1, j, 1, j + 1], {j, 2, n - 1}])

reduceOdd[n_] /; OddQ[n] := Sum[-R[n, i], {i, 2, n, 2}]

(* Routines to reduce hyperlogs to MPLs with CCR arguments *)

cri[{a_, b_, c_, d_}] /; a == c || b == d := 0

crOrbit[{a_, b_, c_, d_}] := 
 Sort[{{a, b, c, d}, {b, a, d, c}, {c, d, a, b}, {d, c, b, a}}][[1]]

ccrToCr[{cri[l_List]}] := 
  cri[Join[l[[1 ;; 3]], {#}]] & /@ l[[4 ;; All]];
ccrToCr[l_List] := l

iToCcr[hin : IIi[ind_List, arg_List]] := Module[{}, (
    If[Length[Union[arg[[All, 1, 1 ;; 3]]]] == 1,
     Return[
      IIi[ind, {cri[Join[arg[[1, 1, 1 ;; 3]], arg[[All, 1, 4]]]]}]],
     Return[IIi[ind, arg]]]
    )];
iToCcr[lambda_ hin_IIi] /; NumberQ[lambda] := lambda iToCcr[hin];
iToCcr[a_Plus] :=  iToCcr[#] & /@ a;

hToI[hin : H[0, alist_, Infinity, 1]] := Module[{pos, ind, arg}, (
    pos = 
     Complement[Range[1, Length[alist]], 
      Position[alist, el_ /; el === 0, 1][[All, 1]]];
    arg = alist[[pos]];
    pos = Join[pos, {Length[alist] + 1}];
    ind = Differences[pos];
    Return[IIi[ind, arg]]
    )];
hToI[lambda_ hin_H] /; NumberQ[lambda] := lambda hToI[hin];
hToI[a_Plus] :=  hToI[#] & /@ a;

hCrSimp[hin : H[a0_, alist_List, x_, alast_]] := Module[{}, (
    Return[H[0, cri[{x, a0, alast, #}] & /@ alist, Infinity, 1]]
    )];
hCrSimp[lambda_ hin_H] /; NumberQ[lambda] := lambda hCrSimp[hin];
hCrSimp[a_Plus] :=  hCrSimp[#] & /@ a;

indices[expr_] := 
  If[Head[expr] === IIi, Return[expr[[1]]], 
   Cases[expr, IIi[ind_, arg_] :> ind][[1]]];

args[expr_] := 
  If[Head[expr] === IIi, Return[expr[[2]]], 
   Cases[expr, IIi[ind_, arg_] :> arg][[1]]];

denominator[expr_] := 
  If[Head[expr] === IIi, Return[1], 
   Cases[{expr}, q_?NumericQ w_IIi :> Denominator[q]][[1]]];