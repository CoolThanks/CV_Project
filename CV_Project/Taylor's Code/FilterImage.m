image = double(imread('test.png'));
filtered = imbinarize(image);
filtered = medfilt2(filtered, [5 5]);
filtered = bwareafilt(filtered,2);
filtered = imfill(filtered,'holes');
filtered = image.*filtered;
imwrite(uint8(filtered),'test.png');


