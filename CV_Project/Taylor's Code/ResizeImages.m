%Author: Taylor Ripke
%Simple script to resize
colormap(gray);
filename = 'f03.png';
img = double(imread(filename));
img = imresize(img,[100 100]);
img = uint8(img);
imwrite(img,'s03.png');

