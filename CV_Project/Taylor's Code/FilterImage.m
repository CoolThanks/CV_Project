image = double(imread('a09.png'));
filtered = imbinarize(image);
filtered = medfilt2(filtered, [5 5]);
filtered = bwareafilt(filtered,1);
filtered = imfill(filtered,'holes');
filtered = image.*filtered;
imwrite(uint8(filtered),'a09.png');


