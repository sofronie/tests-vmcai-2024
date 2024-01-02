; start Z3 with flag -smt2
(set-option :produce-unsat-cores true)
; (set-option :sat.core.minimize true)
; (set-option :smt.core.minimize true)


(declare-sort point)
(declare-const a point)
(declare-const b point)
(declare-const c point)
(declare-const d point)
(declare-const e point)
(declare-fun left (point point point) Bool)
(declare-fun intersection (point point point point) Bool)
(declare-fun inside (point point point point) Bool)
(declare-fun next (point) point)
(declare-fun V (point) Bool)
(declare-fun E (point point) Bool)
(declare-fun F (point point) Bool)
(declare-fun deleting (point point point point) Bool)



;used formula A1-6, I1-6, I11-16, T1-4, E1-3, F1-5, R1, C1, D1-5, D11-14

(assert (! (forall ((u point) (v point) (w point)) (=> (and (left u v w) (left v u w)) (not (left w u v)))) :named A1))   
;if  w is left of uv and w is left of vu, then v is not left of wu     
(assert (! (forall ((u point) (v point) (w point)) (=> (and (not (= u w)) (not (= v w)) (not (left w u v)) (not (left w v u))) (left u v w))) :named A2))  
;if v is not left of wu and u is not left of wv, then w is left of uv (and also left of vu and therefore w is between uv)
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v w) (left v u w) (left u x w)) (left u x v))) :named A3))
;if w is between u and v and w is left of ux, then v is also left of ux 
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v w) (left v u w) (left u x v)) (left u x w))) :named A4))
;if w is between u and v and v is left of ux, then w is also left of ux 
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v w) (left v w u) (left w u v)) (or (left u v x) ( left v w x) ( left w u x)))) :named A5))
;If w is left of uv, u is left uf vw and v is left of wu, then x is left of uv, vw or wu.
(assert (! (forall ((u point) (v point) (w point) (x point) (y point) (z point)) (=> (and (left u v z) (left v w z) (left w u z) (left x y u) (left x y v) (left x y w)) (left x y z))) :named A6))
;If all 3 vertices u,v,w of a triangle are located left of a line yz, then also the point inside the triangle is left of this line. 




;condition for a possible inersection
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (intersection u v w x) (or (not (= u w)) (not (= v x))))) :named I1))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (intersection u v w x) (or (not (= u x)) (not (= v w))))) :named I2))

(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (intersection u v w x) (or (left u v w) (left u v x)))) :named I3))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (intersection u v w x) (or (left v u x) (left v u w)))) :named I4))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (intersection u v w x) (or (left w x u) (left w x v)))) :named I5))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (intersection u v w x) (or (left x w v) (left x w u)))) :named I6))

(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v w) (left v u x) (left w x u) (left x w v)) (or (= u x) (intersection u v w x)))) :named I11))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v w) (left v u x) (left w x u) (left x w v)) (or (= v w) (intersection u v w x)))) :named I12))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v w) (left v u x) (left w x v) (left x w u)) (intersection u v w x))) :named I13))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v x) (left v u w) (left w x u) (left x w v)) (intersection u v w x))) :named I14))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v x) (left v u w) (left w x v) (left x w u)) (or (= u w) (intersection u v w x)))) :named I15))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (left u v x) (left v u w) (left w x v) (left x w u)) (or (= v x) (intersection u v w x)))) :named I16))



;condition for vertices inside a triangle
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (inside u v w x) (left u v x))) :named T1))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (inside u v w x) (left v w x))) :named T2))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (inside u v w x) (left w u x))) :named T3))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and ( left u v x) (left v w x) (left w u x )) (inside u v w x))) :named T4))
;a vertex x is inside the traingle uvw iff it is left of uv, vw and wu.
;(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and ( left u v x) (left v w x) (left w u x )) (inside v w u x))) :named T5))
;(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and ( left u v x) (left v w x) (left w u x )) (inside w u v x))) :named T6))
;The triangles uvw, vwu and wuv are equivalent


