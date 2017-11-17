image = double(imread('a03.png'));
rows = size(image, 1);
columns = size(image,2);
filtered = imbinarize(image);
filtered = medfilt2(filtered, [5 5]);
filtered = bwareafilt(filtered,1);
filtered = imfill(filtered,'holes');
filtered = image.*filtered;
imwrite(uint8(filtered),'a03.png');


