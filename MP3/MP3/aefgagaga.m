%%%%%%%%%%RAW SPEAKER RECOGNITION%%%%%%%%%
raw_vals_speaker = zeros(2,5);
for x = 1:2 %iterates through k values
    for z = 1:5 %iterates through digits
        for y = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
                raw_vals_speaker(x, z) = speakerrecognitionaccuracy(digits(z), new_lc, knums(x), ppl(y), instances(a));
            end
        end
    end
end

disp('Cepstrum');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('A1:        ');
disp('A2:        ');
disp('A3:        ');
disp('A4:        ');
disp('A5:        ');
disp('Avg:        ');
disp(raw_vals_speech(:,1));

disp('MFCC');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('A1:        ');
disp('A2:        ');
disp('A3:        ');
disp('A4:        ');
disp('A5:        ');
disp('Avg:        ');

disp('Cepstrum');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('B1:        ');
disp('B2:        ');
disp('B3:        ');
disp('B4:        ');
disp('B5:        ');
disp('Avg:        ');

disp('MFCC');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('B1:        ');
disp('B2:        ');
disp('B3:        ');
disp('B4:        ');
disp('B5:        ');
disp('Avg:        ');

disp('Cepstrum');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('C1:        ');
disp('C2:        ');
disp('C3:        ');
disp('C4:        ');
disp('C5:        ');
disp('Avg:        ');

disp('MFCC');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('C1:        ');
disp('C2:        ');
disp('C3:        ');
disp('C4:        ');
disp('C5:        ');
disp('Avg:        ');

disp('Cepstrum');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('D1:        ');
disp('D2:        ');
disp('D3:        ');
disp('D4:        ');
disp('D5:        ');
disp('Avg:        ');

disp('MFCC');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('D1:        ');
disp('D2:        ');
disp('D3:        ');
disp('D4:        ');
disp('D5:        ');
disp('Avg:        ');

disp('Cepstrum');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('A1:        ');
disp('A2:        ');
disp('A3:        ');
disp('A4:        ');
disp('A5:        ');
disp('Avg:        ');

disp('MFCC');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('A1:        ');
disp('A2:        ');
disp('A3:        ');
disp('A4:        ');
disp('A5:        ');
disp('Avg:        ');

disp('Cepstrum');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('B1:        ');
disp('B2:        ');
disp('B3:        ');
disp('B4:        ');
disp('B5:        ');
disp('Avg:        ');

disp('MFCC');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('B1:        ');
disp('B2:        ');
disp('B3:        ');
disp('B4:        ');
disp('B5:        ');
disp('Avg:        ');

disp('Cepstrum');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('C1:        ');
disp('C2:        ');
disp('C3:        ');
disp('C4:        ');
disp('C5:        ');
disp('Avg:        ');

disp('MFCC');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('C1:        ');
disp('C2:        ');
disp('C3:        ');
disp('C4:        ');
disp('C5:        ');
disp('Avg:        ');

disp('Cepstrum');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('D1:        ');
disp('D2:        ');
disp('D3:        ');
disp('D4:        ');
disp('D5:        ');
disp('Avg:        ');

disp('MFCC');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
disp('D1:        ');
disp('D2:        ');
disp('D3:        ');
disp('D4:        ');
disp('D5:        ');
disp('Avg:        ');


