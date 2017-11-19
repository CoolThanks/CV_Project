cam = webcam; MHIImage = zeros(100,100); T = 10; colormap(gray); numberOfTrainingImages = 5;

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

pause(3);
fprintf('GO!');

for i=1:22
    img = snapshot(cam);
    img = rgb2gray(img);
    img = imresize(img,[100 100]);
    img = double(img);
    filtered = imbinarize(img);
    filtered = medfilt2(filtered, [5 5]);
    filtered = bwareafilt(filtered,2);
    filtered = imfill(filtered,'holes');
    filtered = img.*filtered;
    imgs(:,:,i) = filtered;
    pause(0.10);
end

rows = size(imgs(:,:,1), 1);
columns = size(imgs(:,:,1),2);

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
imwrite(MHIImage,'test.png');

movement = determineMovement(imgs, ySTD, mSTD, cSTD, aSTD);



%Now compare it to our test images and find one in threshold
best = 0; pos = 0;
for i=1:4
    im = testimages(:,:,i);
    MHIImage = double(imread('s00.png'));
    dist = sqrt(sum((im(:) - MHIImage(:)) .^2));
    test = mean(im);
    stdDev = std(double(MHIImage));
    val = stdDev1 - stdDev2;
    %err = immse(im,MHIImage);
    err = ssim(im,MHIImage)
    K = imabsdiff(im,MHIImage);

    if err < 1500
        if err > best
            best = err;
            pos = i;
        end
    end
end

if pos ~= 0
    if pos == 1
        fprintf("Y");
    end
    if pos == 2
        fprintf("M");
    end
    if pos == 3
        fprintf("C");
    end
    if pos == 4
        fprintf("A");
    end
else
    fprintf("Not recognized!");
    end

clear('cam');