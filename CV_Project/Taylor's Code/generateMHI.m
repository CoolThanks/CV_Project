%{
Author: Taylor Ripke
Course: CSE 5524
Date:   11/28/2017

> generateMHI -> Given a sequence of images, it generates the corresponding
MHI for those images and returns it back to the calling function
determineMovement. Has one threshold T which is used in the calculation of
the MHI.

%}

function [ MHIImage ] = generateMHI( imgs, startFrom, scaleMe)
rows = size(imgs(:,:,1), 1);
columns = size(imgs(:,:,1),2);
if (scaleMe)
    MHIImage = zeros(100,100);
end
T = 10;
dim = size(imgs,3);
colormap(gray); 

for i = startFrom:dim
    for num_cols = 1:columns
        for num_rows = 1:rows
            if abs(imgs(num_rows,num_cols,i)-imgs(num_rows,num_cols,i-1)) > T
                imgs(num_rows, num_cols,i-1) = 1;
            else
                imgs(num_rows, num_cols,i-1) = 0;
            end
        end
    end
end

for i=startFrom:dim-1
    for num_cols = 1:columns
        for num_rows = 1:rows
            if (imgs(num_rows,num_cols,i) ~= 0)
                MHIImage(num_rows, num_cols) = i-startFrom;
            end
        end
    end
end

MHIImage = max(0,(MHIImage-1)/dim);

filtered = imbinarize(MHIImage);
filtered = medfilt2(filtered, [5 5]);
filtered = bwareafilt(filtered,2);
filtered = imfill(filtered,'holes');
MHIImage = MHIImage.*filtered;

figure(2);
imagesc(MHIImage);
end

