global Zp F;
F = [0.02 0.04 0.06 0.08 0.2 0.8];
A = [2.5 2.29 1.98 1.74 0.846 0.222];
Fi= [-16.33 -32.91 -40.45 -48.92 -73.34 -84.04];

for n= 1:6
    Zp(n) = A(n)*cosd(Fi(n))+1j*A(n)*sind(Fi(n));    
end
 
Xo = [0.1 1];
X = fminsearch('czest', Xo);

Ls = [X(1)];
Ms = [X(2) 1];
sys = tf(Ls,Ms);
Zs =  freqresp(sys,F);
Rs = real(Zp(:,:));
Is = imag(Zp(:,:));
plot(Rs, Is, real(Zp(:,:)),imag(Zp(:,:)),'r.');
bode(sys)
grid on;
disp(Ls);
disp(Ms);

roots(Ls)
roots(Ms)