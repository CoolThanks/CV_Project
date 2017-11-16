%% Load Avg MHI's

yimg = double(imread('Y/yAVG.png'));
figure();
imagesc(yimg);
y_nval = similitudeMoments(yimg);

for i=0:5
   file =  sprintf('Y/Individuals/y0%1d.png',i);
   img(i+1,:,:) = double(imread(file));
end
