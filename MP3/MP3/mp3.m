function mp3(datadir)
datadir = 'speechdata';
%data = cell(1, 100);
data = zeros(10000, 100);
tracker  = 1;
yabuddy = zeros(10000,100);
cdm = zeros(2, 100); %contains data except for instances 
for i = 65: 68
    for j = 1:5
        for k = 97:101
        AudName = strcat(datadir, filesep, char(i), int2str(j), char(k), '.wav');
        %[data(:, tracker), Fs] = imresize(audioread(AudName),[10000,1]);
        [data, Fs] = audioread(AudName);
        data = imresize(data(:, 1), [10000,1]);
        %disp(Fs)
        cdm(1,tracker) = char(i);
        cdm(2, tracker) = j;
        yabuddy(:,tracker) = data;
        tracker = tracker + 1;
        end
    end
end
Fs = 22050;
%data = data';

%lc = data(:, 1);
%lc = lc';
%new_lc = imresize(lc, [10000, 1]);
Nw = 10000;
No = Nw * 0.1;
Ncc= 12;

cep_sig_100 = zeros(12, 100);
mfcc_sig_100 = zeros(12, 100);
for j = 1:100
    CC = cepstrum(yabuddy(:, j), Ncc, Nw, No);
    cep_sig_100(:, j) = CC;
    MFCC = mfcc(yabuddy(:, j), Ncc, 'Nw', Nw, 'No', No, 'M', 26, 'Fs', Fs, 'R', [0 Fs/2]);
    mfcc_sig_100(:, j) = MFCC;
end

Nw = 10000;
No = Nw * 0.1;
Ncc= 12;

cep_sig_500 = zeros(12, 100);
mfcc_sig_500 = zeros(12, 100);
for j = 1:100
    CC = cepstrum(yabuddy(:, j), Ncc, Nw, No);
    cep_sig_500(:, j) = CC;
    MFCC = mfcc(yabuddy(:, j), Ncc, 'Nw', Nw, 'No', No, 'M', 26, 'Fs', Fs, 'R', [0 Fs/2]);
    mfcc_sig_500(:, j) = MFCC;
end

Nw = 10000;
No = Nw * 0.1;
Ncc= 12;

cep_sig_10000 = zeros(12, 100);
mfcc_sig_10000 = zeros(12, 100);
for j = 1:100
    CC = cepstrum(yabuddy(:, j), Ncc, Nw, No);
    cep_sig_10000(:, j) = CC;
    MFCC = mfcc(yabuddy(:, j), Ncc, 'Nw', Nw, 'No', No, 'M', 26, 'Fs', Fs, 'R', [0 Fs/2]);
    mfcc_sig_10000(:, j) = MFCC;
end

%x = sig2frames(new_lc, Nw, No);


knums = [1,5];
digits = [1,2,3,4,5];
people_idx = [1, 26, 51, 76];
ppl = [char(65), char(66), char(67), char(68)];
instances = [char(97), char(98), char(99), char(100), char(101)];

%%%%%%%%%%CEPSTRUM SPEECH RECOGNITION%%%%%%%%%
val = 1;
num = 0;
raw_vals_speech = zeros(5,2);

for q = 1:2 %iterates through k values
   for p = 1:4 %iterates through starting indices
        for z = 1:5 %iterates through digits
          for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = yabuddy;
               while(val <= 99)
                    feat = yabuddy(:, val);
                    val = val + 1;
               end
               if val <=25 
                    for x = 1:25
                        A(:, x) = [];
                    end
               elseif val <=50 && val > 25
                    for x = 26:50
                    A(:, x) = [];
                    end
               elseif val <=75 && val > 50
                    for x = 51:75
                    A(:, x) = [];
                    end
               else
                    for x = 76:100
                    A(:, 176-x) = [];
                    end
        
               end
    
            B = knnspeech(feat, A, knums(q), cdm);
           
            if(B == digits(z))
                num = num + 1;
            end
            %percent = (num./20) * 100;
          end
                
          raw_vals_speech(z,q) = num + raw_vals_speech(z, q);
        end
    end
end
for t = 1:2
    for r = 1:5
        raw_vals_speech(r,t) = raw_vals_speech(r,t) * 5 ;
    end
end

