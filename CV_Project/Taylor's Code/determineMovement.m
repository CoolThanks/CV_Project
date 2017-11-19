function [ movement ] = determineMovement( imgs, ySTD, mSTD, cSTD, aSTD )

startFrame = 1; endFrame = 22; rows = size(imgs(:,:,1), 1); columns = size(imgs(:,:,1),2);
MHIImage = zeros(100,100); T = 10;

while ((endFrame-startFrame > 5) && found == false)
    for x=startFrame:endFrame
        %Make the MHI
        for i = 2:21
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

        for i=2:20
            for num_cols = 1:columns
                for num_rows = 1:rows
                    if (imgs(num_rows,num_cols,i) ~= 0)
                        MHIImage(num_rows, num_cols) = i;
                    end
                end
            end
        end

        MHIImage = max(0,(MHIImage-1)/21);
        
        %{
        Next we find the best match, if there is one within a given
        threshold. I take the average MHI for each movement and perform
        differencing and checking if the pixel in the test image is within
        one standard deviation of the pixel in the templates
        %}
        
        threshold = 8000;
        best = 0;
        count = 0;
        %For each template
        for pos=1:4
            count = 0;
            %Check the template pixel by pixel
            if pos == 1
                for i=1:columns
                    for j=1:rows
                        %See if the pixel is within 1 std of template
                        if (abs(MHIImage(i,j)-
                    
                    
            
    end
end


end

