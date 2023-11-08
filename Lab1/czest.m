function J = czest(X)
 
global Zp F;
Ls = [X(1)];
Ms = [X(2) 1];
 
sys = tf(Ls,Ms);
Zs =  freqresp(sys,F);
Rs = real(Zs(:,:));
Is = imag(Zs(:,:));
J = sum((real(Zp(:,:))-Rs).^2+(imag(Zp(:,:))-Is).^2);
end