function J =rank1(X)

global T Y_i;

Ls = [X(1)*X(3) 1*X(3)];
Ms = [X(2) 1];
Ys = step(Ls, Ms, T);
J = sum((Ys - Y_i).^2);

end