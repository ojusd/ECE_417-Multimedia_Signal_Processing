function adaboost_test(jpgdir, rectdir)
load('learned_classifiers.txt', '-ascii');

[T, foo] =size(learned_classifiers);
BETAS = learned_classifiers(:,9);
ALPHAS = -log(BETAS);
NSAMPS = 6;

%jpgdir = '../jpg';
files = dir(jpgdir);
images = files(3:length(files));

K = length(images);
numtrain = round(0.75*length(images));
numtest = K -numtrain;

rectsfile = strcat(rectdir, '/allrects.txt');
load(rectsfile, '-ascii');
posrects = allrects((numtrain+1): K, 17:32);
negrects = allrects((numtrain+1):K, 33:48);

for k =(numtrain+1):K,
    A=imread([jpgdir, '/', images(k).name]);
    II(:, :, k-numtrain) = integralimage(A);
end

F = zeros(numtest, 8, T);
H = zeros(numtest, 8, T);
Hcum = zeros(numtest, 8,T);
for t= 1:T,
    fr = learned_classifiers(t, 1:4)/NSAMPS;
    vert = learned_classifiers(t,5);
    order = learned_classifiers(t, 6);
    theta = learned_classifiers(t, 7);
    p = learned_classifiers(t,8);
    beta = learned_classifiers(t,9);
    F(:,:,t) = rectfeature(II, [posrects, negrects], fr, order, vert);
    H(:,:,t) = p*sign(theta - F(:,:,t));
end

Hcum = cumsum(H .* repmat(reshape(ALPHAS, [1,1,T]), [numtest, 8]) , 3);
Y = [ones(numtest, 4), -ones(numtest, 4)];
for t = 1:T,
    toterr(t) = mean(mean(sign(Hcum(:,:,t)) ~= Y));
    sngerr(t) = mean(mean(sign(H(:,:,t)) ~= Y));
end
figure(1);
plot(1:T, toterr, 1:T, sngerr, 1:T, BETAS);
legend({'Total Error', 'Single Error', 'Beta'});
xlabel('Adaboost Iteration');
ylabel('Error rate');