%%%%%%%%%%CEPSTRUM SPEECH RECOGNITION%%%%%%%%%
val = 1;
num = 0;
cep100_vals_speech = zeros(5,2);

for q = 1:2 %iterates through k values
   for p = 1:4 %iterates through starting indices
        for z = 1:5 %iterates through digits
          for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = cep_sig_100;
               while(val <= 99)
                    feat = cep_sig_100(:, val);
                    val = val + 1;
               end
               if val <=25 
                    for x = 1:25
                        A(:, x) = [];
                    end
               elseif val <=50 && val > 25
                    for x = 26:50
                    A(:, x) = [];
                    end
               elseif val <=75 && val > 50
                    for x = 51:75
                    A(:, x) = [];
                    end
               else
                    for x = 76:100
                    A(:, 176-x) = [];
                    end
        
               end
    
            B = knnspeech(feat, A, knums(q), cdm);
           
            if(B == digits(z))
                num = num + 1;
            end
            percent = (num./20) * 100;
          end
                
          cep100_vals_speech(z,q) = percent + cep100_vals_speech(z, q);
        end
    end
end
for t = 1:2
    for r = 1:5
        cep100_vals_speech(r,t) = cep100_vals_speech(r,t) ./ 20 ;
    end
end

%%%%%%%%%%CEPSTRUM SPEECH RECOGNITION%%%%%%%%%
val = 1;
num = 0;
cep500_vals_speech = zeros(5,2);

for q = 1:2 %iterates through k values
   for p = 1:4 %iterates through starting indices
        for z = 1:5 %iterates through digits
          for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = cep_sig_500;
               while(val <= 99)
                    feat =cep_sig_500(:, val);
                    val = val + 1;
               end
               if val <=25 
                    for x = 1:25
                        A(:, x) = [];
                    end
               elseif val <=50 && val > 25
                    for x = 26:50
                    A(:, x) = [];
                    end
               elseif val <=75 && val > 50
                    for x = 51:75
                    A(:, x) = [];
                    end
               else
                    for x = 76:100
                    A(:, 176-x) = [];
                    end
        
               end
    
            B = knnspeech(feat, A, knums(q), cdm);
           
            if(B == digits(z))
                num = num + 1;
            end
            percent = (num./20) * 100;
          end
                
          cep500_vals_speech(z,q) = percent + cep500_vals_speech(z, q);
        end
    end
end
for t = 1:2
    for r = 1:5
        cep500_vals_speech(r,t) = cep500_vals_speech(r,t) ./ 20 ;
    end
end

%%%%%%%%%%CEPSTRUM SPEECH RECOGNITION%%%%%%%%%
val = 1;
num = 0;
cep10000_vals_speech = zeros(5,2);

for q = 1:2 %iterates through k values
   for p = 1:4 %iterates through starting indices
        for z = 1:5 %iterates through digits
          for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = cep_sig_10000;
               while(val <= 99)
                    feat = cep_sig_10000(:, val);
                    val = val + 1;
               end
               if val <=25 
                    for x = 1:25
                        A(:, x) = [];
                    end
               elseif val <=50 && val > 25
                    for x = 26:50
                    A(:, x) = [];
                    end
               elseif val <=75 && val > 50
                    for x = 51:75
                    A(:, x) = [];
                    end
               else
                    for x = 76:100
                    A(:, 176-x) = [];
                    end
        
               end
    
            B = knnspeech(feat, A, knums(q), cdm);
           
            if(B == digits(z))
                num = num + 1;
            end
            percent = (num./20) * 100;
          end
                
          cep10000_vals_speech(z,q) = percent + cep10000_vals_speech(z, q);
        end
    end
end
for t = 1:2
    for r = 1:5
        cep10000_vals_speech(r,t) = cep10000_vals_speech(r,t) ./ 20 ;
    end
end

