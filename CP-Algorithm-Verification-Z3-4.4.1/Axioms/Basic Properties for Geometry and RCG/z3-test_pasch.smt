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
(declare-fun colinear (point point point) Bool)



;used formula A1-6, I1-6, I11-16, T1-4
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



;The negation of the conclusion (but then the "conjectures" part should be left empty).



(assert (! (not (= a b)) :named Q1))
(assert (! (not (= a c)) :named Q2))
(assert (! (not (= b c)) :named Q3))
(assert (! (not (= c d)) :named Q4))
(assert (! (not (= c e)) :named Q5))

(assert (! (not (inside a b c d)) :named Q11))
(assert (! (not (inside a b c e)) :named Q12))
(assert (! (not (inside a c b d)) :named Q13))
(assert (! (not (inside a c b e)) :named Q14))


(assert (! (intersection a b d e) :named Q21))
(assert (! (not (intersection a c d e)) :named Q22))
(assert (! (not (intersection b c d e)) :named Q23))

(check-sat)
(get-unsat-core)
;(get-model)