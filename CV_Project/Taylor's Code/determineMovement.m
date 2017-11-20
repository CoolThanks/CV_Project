function [ movementFound ] = determineMovement(imgs, move, counter, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG)
TIMG = 4000; 
dim = size(imgs,3);
movementFound = false;
for i=1:dim
    MHI = generateMHI(imgs);
    score = computeError(MHI, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG);
    if score > TIMG
        movementFound = true;
        break
    end
end
end