val = 1;
num = 0;
mfcc100_vals_speech = zeros(6,2);
for q = 1:2 %iterates through k values
   for z = 1:5 %iterates through digits
        for p = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = mfcc_sig_100;
               while(val <= 99)
                feat = mfcc_sig_100(:, val);
                val = val + 1;
               end
                if val <=20 
                    for x = 1:20
                    A(:, x) = [];
                    end
                elseif val <=40 && val > 20
                    for x = 21:40
                    A(:, x) = [];
                    end
                elseif val <=60 && val > 40
                    for x = 41:60
                    A(:, x) = [];
                    end
                elseif val <=80 && val > 60
                    for x = 61:80
                    A(:,x) = [];
                    end
                else
                    for x = 81:100
                    A(:, 176-x) = [];
                    end
                end
            B = knnspeaker(feat, A, knums(q), cdm);
            if(B == ppl(p))
                num = num + 1;
            end
            end
          
          mfcc100_vals_speech(p,q) = num + mfcc100_vals_speech(p, q);
        end
    end
end

val = 1;
num = 0;
mfcc500_vals_speech = zeros(6,2);
for q = 1:2 %iterates through k values
   for z = 1:5 %iterates through digits
        for p = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = mfcc_sig_100;
               while(val <= 99)
                feat = mfcc_sig_100(:, val);
                val = val + 1;
               end
                if val <=20 
                    for x = 1:20
                    A(:, x) = [];
                    end
                elseif val <=40 && val > 20
                    for x = 21:40
                    A(:, x) = [];
                    end
                elseif val <=60 && val > 40
                    for x = 41:60
                    A(:, x) = [];
                    end
                elseif val <=80 && val > 60
                    for x = 61:80
                    A(:,x) = [];
                    end
                else
                    for x = 81:100
                    A(:, 176-x) = [];
                    end
                end
            B = knnspeaker(feat, A, knums(q), cdm);
            if(B == ppl(p))
                num = num + 1;
            end
            end
          
          mfcc500_vals_speech(p,q) = num + mfcc500_vals_speech(p, q);
        end
    end
end

val = 1;
num = 0;
mfcc10000_vals_speech = zeros(6,2);
for q = 1:2 %iterates through k values
   for z = 1:5 %iterates through digits
        for p = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = mfcc_sig_100;
               while(val <= 99)
                feat = mfcc_sig_100(:, val);
                val = val + 1;
               end
                if val <=20 
                    for x = 1:20
                    A(:, x) = [];
                    end
                elseif val <=40 && val > 20
                    for x = 21:40
                    A(:, x) = [];
                    end
                elseif val <=60 && val > 40
                    for x = 41:60
                    A(:, x) = [];
                    end
                elseif val <=80 && val > 60
                    for x = 61:80
                    A(:,x) = [];
                    end
                else
                    for x = 81:100
                    A(:, 176-x) = [];
                    end
                end
            B = knnspeaker(feat, A, knums(q), cdm);
            if(B == ppl(p))
                num = num + 1;
            end
            end
          
          mfcc10000_vals_speech(p,q) = num + mfcc10000_vals_speech(p, q);
        end
    end
end


%%%%%%%%%%RAW SPEAKER RECOGNITION%%%%%%%%%
val = 1;
num = 0;
raw_vals_speaker = zeros(4,2);
for q = 1:2 %iterates through k values
   for z = 1:5 %iterates through digits
        for p = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = yabuddy;
               while(val <= 99)
                feat = yabuddy(:, val);
                val = val + 1;
               end
                if val <=20 
                    for x = 1:20
                    A(:, x) = [];
                    end
                elseif val <=40 && val > 20
                    for x = 21:40
                    A(:, x) = [];
                    end
                elseif val <=60 && val > 40
                    for x = 41:60
                    A(:, x) = [];
                    end
                elseif val <=80 && val > 60
                    for x = 61:80
                    A(:,x) = [];
                    end
                else
                    for x = 81:100
                    A(:, 176-x) = [];
                    end
                end
            B = knnspeaker(feat, A, knums(q), cdm);
            if(B == ppl(p))
                num = num + 1;
            end
            end
          
          raw_vals_speaker(p,q) = num + raw_vals_speaker(p, q);
        end
    end
end

val = 1;
num = 0;
cep10000_vals_speaker = zeros(5,2);

