%{
Author: Taylor Ripke
Course: CSE 5524
Date:   11/28/2017

> generateMHI -> Given a sequence of images, it generates the corresponding
MHI for those images and returns it back to the calling function
determineMovement. Has one threshold T which is used in the calculation of
the MHI.

%}

function [ MHIImage, imgs, imgs2, startFrom] = generateMHI2( imgs, imgs2, startFrom, scaleMe, alpha)
rows = size(imgs(:,:,1), 1);
columns = size(imgs(:,:,1),2);
if (scaleMe)
    MHIImage = double(zeros(100,100));
end
T = 25*ones(size(imgs,1),size(imgs,2));
dim = size(imgs,3);
colormap(gray); 

%do shit here
while(1)
    if(alpha*dim > startFrom)
        startFrom = startFrom + 1;
         imgs2(:,:,dim-1) = double(imgs2(:,:,dim-1)) .* double(imgs2(:,:,dim-1) > startFrom-2);
    else
        break;
    end
end


imgs2(:,:,dim) = abs(imgs(:,:, dim)-imgs(:,:,dim-1)) > T;
%     figure(69);
% imagesc(imgs2(:,:,dim));
% if dim == 3
%     pause;
% end
if dim == 2
    MHIImage = double(zeros(rows,columns));
else
    MHIImage = double(imgs2(:,:,dim-1));
end
for num_cols = 1:columns
    for num_rows = 1:rows
        if (imgs2(num_rows,num_cols,dim) ~= 0)
            MHIImage(num_rows, num_cols) = double(dim-startFrom+1);
        end
    end
end

imgs2(:,:,dim) = MHIImage;
MHIImage = max(0,double((MHIImage)/dim));

filtered = imbinarize(MHIImage);
filtered = medfilt2(filtered, [5 5]);
filtered = bwareafilt(filtered,2);
filtered = imfill(filtered,'holes');
MHIImage = double(MHIImage).*double(filtered);


figure(2);
imagesc(MHIImage);
end

