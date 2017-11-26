function [ movementFound ] = determineMovement(imgs, move, counter, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG, startFrom)
TIMG = 9700; 
dim = size(imgs,3);
movementFound = false;
for i=startFrom:dim
    MHI = generateMHI(imgs, startFrom);
%     if dim == 32
%         imwrite(MHI,'TEST6.png');
%         pause;
%     end
    score = computeError(MHI, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG);
    %score
    if score > TIMG
        score
        %move
        movementFound = true;
        break
    end
end
end

