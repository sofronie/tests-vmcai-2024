The tests in this directory correspond to the parts and steps in the correctness proof.

- The tests of part1 prove that for an edge u1v1 which is not in the 
   intersection-free subgraph (V, F), always an intersecting edge 
   with u1v1 exists. 

- The tests of part2 show that a sequence of this intersecting edges 
  cannot be cyclic and therefore always one of the intersecting edges 
  is in F after the termination of the algorithm.

- The tests of part3 show that if the resulting graph after applying 
  the CP-algorithm is not connected and has components X and Y, 
  where X is connected and no edge exists in the resulting graph 
  with one vertex in X and one in Y,
  then there exists a sequence of edges in the initial graph
  connecting the components X and Y which cannot be cyclic.

- The test for the convex hull shows that for an edge u1v1 and an
  intersecting edge w1x1∈ F  with intersection point q closest to u1,
  no edge ab ∈ F can intersect with an edge of the convex hull
  of the vertices contained in the triangle u1qw1.



