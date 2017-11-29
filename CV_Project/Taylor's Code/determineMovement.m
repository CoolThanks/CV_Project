%{
Author: Taylor Ripke
Course: CSE 5524
Date:   11/28/2017

> determineMovement -> Called from Main, calls generateMHI and compute
Error. Has a threshold value TIMG, which determines whether a movement is
considered found. Acts as the backward looking window, which takes a
sequence of images and progressively searches for a movement. If one is
found, it starts looking for the next immediately, otherwise, after a
specified amount of frames, will start searching for another.

%}
function [ movementFound, imgs, imgs2, startFrom, targetScore, score ] = determineMovement(imgs, imgs2, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG, startFrom, alpha, targetScore)
TIMG = 8100; 
dim = size(imgs,3);
movementFound = false;
for i=startFrom:dim
    [MHIImage, imgs, imgs2, startFrom] = generateMHI(imgs, imgs2, startFrom, true, alpha);
%     if dim == 15
%         imwrite(MHI,'TEST7.png');
%         pause;
%     end
    score = computeError(MHIImage, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG);
    
    if (abs(score-targetScore) < 1)
        filename = sprintf('wow%03d.png', move);
        imwrite(MHIImage,filename);
        %move
        movementFound = true;
        if move == 1
            targetScore = 9259;
        elseif move == 2
            targetScore = 7318;
        elseif move == 3
            targetScore = 9050;
        end
        break
    
    end
end
end

