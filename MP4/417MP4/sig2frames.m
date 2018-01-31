function frames = sig2frames(signal, Nw, No)
% Convert a speech signal to frames using the window and overlap method
% Default window used is a Hamming window.
%
% INPUTS:
% signal: speech signal (a vector)
% Nw: window size in number of samples
% No: overlap size in number of samples
% 
% OUTPUTS:
% frames: Matrix of frames [Nw x Nf]. Each column is a frame of length Nw samples.
% There are Nf such frames. Nf is computed from signal, Nw, and No.
%
% 

signal = signal(:);
len = length(signal);
Nf  = floor( (len - No)/(Nw - No) );
frames = zeros(Nw, Nf);

win = @hamming;
for i = 1:Nf
   start_sample = round(Nw * (i - 1) * 0.9 + 1) ; % Every length, we start our window.
    end_sample =   round(Nw * i - (No * (i-1))); % Every length+m, we end our window.
    window = signal(start_sample : end_sample, 1);
    frames(:, i) = window .* win(Nw) ; 
end

end