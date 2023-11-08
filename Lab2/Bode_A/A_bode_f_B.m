function J = A_bode_f_B(X)

global F2 Y2 P2 Z2;

Ls = [X(1)];
Ms = [X(2) X(3) X(4) X(5)];
Tf = tf([Ls], [Ms]);
[m, p, w] = bode(Tf, F2);

zesp = m(:) .* exp(1i*deg2rad(p(:))); % zamiana amplitudy i fazy na liczby zespolone

% J = sum((P.' - p).^2 + (Y.' - m).^2); % Dopasowanie do obu charakterystyk
% J = sum((P.' - p).^2);                 % Dopasowanie do charakterystyki fazowej
% J = sum((Y_b.' - m).^2);                 % Dopasowanie do charakterystyki amplitudowej
J = sum((imag(Z2.' - zesp)).^2 + (real(Z2.' - zesp).^2)); % Super fajna metoda na liczbach zespolonych
end