for q = 1:2 %iterates through k values
   for p = 1:4 %iterates through starting indices
        for z = 1:5 %iterates through digits
          for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = cep_sig_10000;
               while(val <= 99)
                    feat = cep_sig_10000(:, val);
                    val = val + 1;
               end
               if val <=25 
                    for x = 1:25
                        A(:, x) = [];
                    end
               elseif val <=50 && val > 25
                    for x = 26:50
                    A(:, x) = [];
                    end
               elseif val <=75 && val > 50
                    for x = 51:75
                    A(:, x) = [];
                    end
               else
                    for x = 76:100
                    A(:, 176-x) = [];
                    end
        
               end
    
            B = knnspeech(feat, A, knums(q), cdm);
           
            if(B == digits(z))
                num = num + 1;
            end
            percent = (num./20) * 100;
          end
                
          cep10000_vals_speaker(z,q) = percent + cep10000_vals_speaker(z, q);
        end
    end
end
for t = 1:2
    for r = 1:5
        cep10000_vals_speaker(r,t) = cep10000_vals_speaker(r,t) ./ 20 ;
    end
end

val = 1;
num = 0;
cep100_vals_speaker = zeros(5,2);

for q = 1:2 %iterates through k values
   for p = 1:4 %iterates through starting indices
        for z = 1:5 %iterates through digits
          for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = cep_sig_100;
               while(val <= 99)
                    feat = cep_sig_100(:, val);
                    val = val + 1;
               end
               if val <=25 
                    for x = 1:25
                        A(:, x) = [];
                    end
               elseif val <=50 && val > 25
                    for x = 26:50
                    A(:, x) = [];
                    end
               elseif val <=75 && val > 50
                    for x = 51:75
                    A(:, x) = [];
                    end
               else
                    for x = 76:100
                    A(:, 176-x) = [];
                    end
        
               end
    
            B = knnspeech(feat, A, knums(q), cdm);
           
            if(B == digits(z))
                num = num + 1;
            end
            percent = (num./20) * 100;
          end
                
          cep100_vals_speaker(z,q) = percent + cep100_vals_speaker(z, q);
        end
    end
end
for t = 1:2
    for r = 1:5
        cep100_vals_speaker(r,t) = cep100_vals_speaker(r,t) ./ 20 ;
    end
end

val = 1;
num = 0;
cep500_vals_speaker = zeros(5,2);

for q = 1:2 %iterates through k values
   for p = 1:4 %iterates through starting indices
        for z = 1:5 %iterates through digits
          for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = cep_sig_500;
               while(val <= 99)
                    feat = cep_sig_500(:, val);
                    val = val + 1;
               end
               if val <=25 
                    for x = 1:25
                        A(:, x) = [];
                    end
               elseif val <=50 && val > 25
                    for x = 26:50
                    A(:, x) = [];
                    end
               elseif val <=75 && val > 50
                    for x = 51:75
                    A(:, x) = [];
                    end
               else
                    for x = 76:100
                    A(:, 176-x) = [];
                    end
        
               end
    
            B = knnspeech(feat, A, knums(q), cdm);
           
            if(B == digits(z))
                num = num + 1;
            end
            percent = (num./20) * 100;
          end
                
          cep500_vals_speaker(z,q) = percent + cep500_vals_speaker(z, q);
        end
    end
end
for t = 1:2
    for r = 1:5
        cep500_vals_speaker(r,t) = cep500_vals_speaker(r,t) ./ 20 ;
    end
end


%%%%%%%%%%RAW SPEAKER RECOGNITION%%%%%%%%%
val = 1;
num = 0;
mfcc100_vals_speaker = zeros(4,2);
for q = 1:2 %iterates through k values
   for z = 1:5 %iterates through digits
        for p = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = mfcc_sig_100;
               while(val <= 99)
                feat = mfcc_sig_100(:, val);
                val = val + 1;
               end
                if val <=20 
                    for x = 1:20
                    A(:, x) = [];
                    end
                elseif val <=40 && val > 20
                    for x = 21:40
                    A(:, x) = [];
                    end
                elseif val <=60 && val > 40
                    for x = 41:60
                    A(:, x) = [];
                    end
                elseif val <=80 && val > 60
                    for x = 61:80
                    A(:,x) = [];
                    end
                else
                    for x = 81:100
                    A(:, 176-x) = [];
                    end
                end
            B = knnspeaker(feat, A, knums(q), cdm);
            if(B == ppl(p))
                num = num + 1;
            end
            end
          
          mfcc100_vals_speaker(p,q) = num + mfcc100_vals_speaker(p, q);
        end
    end
end

