A =  [0  2  2  3  4  5  4  3  5  6; 
    2  0  1  3  3  4  6  4  3  5; 
    2  1  0  4  5  3  2  4  1  7;
    3  3  4  0  2  4  5  3  5  2; 
    4  3  5  2  0  2  4  1  2  2; 
    5  4  3  4  2  0  3  2  1  3; 
    4  6  2  5  4  3  0  3  2  1; 
    3  4  4  3  1  2  3  0  5  3; 
    5  3  1  5  2  1  2  5  0  4; 
    6  5  7  2  2  3  1  3  4  0];
pobsize= 20; 
Pob = 10;
maxit = 1000; 
dfunc = 'distfunction';
[Hdist, MinDist] = tspgenetic(A, Pob, pobsize, maxit, dfunc)