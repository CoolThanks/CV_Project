function [ MHI ] = generateMHI( imgs )
rows = size(imgs(:,:,1), 1);
columns = size(imgs(:,:,1),2);
MHIImage = zeros(100,100);
T = 10;
dim = size(imgs,3);

for i = 2:dim
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

for i=2:dim
    for num_cols = 1:columns
        for num_rows = 1:rows
            if (imgs(num_rows,num_cols,i) ~= 0)
                MHIImage(num_rows, num_cols) = i;
            end
        end
    end
end

MHI = max(0,(MHIImage-1)/dim);
imwrite(uint8(MHI),'TEST.png');
end

