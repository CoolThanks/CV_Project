%{
Author: Taylor Ripke
Course: CSE 5524
Date:   11/28/2017

Brief Overview: Initially, a TCP connection is established with Unity for
visual purposes. Next, preexisting data is preprocessed and stored. The
process starts by gathering images from a live camera feed and sending them
to determineMovement, which calls functions to generate the MHI and compute
the error. It also acts as a backward looking window for the program. 

 Primary Scripts:
> LiveDemo -> Main program - calls determineMovement, which returns
true/false depending if a movement was found.

> determineMovement -> Called from Main, calls generateMHI and compute
Error. Has a threshold value TIMG, which determines whether a movement is
considered found. Acts as the backward looking window, which takes a
sequence of images and progressively searches for a movement. If one is
found, it starts looking for the next immediately, otherwise, after a
specified amount of frames, will start searching for another.

> generateMHI -> Given a sequence of images, it generates the corresponding
MHI for those images and returns it back to the calling function
determineMovement. Has one threshold T which is used in the calculation of
the MHI.

> computeError -> Given the MHI, current move, and respective mean/std
data, will compute for each pixel whether or not the test image is within
how many ever standard deviations of the mean image. It will return the
amount of pixels within the accepted range.

Secondary Scripts:
> MHI -> This script was used to generate the MHIs from the edited videos.

> FilterImage -> This script was used to test filtering on the images and
clean them up once the initial MHI was generated.

> ResizeImages -> A small script to resize the images once the initial
MHI's were generated.
%}


cam = webcam(2); 
MHIImage = zeros(100,100); 
T = 10; colormap(gray); 
numberOfTrainingImages = 10;

%Bring in average MHI's
yAVG = double(imread('yAVG.png')); yAVG = imresize(yAVG,[100 100]);
mAVG = double(imread('mAVG.png')); mAVG = imresize(mAVG,[100 100]);
cAVG = double(imread('cAVG.png')); cAVG = imresize(cAVG,[100 100]);
aAVG = double(imread('aAVG.png')); aAVG = imresize(aAVG,[100 100]);


%Set up TCP connection
tcp_connection = tcpip('127.0.0.1', 10000, 'NetworkRole', 'server');
fopen(tcp_connection);
fprintf("Connected...\n");


%Read y
for i=1:numberOfTrainingImages
    filename = sprintf('y%02d.png', i-1);
    img = double(imread(filename));
    img = imresize(img,[100 100]);
    yImgs(:,:,i) = img;
    yMean = mean(yImgs,3);
    ySTD = std(yImgs,[],3);
end

%Read m
for i=1:numberOfTrainingImages
    filename = sprintf('m%02d.png', i-1);
    img = double(imread(filename));
    img = imresize(img,[100 100]);
    mImgs(:,:,i) = img;
    mMean = mean(mImgs,3);
    mSTD = std(mImgs,[],3);
end

%Read c
for i=1:numberOfTrainingImages
    filename = sprintf('c%02d.png', i-1);
    img = double(imread(filename));
    img = imresize(img,[100 100]);
    cImgs(:,:,i) = img;
    cMean = mean(cImgs,3);
    cSTD = std(cImgs,[],3);
end

%Read a
for i=1:numberOfTrainingImages
    filename = sprintf('a%02d.png', i-1);
    img = double(imread(filename));
    img = imresize(img,[100 100]);
    aImgs(:,:,i) = img;
    aMean = mean(aImgs,3);
    aSTD = std(aImgs,[],3);
end


fprintf(1,'Starting Demo in 3..');
pause(1);fprintf(1,'2..');
pause(1);fprintf(1,'1..');
pause(1);fprintf(1,'Go!');

%move: 1=y, 2=m, 3=c, 4=a
move = 1;
%counter to keep track of movement
counter = 1;
startFrom = 2;
while true
    pause(0.1);
    img = rgb2gray(snapshot(cam));
    img = double(imresize(img,[100 100]));
    filtered = imbinarize(img);
    filtered = medfilt2(filtered, [5 5]);
    filtered = bwareafilt(filtered,2);
    filtered = imfill(filtered,'holes');
    filtered = img.*filtered;
    %imagesc(filtered);
    imgs(:,:,counter) = filtered;
    movementFound = false;
    %Determine movement
    if counter > 1
        movementFound = determineMovement(imgs, move, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG, startFrom);
    end
    counter = counter + 1;
    
    if movementFound == true
        startFrom = counter-1;
        if move == 1
            fprintf("Y\n");
            move = move + 1;
        elseif move == 2
            fprintf("M\n");
            move = move + 1;
        elseif move == 3
            fprintf("C\n");
            move = move + 1;
        elseif move == 4
            fprintf("A\n");
            move = 1;
            startFrom = 2;
            counter = 1;
        end
        fwrite(tcp_connection,"Good");
    else
        if move == 1 && counter > 20
            startFrom = 20;
            fprintf("Not recognized!\n");
            fwrite(tcp_connection,"Bad");
            move = move + 1;
            imgs = [];
        elseif move == 2 && counter > 40
            startFrom = 40;
            fprintf("Not recognized!\n");
            fwrite(tcp_connection,"Bad");
            move = move + 1;
            imgs = [];
        elseif move == 3 && counter > 50
            startFrom = 50;
            fprintf("Not recognized!\n");
            fwrite(tcp_connection,"Bad");
            move = move + 1;
            imgs = [];
        elseif move == 4 && counter > 60
            startFrom = 2;
            %imwrite(uint8(imgs(:,:,5)),'TEST2.png');
            fprintf("Not recognized! Restarting!\n");
            fwrite(tcp_connection,"Bad");
            move = 1;
            counter = 1;
            imgs = [];
        end
    end
end

clear('cam');