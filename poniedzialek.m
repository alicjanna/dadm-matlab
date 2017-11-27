colormap(gray)
%open the image
dataset_T1 = openBrainWebData('t1_icbm_normal_1mm_pn0_rf40.rawb', 181, 217, 181, 1);
slice = 81;
ima = dataset_T1(:,:,slice);

%normalize data (? is it needed)
ima = ima./max(ima(:)).*255; % normalize the data

%add noise
sigma=10;
rima=ima+sigma*randn(size(ima));

%denoise
fima=NLmeansfilter(ima,5,2,sigma);
%figure;
%imagesc(fima),title('filtered');

%otsu tresholding
level = graythresh(ima)

oima = fima < level;
%oima is the 'binary mask' separates body from background
%figure;
%imshow(oima), title('mask - oima');

sima = rima.^2; %squared magnitude
back = sima(oima);
mean_back = mean(back);

%UNLM

sig = sqrt(mean_back/2);
UNLM = sqrt(fima.^2 - 2*sig^2);
UNLM = abs(UNLM);

%figure;
%imagesc(UNLM), title('UNLM');

%print results
subplot(3,2,1),imagesc(image),title('original');
subplot(3,2,2),imagesc(rima),title('noisy');
subplot(3,2,3),imagesc(fima),title('NLM');
subplot(3,2,4),imagesc(UNLM-rima),title('residuals'); %initially rima-UNLM
subplot(3,2,5),imagesc(oima),title('mask');
subplot(3,2,6),imagesc(UNLM),title('UNLM');




