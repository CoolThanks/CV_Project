function [Nvals] = similitudeMoments(boxIm1)
sumM00 = 0;
sumM01 = 0;
sumM10 = 0;
for i=1:size(boxIm1, 1)
    for j=1:size(boxIm1, 2)
        sumM00=sumM00 + boxIm1(i,j);
        sumM10=sumM10 + j*boxIm1(i,j);
        sumM01=sumM01 + i*boxIm1(i,j);
    end
end
xavg = sumM10/sumM00;
yavg = sumM01/sumM00;
dividend = @(i,j) sumM00^((i+j)/2+1);
n02 = 0;
n03 = 0;
n11 = 0;
n12 = 0;
n20 = 0;
n21 = 0;
n30 = 0;
for j=1:size(boxIm1, 1) %rows
    for i=1:size(boxIm1, 2) %cols
        n02 = n02 + (j-yavg)^2*boxIm1(j,i);
        n03 = n03 + (j-yavg)^3*boxIm1(j,i);
        n11 = n11 + (i-xavg)*(j-yavg)*boxIm1(j,i);
        n12 = n12 + (i-xavg)*(j-yavg)^2*boxIm1(j,i);
        n20 = n20 + (i-xavg)^2*boxIm1(j,i);
        n21 = n21 + (i-xavg)^2*(j-yavg)*boxIm1(j,i);
        n30 = n30 + (i-xavg)^3*boxIm1(j,i);
    end
end
n02 = n02/dividend(0,2);
n03 = n03/dividend(0,3);
n11 = n11/dividend(1,1);
n12 = n12/dividend(1,2);
n20 = n20/dividend(2,0);
n21 = n21/dividend(2,1);
n30 = n30/dividend(3,0);
Nvals = [n02, n03, n11, n12, n20, n21, n30];