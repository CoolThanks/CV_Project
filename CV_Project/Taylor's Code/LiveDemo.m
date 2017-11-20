cam = webcam; 
MHIImage = zeros(100,100); 
T = 10; %colormap(gray); 
numberOfTrainingImages = 10;

%Bring in average MHI's
yAVG = double(imread('yAVG.png')); yAVG = imresize(yAVG,[100 100]);
mAVG = double(imread('mAVG.png')); mAVG = imresize(mAVG,[100 100]);
cAVG = double(imread('cAVG.png')); cAVG = imresize(cAVG,[100 100]);
aAVG = double(imread('aAVG.png')); aAVG = imresize(aAVG,[100 100]);

%%
%Set up TCP connection
tcp_connection = tcpip('127.0.0.1', 10000, 'NetworkRole', 'server');
fopen(tcp_connection);
fprintf("Connected...\n");
%%

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
while true
    pause(0.20);
    img = rgb2gray(snapshot(cam));
    img = double(imresize(img,[100 100]));
    filtered = imbinarize(img);
    filtered = medfilt2(filtered, [5 5]);
    filtered = bwareafilt(filtered,2);
    filtered = imfill(filtered,'holes');
    filtered = img.*filtered;
    imgs(:,:,counter) = filtered;
    counter = counter + 1;
    
    %Determine movement
    movementFound = determineMovement(imgs, move, counter, ySTD, mSTD, cSTD, aSTD, yAVG, mAVG, cAVG, aAVG);
    
    if movementFound == true
        if move == 1
            fprintf("Y");
            move = move + 1;
        elseif move == 2
            fprintf("M");
            move = move + 1;
        elseif move == 3
            fprintf("M");
            move = move + 1;
        elseif move == 4
            fprintf("M");
            move = 1;
        end
        fwrite(tcp_connection,"Good");
    else
        if move == 1 && counter > 7
            fprintf("Not recognized!");
            fwrite(tcp_connection,"Bad");
            move = move + 1;
        elseif move == 2 && counter > 14
            fprintf("Not recognized!");
            fwrite(tcp_connection,"Bad");
            move = move + 1;
        elseif move == 3 && counter > 18
            fprintf("Not recognized!");
            fwrite(tcp_connection,"Bad");
            move = move + 1;
        elseif move == 4 && counter > 22
            fprintf("Not recognized!");
            fwrite(tcp_connection,"Bad");
            move = 1;
            counter = 1;
            imgs = [];
        end
    end
end

clear('cam');