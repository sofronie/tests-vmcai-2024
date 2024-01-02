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


;used formula A1-6, I1-6, I11-16, T1-4, E1-3, F1-5, R1, C1, D1-6, D11-16

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
;(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (E u v) (E w x) (intersection u v w x )) (or (E u w) (E v x)))) :named R1))

;coexistence property
(assert (! (forall ((u point) (v point) (w point) (x point)) (=> (and (E u v) (E v w) (E w u) (V x) (inside u v w x )) (E u x))) :named C1))


;The negation of the conclusion (but then the "conjectures" part should be left empty).



(assert (! (E a b) :named Q1))
(assert (! (E b c) :named Q2))
(assert (! (E c a) :named Q3))
(assert (! (inside a b c d) :named Q4))
(assert (! (inside a b c e) :named Q5))
(assert (! (V d) :named Q6))
(assert (! (V e) :named Q7))
(assert (! (not (E d e)) :named Q8))
(assert (! (not (= d e)) :named Q9))


(check-sat)
(get-unsat-core)
;(get-model)