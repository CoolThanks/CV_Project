image = double(imread('MHIs/A/Individuals/a99.png'));
filtered = imbinarize(image);
filtered = medfilt2(filtered, [5 5]);
filtered = bwareafilt(filtered,2);
filtered = imfill(filtered,'holes');
filtered = image.*filtered;
imwrite(uint8(filtered),'MHIs/A/Individuals/a99.png');