%%%%%%%%%%RAW SPEAKER RECOGNITION%%%%%%%%%
val = 1;
num = 0;
mfcc500_vals_speaker = zeros(4,2);
for q = 1:2 %iterates through k values
   for z = 1:5 %iterates through digits
        for p = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = mfcc_sig_500;
               while(val <= 99)
                feat = mfcc_sig_500(:, val);
                val = val + 1;
               end
                if val <=20 
                    for x = 1:20
                    A(:, x) = [];
                    end
                elseif val <=40 && val > 20
                    for x = 21:40
                    A(:, x) = [];
                    end
                elseif val <=60 && val > 40
                    for x = 41:60
                    A(:, x) = [];
                    end
                elseif val <=80 && val > 60
                    for x = 61:80
                    A(:,x) = [];
                    end
                else
                    for x = 81:100
                    A(:, 176-x) = [];
                    end
                end
            B = knnspeaker(feat, A, knums(q), cdm);
            if(B == ppl(p))
                num = num + 1;
            end
            end
          
          mfcc500_vals_speaker(p,q) = num + mfcc500_vals_speaker(p, q);
        end
    end
end

%%%%%%%%%%RAW SPEAKER RECOGNITION%%%%%%%%%
val = 1;
num = 0;
mfcc10000_vals_speaker = zeros(4,2);
for q = 1:2 %iterates through k values
   for z = 1:5 %iterates through digits
        for p = 1:4 %iterates through starting indices
            for a = 1:5 %iterates through instances
               %raw_vals_speech(z, 1) = speechrecognitionaccuracy(digits(z), data, knums(1), instances(a), people_idx(p)) + raw_vals_speech(z, 1);
               A = mfcc_sig_10000;
               while(val <= 99)
                feat = mfcc_sig_10000(:, val);
                val = val + 1;
               end
                if val <=20 
                    for x = 1:20
                    A(:, x) = [];
                    end
                elseif val <=40 && val > 20
                    for x = 21:40
                    A(:, x) = [];
                    end
                elseif val <=60 && val > 40
                    for x = 41:60
                    A(:, x) = [];
                    end
                elseif val <=80 && val > 60
                    for x = 61:80
                    A(:,x) = [];
                    end
                else
                    for x = 81:100
                    A(:, 176-x) = [];
                    end
                end
            B = knnspeaker(feat, A, knums(q), cdm);
            if(B == ppl(p))
                num = num + 1;
            end
            end
          
         mfcc10000_vals_speaker(p,q) = num + mfcc10000_vals_speaker(p, q);
        end
    end
end

M1 = mean(raw_vals_speech, 1);
M2 = mean(cep100_vals_speech,1);
M3 = mean(cep500_vals_speech,1);
M4 = mean(cep10000_vals_speech,1);
disp('Cepstrum');
disp('Speech Recognition');%
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('D1: %f  %f  %f  %f \n', raw_vals_speech(1,1),cep100_vals_speech(1,1), cep500_vals_speech(1,1), cep10000_vals_speech(1,1));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('D2: %f  %f  %f  %f \n', raw_vals_speech(2,1),cep100_vals_speech(2,1), cep500_vals_speech(2,1), cep10000_vals_speech(2,1));
fprintf('D3: %f  %f  %f  %f \n', raw_vals_speech(3,1),cep100_vals_speech(3,1), cep500_vals_speech(3,1), cep10000_vals_speech(3,1));
fprintf('D4: %f  %f  %f  %f \n', raw_vals_speech(4,1),cep100_vals_speech(4,1), cep500_vals_speech(4,1), cep10000_vals_speech(4,1));
fprintf('D5: %f  %f  %f  %f \n', raw_vals_speech(5,1),cep100_vals_speech(5,1), cep500_vals_speech(5,1), cep10000_vals_speech(5,1));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,1), M2(1,1), M3(1,1), M4(1,1));

