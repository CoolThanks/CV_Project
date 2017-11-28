%@Author: Taylor Ripke

%------------------------
%Create MHI image
colormap(gray);
fprintf('\nMotion History Image\n');
MHIImage = zeros(360,640);

counter = 1;
notI=2;
k=1;
T = 10;
v = VideoReader('m02.mp4');
mov = struct('cdata',zeros(360,640,1,'uint8'),...
    'colormap',[]);

while hasFrame(v)
    video = readFrame(v);
    video = rgb2gray(video);
    video = imresize(video,0.5);
    Im(:,:,counter) = video;
    counter = counter + 1;
end

rows = size(Im(:,:,1), 1);
columns = size(Im(:,:,1),2);

for i = 2:counter-1
    for num_cols = 1:columns
        for num_rows = 1:rows
            if abs(Im(num_rows,num_cols,i)-Im(num_rows,num_cols,i-1)) > T
                Im(num_rows, num_cols,i-1) = 1;
            else
                Im(num_rows, num_cols,i-1) = 0;
            end
        end
    end
end

for i=2:counter-2
    %figure(); imagesc(video); pause(0.001);
    for num_cols = 1:columns
        for num_rows = 1:rows
            if (Im(num_rows,num_cols,i) ~= 0)
                MHIImage(num_rows, num_cols) = i;
            end
        end
    end
    imagesc(MHIImage);
    %imwrite(MHIImage,sprintf('aF%02d.png', i-1));
  % pause(0.15);
    %MHIImage=(Im(notI)~=0)*i;
    %notI = notI + 1;
end

MHIImage = max(0,(MHIImage-1)/counter);
imagesc(MHIImage);
imwrite(MHIImage,'test.png');
