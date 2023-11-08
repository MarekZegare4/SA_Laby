function J =rank2(X)

global T Y;

Ls = [1];
Ms = [X(1) X(2) 1];
Ys = step(Ls, Ms, T);
J = sum((Ys - Y).^2);

end