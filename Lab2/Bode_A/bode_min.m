function J = bode_min(X)

global DANE ZFULL uklad k;

%[Ti a1 a2 k_2 k]

a1 = 2.392e-7;
a2 = 6.403e-4;
% Ti = 1.3e-3;
% k=[0.35 0.7 1.05];
% k = 0.47 +k/2;

kc = k(uklad);

Ti = X(1);
k_2 = X(2);

%k_2 =1; 
Tf = tf(kc*k_2,[Ti*a1 Ti*a2 Ti 0]);
Tf = feedback(Tf,1);
[m,p]=bode(Tf, DANE(uklad));

A = squeeze([m,p]);

zesp = A(1) .* exp(1i*deg2rad(A(2))); % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((P.' - p).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((Y_b.' - m).^2);                 % Dopasowanie do charakterystyki amplitudowej
J = sum((imag(ZFULL(uklad) - zesp)).^2 + (real(ZFULL(uklad) - zesp).^2)); % Super fajna metoda na liczbach zespolonych
end