M1 = mean(raw_vals_speech, 1);
M2 = mean(mfcc100_vals_speech,1);
M3 = mean(mfcc500_vals_speech,1);
M4 = mean(mfcc10000_vals_speech,1);
disp('MFCC');
disp('Speech Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('D1: %f  %f  %f  %f \n', raw_vals_speech(1,1),mfcc100_vals_speech(1,1), mfcc500_vals_speech(1,1), mfcc10000_vals_speech(1,1));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('D2: %f  %f  %f  %f \n', raw_vals_speech(2,1),mfcc100_vals_speech(2,1), mfcc500_vals_speech(2,1), mfcc10000_vals_speech(2,1));
fprintf('D3: %f  %f  %f  %f \n', raw_vals_speech(3,1),mfcc100_vals_speech(3,1), mfcc500_vals_speech(3,1), mfcc10000_vals_speech(3,1));
fprintf('D4: %f  %f  %f  %f \n', raw_vals_speech(4,1),mfcc100_vals_speech(4,1), mfcc500_vals_speech(4,1), mfcc10000_vals_speech(4,1));
fprintf('D5: %f  %f  %f  %f \n', raw_vals_speech(5,1),mfcc100_vals_speech(5,1), mfcc500_vals_speech(5,1), mfcc10000_vals_speech(5,1));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,1), M2(1,1), M3(1,1), M4(1,1));

M1 = mean(raw_vals_speech, 1);
M2 = mean(cep100_vals_speech,1);
M3 = mean(cep500_vals_speech,1);
M4 = mean(cep10000_vals_speech,1);
disp('Cepstrum');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('D1: %f  %f  %f  %f \n', raw_vals_speech(1,2),cep100_vals_speech(1,2), cep500_vals_speech(1,2), cep10000_vals_speech(1,2));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('D2: %f  %f  %f  %f \n', raw_vals_speech(2,2),cep100_vals_speech(2,2), cep500_vals_speech(2,2), cep10000_vals_speech(2,2));
fprintf('D3: %f  %f  %f  %f \n', raw_vals_speech(3,2),cep100_vals_speech(3,2), cep500_vals_speech(3,2), cep10000_vals_speech(3,2));
fprintf('D4: %f  %f  %f  %f \n', raw_vals_speech(4,2),cep100_vals_speech(4,2), cep500_vals_speech(4,2), cep10000_vals_speech(4,2));
fprintf('D5: %f  %f  %f  %f \n', raw_vals_speech(5,2),cep100_vals_speech(5,2), cep500_vals_speech(5,2), cep10000_vals_speech(5,2));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,2), M2(1,2), M3(1,2), M4(1,2));

M1 = mean(raw_vals_speech, 1);
M2 = mean(mfcc100_vals_speech,1);
M3 = mean(mfcc500_vals_speech,1);
M4 = mean(mfcc10000_vals_speech,1);
disp('MFCC');
disp('Speech Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('D1: %f  %f  %f  %f \n', raw_vals_speech(1,2),mfcc100_vals_speech(1,2), mfcc500_vals_speech(1,2), mfcc10000_vals_speech(1,2));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('D2: %f  %f  %f  %f \n', raw_vals_speech(2,2),mfcc100_vals_speech(2,2), mfcc500_vals_speech(2,2), mfcc10000_vals_speech(2,2));
fprintf('D3: %f  %f  %f  %f \n', raw_vals_speech(3,2),mfcc100_vals_speech(3,2), mfcc500_vals_speech(3,2), mfcc10000_vals_speech(3,2));
fprintf('D4: %f  %f  %f  %f \n', raw_vals_speech(4,2),mfcc100_vals_speech(4,2), mfcc500_vals_speech(4,2), mfcc10000_vals_speech(4,2));
fprintf('D5: %f  %f  %f  %f \n', raw_vals_speech(5,2),mfcc100_vals_speech(5,2), mfcc500_vals_speech(5,2), mfcc10000_vals_speech(5,2));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,2), M2(1,2), M3(1,2), M4(1,2));

M1 = mean(raw_vals_speaker, 1);
M2 = mean(cep100_vals_speaker,1);
M3 = mean(cep500_vals_speaker,1);
M4 = mean(cep10000_vals_speaker,1);
disp('Cepstrum');
disp('Speaker Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('S1: %f  %f  %f  %f \n', raw_vals_speaker(1,1),cep100_vals_speaker(1,1), cep500_vals_speaker(1,1), cep10000_vals_speaker(1,1));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('S2: %f  %f  %f  %f \n', raw_vals_speaker(2,1),cep100_vals_speaker(2,1), cep500_vals_speaker(2,1), cep10000_vals_speaker(2,1));
fprintf('S3: %f  %f  %f  %f \n', raw_vals_speaker(3,1),cep100_vals_speaker(3,1), cep500_vals_speaker(3,1), cep10000_vals_speaker(3,1));
fprintf('S4: %f  %f  %f  %f \n', raw_vals_speaker(4,1),cep100_vals_speaker(4,1), cep500_vals_speaker(4,1), cep10000_vals_speaker(4,1));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,1), M2(1,1), M3(1,1), M4(1,1));

