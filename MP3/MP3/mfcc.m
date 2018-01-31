function CC = mfcc(signal, Ncc, varargin)
% Compute Mel Frequency Cepstral Coefficients (MFCCs) for speech signals
%
% INPUTS:
% signal: speech signal (a vector)
% Ncc:  Number of cepstral coefficients
% Nw: Window size in samples
% No: Overlap size in samples
% Fs: Sampling frequency
% M: Number of Mel scale filters in the filterbank
% R:  [a b], lower(a) and upper(b) cut-off freqs of the filterbank
% alpha: Preemphasis filter coefficient ( H(z) = 1 - alpha*z^(-1) )
%
% OUTPUTS:
% CC: Matrix of MFCCs. Size [Ncc x Nf], where Nf = # frames obtained 
% from the speech signal using the window and overlap method. See
% sig2frames(). Ncc = # cepstral coefficients.
%
% References:
%
% [1] Young, S., Evermann, G., Gales, M., Hain, T., Kershaw, D., 
%     Liu, X., Moore, G., Odell, J., Ollason, D., Povey, D., 
%     Valtchev, V., Woodland, P., 2006. The HTK Book (for HTK 
%     Version 3.4.1). Engineering Department, Cambridge University.
%     (see also: http://htk.eng.cam.ac.uk)
% 
% [2] Huang, X., Acero, A., Hon, H., 2001. Spoken Language Processing: 
%       A guide to theory, algorithm, and system development. 
%       Prentice Hall, Upper Saddle River, NJ, USA (pp. 314-315).
% 
%
% Authors: Amit Das
% Copyright (c) 2017-2020
% 
% Author                     Date              Summary 
% amitdas@illinois.edu       09/2017           Created
%


[Nw, No, Fs, M, R, alpha] = process_options(varargin, 'Nw', varargin{1}, 'No', varargin{2}, 'Fs', varargin{4}, 'M', 26, 'R', varargin{5}, 'alpha', 0.97);

i = 1;
while 2^i < Nw
    i = i + 1;
end
NFFT = 2.^i;
%disp(NFFT)
K = NFFT/2 + 1;            
                                   
% Preemphasis filtering
signal = filter([1 -alpha], 1, signal);

% Convert signal to frames
frames = sig2frames(signal, Nw, No);
[~, Nf] = size(frames); % Nf = number of frames

% Construct Mel filterbank
%[H, f] = melfilterbank(M, K, R, Fs); % H = [M x K]. Each row is a filter of K freq points in [0, Fs/2]
%plot(f, H);
%xlabel('Frequency (Hz)'); ylabel('Weight');

% Compute average magnitude spectra
X1 = abs(fft(frames, NFFT));
 % X = [NFFT x Nf]. Each column is a spectrum with NFFT frequencies
X2 = X1./NFFT;

X = zeros(K, Nf);

for t = 1 : K
    X(t, :) = X2(t, :);
end

[a, b] = size(X);


%figure();
%plot(X)
% Apply Mel filterbank to spectra
[H, f] = melfilterbank(M, K, R, Fs) ; % Y should be of size = [M x Nf]
%figure();
%plot(f, H)
%[a, b] = size(H);
%disp(a)
%disp(b)
%[m, n] = size(X);
%disp(m)
%disp(n)
Y = H * X;
%disp(M)
%figure();
%plot(Y)
%[a, b] = size(Y);
%disp(a)
%disp(b)
% Apply IDCT on log Mel filterbank energies (~ Fourier Transform of
% log spectrum) to get cepstral coefficients (CCs). CCs should be decorrelated.
CC1 = idct(log(max(1e-6, Y))) ;

% Take only first Ncc coefficients since higher order coeffs are too small.
CC2 = CC1(1:Ncc, :) ;
CC = CC2(:);

end