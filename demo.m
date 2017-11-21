clear
clc
clf
colormap(gray)

% create example image
%ima=100*ones(100);
%ima(50:100,:)=50;
%ima(:,50:100)=2*ima(:,50:100);
%fs=fspecial('average');
%ima=imfilter(ima,fs,'symmetric');

%elo
dataset_T1 = openBrainWebData('t1_icbm_normal_1mm_pn0_rf40.rawb', 181, 217, 181, 1);

slice = 81; % slice choice - values from 1 to 181
image = dataset_T1(:,:,slice); % change name for different projections

%image = image./max(image(:)).*255; % normalize the data
%figure, imshow(image, []);

%

% add some noise
sigma=10;
rima=image+sigma*randn(size(image));

% show it
%imagesc(rima)
%drawnow

% denoise it
fima=NLmeansfilter(image,5,2,sigma);

% show results
clf
subplot(2,2,1),imagesc(image),title('original');
subplot(2,2,2),imagesc(rima),title('noisy');
subplot(2,2,3),imagesc(fima),title('filtered');
subplot(2,2,4),imagesc(rima-fima),title('residuals');

