function [ score ] = computeError( MHI, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG)
    %MHI = double(imread('mAVG.png')); MHI = imresize(MHI,[100 100]);
	score = 0;
	for x=1:100
		for y=1:100
			if move == 1
				if (abs(MHI(x,y)-yAVG(x,y)) < ySTD(x,y))
					score = score + 1;
                end
			elseif move == 2
				if (abs(MHI(x,y)-mAVG(x,y)) < mSTD(x,y))
					score = score + 1;
                end
			elseif move == 3
				if (abs(MHI(x,y)-cAVG(x,y)) < cSTD(x,y))
					score = score + 1;
                end
			elseif move == 4
				if (abs(MHI(x,y)-aAVG(x,y)) < aSTD(x,y))
					score = score + 1;
                end
			end
		end
    end
    %score
end
