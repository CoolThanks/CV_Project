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


%% tcp stuff

t = tcpip('127.0.0.1', 10000, 'NetworkRole', 'server');
fopen(t);
fprintf("connected\n");
for i=1:3
    fwrite(t, "good");
%     x = fscanf(t);
%     fprintf('%s',x);
%     if x == "done"
%         break;
%     end
    pause(1);
end
fwrite(t,"done");
fclose(t);