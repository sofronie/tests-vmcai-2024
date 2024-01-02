# tests-vmcai-2024

Tests: Automated Verification of the Correctness of a Subgraph Construction Algorithm
======================================================================================

We present the details of the tests we made. 
The tests were made using the SMT-solver Z3
- <b>first with Z3-4.4.1 on an Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz, 8192K cache.</b> <br>
  These are the tests described in the VMCAI 2024 paper [1], and are included <br>
  in the folder <b>CP-Algorithm-Verification</b>.  <p>
- <b>then with Z3-4.4.1 and Z3-4.8.15 on a 12th Gen Intel(R) Core(TM) i5-12400 CPU @ max 5.6GHz, 18MiB cache.</b> <br>
  These tests are described in the extended version of the VMCAI 2024 paper, which appeared in CORR [2] and are 
  included in the folders <b>CP-Algorithm-Verification-Z3-4.4.1</b> and <b>CP-Algorithm-Verification-Z3-4.8.15</b>  

The folders contains the following subdirectories: 

Files for the axiom system/testing independence
------------------------------------------------
- <b>Subdirectory Axioms:</b> Files for the axiom system
   - Basic properties of the axioms system
   - Relation to axiom system of Hilbert and Tarski

- <b>Subdirectort IndependenceConsistence:</b> Independence of the axioms

Verification of the correctness proof
-------------------------------------
- <b> Subdirectory Proof:</b> Tests of the corectness proof
   - FILES
   - README

- <b> Subdirectory Counterexamples:</b> Counterexamples in a modified axiom system
   - FILES
   - README <p>
  (in <b>CP-Algorithm-Verification-Z3-4.4.1</b> and <b>CP-Algorithm-Verification-Z3-4.8.15</b>
   we included more counterexamples, which are described also in the extended version of the paper).


[1] Lucas Böltz, Viorica Sofronie-Stokkermans, Hannes Frey:
    On the Verification of the Correctness of a Subgraph Construction Algorithm. 
    In: Dimitrova, R., Lahav, O., Wolff, S. (eds) 
    Verification, Model Checking, and Abstract Interpretation. VMCAI 2024. 
    Lecture Notes in Computer Science, vol 14499. Springer, Cham. 
    https://doi.org/10.1007/978-3-031-50524-9_14
    
[2] Lucas Böltz, Viorica Sofronie-Stokkermans, Hannes Frey:
    On the Verification of the Correctness of a Subgraph Construction Algorithm. 
    CoRR abs/2311.17860 (2023)
