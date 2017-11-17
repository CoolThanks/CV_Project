%% Load Avg MHI's

yimg = double(imread('MHIs/Y/yAVG.png'));
%figure();
%imagesc(yimg);
y_nval(1,:) = similitudeMoments(yimg);

for i=0:5
   file =  sprintf('MHIs/Y/Individuals/y0%1d.png',i);
   img(:,:,i+1) = double(imread(file));
   figure(i+1);
   imagesc(img(:,:,i+1));
   y_nval(i+2,:) = similitudeMoments(img(:,:,i+1));
end
for i=1:7
   stddev(i) = std(y_nval(:,i));
   means(i) = mean(y_nval(:,i));
end