function [ MHIImage ] = generateMHI( imgs, startFrom )
rows = size(imgs(:,:,1), 1);
columns = size(imgs(:,:,1),2);
MHIImage = zeros(100,100);
T = 5;
dim = size(imgs,3);
%colormap(gray); 

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

end

