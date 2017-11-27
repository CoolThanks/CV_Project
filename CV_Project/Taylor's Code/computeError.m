%{
Author: Taylor Ripke
Course: CSE 5524
Date:   11/28/2017

> computeError -> Given the MHI, current move, and respective mean/std
data, will compute for each pixel whether or not the test image is within
how many ever standard deviations of the mean image. It will return the
amount of pixels within the accepted range.

%}

function [ score ] = computeError( MHI, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG)
    %MHI = double(imread('cAVG.png')); MHI = imresize(MHI,[100 100]);
	score = 0;
    stdv = 1;
	for x=1:100
		for y=1:100
			if move == 1
				if (abs(MHI(x,y)-yAVG(x,y)) <= ySTD(x,y)*stdv)
					score = score + 1;
                end
			elseif move == 2
				if (abs(MHI(x,y)-mAVG(x,y)) <= mSTD(x,y)*stdv)
					score = score + 1;
                end
			elseif move == 3
				if (abs(MHI(x,y)-cAVG(x,y)) <= cSTD(x,y)*stdv)
					score = score + 1;
                end
			elseif move == 4
				if (abs(MHI(x,y)-aAVG(x,y)) <= aSTD(x,y)*stdv)
					score = score + 1;
                end
			end
		end
    end
end
