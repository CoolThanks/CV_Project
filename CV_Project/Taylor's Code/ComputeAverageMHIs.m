%@Author: Taylor Ripke

%------------------------
%Create Average MHI images
colormap(gray);
for i=1:4
    filename = sprintf('a%02d.png', i-1);
    img = double(imread(filename));
    Im(:,:,i) = img;
end
avg = zeros(360,640);
for x=1:4
    for i = 1:360
        for j=1:640
            avg(i,j) = avg(i,j) + Im(i,j,x);
        end
    end
end
%avg = avg./6;
avg = max(0,(avg-1)/4);
imagesc(avg);
avg = uint8(avg);
imwrite(avg,'aAVG.png');