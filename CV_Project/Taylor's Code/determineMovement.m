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
function [ movementFound ] = determineMovement(imgs, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG, startFrom)
TIMG = 9700; 
dim = size(imgs,3);
movementFound = false;
for i=startFrom:dim
    MHI = generateMHI(imgs, startFrom);
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

