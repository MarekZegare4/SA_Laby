function y =min_proj(X)

    
global t Yt


Ys  = step(tf([X(1) X(2) X(3)],[X(4) X(5) X(6) 0]),t);

y =sum((Ys-Yt).^2 );

end