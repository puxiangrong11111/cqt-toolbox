function L = logm(A)
%LOGM Matrix logarithm of a CQT matrix. 
%
% L = LOGM(A) returns the matrix logarithm of the CQT matrix A. 

%
% Padé approximant of degree [11/11]: 
%
p = [ 4.843027953388525e-07     4.275890756798910e-05, ...
      1.045667247937630e-03     1.142870048958800e-02, ...
      6.765539815075419e-02     2.383696615275563e-01, ...
      5.225541969401618e-01     7.191919191919192e-01, ...
      6.040404040404040e-01     2.828282828282828e-01, ...
      5.656565656565657e-02     0];

q = [ 8.018583869977059e-08     1.058453070836972e-05 ...
      3.439972480220158e-04     4.815961472308222e-03 ...
      3.611971104231166e-02     1.618163054695562e-01 ...
      4.584795321637427e-01     8.421052631578947e-01 ...
      1.000000000000000e+00     7.407407407407407e-01 ...
      3.111111111111111e-01     5.656565656565657e-02 ];
  
nrm = norm(A - cqt(1,1, [], [], A.sz(1), A.sz(2)));
r = 1;

while nrm > .5
    A = sqrtm(A);
    nrm = norm(A - cqt(1, 1, [], [], A.sz(1), A.sz(2)));
    r = 2 * r;
end

A = A - cqt(1, 1, [], [], A.sz(1), A.sz(2));

if isinf(max(A.sz))
    L = polyvalm(q, A) \ polyvalm(p, A);
else
    L = inv(polyvalm(q, A)) * polyvalm(p, A);
end

% Scaling
L = r * L;

end

