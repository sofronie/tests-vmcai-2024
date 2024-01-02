The counterexamples in this directory show that, without the 
coexistence property, the correctness of the CP-algorithm cannot 
be guaranteed. 


We show that counterexamples can be constructed, i.e. connected 
graphs with the property that after applying the CP-algorithm 
the resulting graph might not be connected.

==============================================
A) Generating graphs containing redundancy cycles
==============================================

- The test counterexample shows that a connected graph which does not 
   satisfy the coexistence property can contain a redundancy cycle of length 3.

- The test counterexample_length4 shows that a connected graph which does not 
   satisfy the coexistence property can contain a redundancy cycle of length 4.

In the same way, graphs with arbitrary long redundancy cycles can be constructed.

===============================================
B) Tests for examples of graphs with i vertices which do not remain 
     connected after the CP-algorithm is applied
===============================================

The tests for counterexamples with i vertices are starting with z3-test_counterexmple_ivertices

The tests were made with and without using the condition of Lemma1
(numbering as in the VMCAI 2024 paper), i.e. 
"every edge that is not in F is intersected by an edge of F".

- Tests including the condition of Lemma1 are starting with       
   z3-test_counterexmple_ivertices_F.

- Tests without the condition of Lemma1 are starting with   
   z3-test_counterexmple_ivertices_noLemma1.

If not further specified, the tests were made with a weak version of 
the coexistence property, where at least two of the coexistence edges
are supposed to to exist.

- If the coexistence property was completly droped, 
  the names of the test files contain the ending _withoutC1.

For the tests that do not use the condition of Lemma1 a counterexample 
with 6 vertices exists, if there are edges between colinear vertices with 
a vertex located on an edge.

This counterexample is not possible anymore if the edges between colinear 
vertices are refined, i.e for three colinear vertices u,v and w, where w is 
located between u and w, only the edges uw and wv can exist, but not uv.

- The test using this refinment property is called    
   z3-test_counterexmple_6vertices_noLemma1_refinment. 

==============================================
C) Counterexample to part 1 of the correctness proof.
==============================================

The test   proof_part1_without_coexistence 
shows that part1 of the corectness proof does not 
hold anymore if the coexistence property is droped. 
Z3 outputs a model as counterexample.
