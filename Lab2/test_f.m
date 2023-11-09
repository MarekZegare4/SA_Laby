function J = test_f(X1)

global F1 Z1;

Ls = [X1(1) X1(2)];
Ms = [X1(3) X1(4) 0];
%Ls = [X1(1)];
%Ms = [X1(2) X1(3) X1(4) 0];
Tf = feedback(tf([Ls],[Ms]), 1);
[m, p, w] = bode(Tf, F1);

zesp = m(:) .* exp(1i*deg2rad(p(:))); % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((P.' - p).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((Y_b.' - m).^2);                 % Dopasowanie do charakterystyki amplitudowej
J = sum((imag(Z1.' - zesp)).^2 + (real(Z1.' - zesp).^2)); % Super fajna metoda na liczbach zespolonych
end