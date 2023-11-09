function J = test_f_2(X1)

global F2 Z2 Y2;

Ls = [X1(1)*(-0.001431) X1(1)];
Ms = [X1(2)*0.0002309*13e-3 X1(2)*13e-3 0];
%Ls = [X1(1)];
%Ms = [X1(2) X1(3) X1(4) 0];
Tf = feedback(tf([Ls],[Ms]), 1);
[m, p, w] = bode(Tf, F2);

zesp = m(:) .* exp(1i*deg2rad(p(:))); % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((P.' - p).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((Y2.' - m(:)).^2);                 % Dopasowanie do charakterystyki amplitudowej
 J = sum((imag(Z2.' - zesp)).^2 + (real(Z2.' - zesp).^2)); % Super fajna metoda na liczbach zespolonych
end