;condition on edges
(assert (! (forall ((u point)) (not (E u u ))) :named E1))
(assert (! (forall ((u point) (v point)) (=> (E u v) (E v u))) :named E2))
(assert (! (forall ((u point) (v point)) (=> (E u v) (V u))) :named E3))

;redundancy property
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (E u v) (E w x) (intersection u v w x )) (or (E u w) (E v x)))) :named R1))

;coexistence property
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (E u v) (E v w) (E w u) (V x) (inside u v w x )) (E u x))) :named C1))

;conditions for the connected and intersection-free subgraph F
(assert (! (forall ((u point) (v point)) (=> (F u v) (F v u))) :named F1))
;F is symmetric
(assert (! (forall ((u point) (v point)) (=> (F u v) (E u v))) :named F2))
;F is a subset of E
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (F u v) (F w x)) (not (intersection u v w x)))) :named F3))
;edges in F do not intersect
(assert (! (forall ((u point) (v point) (w point)) (=> (and (left u v w) (left v u w) (V w)) (not (F u v)))) :named F4))
;no vertex can be located on an edge of F
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (F u v) (E w x) (intersection u v w x)) (or (E u w) (E v w)))) :named F5))
;(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (F u v) (E w x) (intersection u v w x)) (or (E u x) (E v x)))) :named F6))
;CP-Condition (only one of F5 and F6 is needed due to symmetry)

;conditions for the predicate deleting
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (deleting u v w x) (E u v))) :named D1))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (deleting u v w x) (E w x))) :named D2))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (deleting u v w x) (intersection u v w x))) :named D3))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (deleting u v w x) (E u w))) :named D4))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (deleting u v w x) (E v w))) :named D5))
;If wx delets uv, then the edges uw and vw exist.

(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (E u w) (E u x) (deleting u v w x)) (F w x))) :named D11))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (E v w) (E v x) (deleting u v w x)) (F w x))) :named D12))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (E u v) (E w x) (intersection u v w x)) (or (deleting u v x w) (E u w) (E v w)))) :named D13))
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (intersection u v w x) (E u v) (F w x) (E u w) (E v w)) (deleting u v w x))) :named D14))


;The negation of the conclusion (but then the "conjectures" part should be left empty).


(assert (! (left a b c) :named Q1))
;(assert (! (left a c b) :named Q2))
(assert (! (left b a c) :named Q3))
;(assert (! (left b c a) :named Q4))
;(assert (! (left c a b) :named Q5))
;(assert (! (left c b a) :named Q6))

;(assert (! (not (left a b c)) :named Q11))
;(assert (! (not (left a c b)) :named Q12))
;(assert (! (not (left b a c)) :named Q13))
;(assert (! (not (left b c a)) :named Q14))
;(assert (! (not (left c a b)) :named Q15))
;(assert (! (not (left c b a)) :named Q16))


;(assert (! (not (= a b )) :named Q21))
;(assert (! (not (= a c )) :named Q22))
;(assert (! (not (= b c)) :named Q23))

;(assert (! (left a a b) :named Q31))
;(assert (! (left a b a) :named Q32))
;(assert (! (not (left a b b)) :named Q33))

;(assert (! (left a b d) :named Q41))
(assert (! (left a c d) :named Q42))
;(assert (! (left c a d) :named Q43))
;(assert (! (left c b d) :named Q44))
;(assert (! (left c d a) :named Q45))
;(assert (! (left d b a) :named Q46))


(assert (! (not (left a b d)) :named Q51))
;(assert (! (not (left a c d)) :named Q52))
;(assert (! (not (left b a d)) :named Q53))
;(assert (! (not (left b d a)) :named Q54))
;(assert (! (not (left d b c)) :named Q55))
;(assert (! (not (left d c a)) :named Q56))


(check-sat)
(get-unsat-core)
;(get-model)

