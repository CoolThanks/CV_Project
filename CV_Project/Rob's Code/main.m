%% Load Avg MHI's

yimg = double(imread('MHIs/Y/yAVG2.png'));
mimg = double(imread('MHIs/M/mAVG2.png'));
cimg = double(imread('MHIs/C/cAVG2.png'));
aimg = double(imread('MHIs/A/aAVG2.png'));
%figure();
%imagesc(yimg);
y_nval(1,:) = similitudeMoments(yimg);
m_nval(1,:) = similitudeMoments(mimg);
c_nval(1,:) = similitudeMoments(cimg);
a_nval(1,:) = similitudeMoments(aimg);
for i=0:9
   file =  sprintf('MHIs/Y/Individuals/y0%1d.png',i);
   img(:,:,i+1) = double(imread(file));
   %figure(i+1);
   %imagesc(img(:,:,i+1));
   y_nval(i+2,:) = similitudeMoments(img(:,:,i+1));
   
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
clear cam; 
clear pics;
clear pic;
clear eval;
cam = webcam(1);  % For me this is splitcam- make sure that you call 
% "webcamlist" to find out which index is splitcam for you

% tcp_connection = tcpip('127.0.0.1', 10000, 'NetworkRole', 'server');
% fopen(tcp_connection);
% fprintf("Connected...\n");
count = 1;
pause(1);
fprintf("go!\n");
pause(.25);
for i =1:1000
    pic = snapshot(cam);
    %figure(1);        %use these two lines to view the video
    %imshow(pic);
%     filtered = imbinarize(pic);
%     filtered = medfilt2(filtered, [5 5]);
%     filtered = bwareafilt(filtered,2);
%     filtered = imfill(filtered,'holes');
%     filtered = pic.*filtered;
    %imagesc(filtered);
    pics(:,:,i) = rgb2gray(pic);
    eval = evaluate(pics, stddev, stddevm, stddevc, stddeva, y_nval(1,:), count);
    if (eval == "Good")
%         fwrite(tcp_connection,"Good");
          fprintf("good\n");
          count = count + 1;
    else
        if (eval == "next")
            continue;
        else
%             fwrite(tcp_connection,"Bad");
              fprintf("bad\n");
              count = count + 1;
        end
    end
    if (count > 4)
        break;
    end
    
end
clear cam;  %need to make sure that you dont try to have more than one
% object trying to access the same webcam driver at the same time even if
% its technically the same variable