M1 = mean(raw_vals_speaker, 1);
M2 = mean(mfcc100_vals_speaker,1);
M3 = mean(mfcc500_vals_speaker,1);
M4 = mean(mfcc10000_vals_speaker,1);
disp('MFCC');
disp('Speaker Recognition');
disp('1-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('S1: %f  %f  %f  %f \n', raw_vals_speaker(1,1),mfcc100_vals_speaker(1,1), mfcc500_vals_speaker(1,1), mfcc10000_vals_speaker(1,1));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('S2: %f  %f  %f  %f \n', raw_vals_speaker(2,1),mfcc100_vals_speaker(2,1), mfcc500_vals_speaker(2,1), mfcc10000_vals_speaker(2,1));
fprintf('S3: %f  %f  %f  %f \n', raw_vals_speaker(3,1),mfcc100_vals_speaker(3,1), mfcc500_vals_speaker(3,1), mfcc10000_vals_speaker(3,1));
fprintf('S4: %f  %f  %f  %f \n', raw_vals_speaker(4,1),mfcc100_vals_speaker(4,1), mfcc500_vals_speaker(4,1), mfcc10000_vals_speaker(4,1));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,1), M2(1,1), M3(1,1), M4(1,1));

M1 = mean(raw_vals_speaker, 1);
M2 = mean(cep100_vals_speaker,1);
M3 = mean(cep500_vals_speaker,1);
M4 = mean(cep10000_vals_speaker,1);
disp('Cepstrum');
disp('Speaker Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('S1: %f  %f  %f  %f \n', raw_vals_speaker(1,2),cep100_vals_speaker(1,2), cep500_vals_speaker(1,2), cep10000_vals_speaker(1,2));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('S2: %f  %f  %f  %f \n', raw_vals_speaker(2,2),cep100_vals_speaker(2,2), cep500_vals_speaker(2,2), cep10000_vals_speaker(2,2));
fprintf('S3: %f  %f  %f  %f \n', raw_vals_speaker(3,2),cep100_vals_speaker(3,2), cep500_vals_speaker(3,2), cep10000_vals_speaker(3,2));
fprintf('S4: %f  %f  %f  %f \n', raw_vals_speaker(4,2),cep100_vals_speaker(4,2), cep500_vals_speaker(4,2), cep10000_vals_speaker(4,2));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,2), M2(1,2), M3(1,2), M4(1,2));

M1 = mean(raw_vals_speaker, 1);
M2 = mean(mfcc100_vals_speaker,1);
M3 = mean(mfcc500_vals_speaker,1);
M4 = mean(mfcc10000_vals_speaker,1);
disp('MFCC');
disp('Speaker Recognition');
disp('5-NN');
disp('       Raw      W=100      W=500      W=10000');
fprintf('S1: %f  %f  %f  %f \n', raw_vals_speaker(1,2),mfcc100_vals_speaker(1,2), mfcc500_vals_speaker(1,2), mfcc10000_vals_speaker(1,2));  % 'D2: ' raw_vals_speech(1,2)];
fprintf('S2: %f  %f  %f  %f \n', raw_vals_speaker(2,2),mfcc100_vals_speaker(2,2), mfcc500_vals_speaker(2,2), mfcc10000_vals_speaker(2,2));
fprintf('S3: %f  %f  %f  %f \n', raw_vals_speaker(3,2),mfcc100_vals_speaker(3,2), mfcc500_vals_speaker(3,2), mfcc10000_vals_speaker(3,2));
fprintf('S4: %f  %f  %f  %f \n', raw_vals_speaker(4,2),mfcc100_vals_speaker(4,2), mfcc500_vals_speaker(4,2), mfcc10000_vals_speaker(4,2));
fprintf('Avg: %f  %f  %f  %f \n', M1(1,2), M2(1,2), M3(1,2), M4(1,2));

end