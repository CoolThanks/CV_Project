anac%% Load Avg MHI's

yimg = double(imread('MHIs/Y/yAVG.png'));
mimg = double(imread('MHIs/M/mAVG.png'));
cimg = double(imread('MHIs/C/cAVG.png'));
aimg = double(imread('MHIs/A/aAVG.png'));
%figure();
%imagesc(yimg);
y_nval(1,:) = similitudeMoments(yimg);
m_nval(1,:) = similitudeMoments(mimg);
c_nval(1,:) = similitudeMoments(cimg);
a_nval(1,:) = similitudeMoments(aimg);
for i=0:5
   file =  sprintf('MHIs/Y/Individuals/y0%1d.png',i);
   img(:,:,i+1) = double(imread(file));
   %figure(i+1);
   %imagesc(img(:,:,i+1));
   m_nval(i+2,:) = similitudeMoments(img(:,:,i+1));
   
   file =  sprintf('MHIs/M/Individuals/m0%1d.png',i);
   imgm(:,:,i+1) = double(imread(file));
   %figure(i+1);
   %imagesc(img(:,:,i+1));
   m_nval(i+2,:) = similitudeMoments(imgm(:,:,i+1));
   
   file =  sprintf('MHIs/C/Individuals/c0%1d.png',i);
   imgc(:,:,i+1) = double(imread(file));
   %figure(i+1);
   %imagesc(img(:,:,i+1));
   c_nval(i+2,:) = similitudeMoments(imgc(:,:,i+1));
   
   file =  sprintf('MHIs/A/Individuals/a0%1d.png',i);
   imga(:,:,i+1) = double(imread(file));
   %figure(i+1);
   %imagesc(img(:,:,i+1));
   a_nval(i+2,:) = similitudeMoments(imga(:,:,i+1));
end
for i=1:7
   stddev(i) = std(y_nval(:,i));
   means(i) = mean(y_nval(:,i));
   stddevm(i) = std(m_nval(:,i));
   meansm(i) = mean(m_nval(:,i));
   stddevc(i) = std(c_nval(:,i));
   meansc(i) = mean(c_nval(:,i));
   stddeva(i) = std(a_nval(:,i));
   meansa(i) = mean(a_nval(:,i));
end
%%
cam = webcam(1);  % For me this is splitcam- make sure that you call 
% "webcamlist" to find out which index is splitcam for you
for i =1:1000
    pic = snapshot(cam);
    %figure(1);        %use these two lines to view the video
    %imshow(pic);
    
    
    
end
clear cam;  %need to make sure that you dont try to have more than one
% object trying to access the same webcam driver at the same time even if
% its technically the same variable


