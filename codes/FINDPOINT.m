% im = imread('Men_Individual-Time-Trial-Integrated-version_rgb.png');
% imm = imcrop(im);
imshow(imm)
xx = [];
yy = [];
x = 0;
y = 0;
i = 1;
z = 0;

% origin x axis y axis
while ~(z==49)
    [x, y, z] = ginput(1);
    i = i + 1;
    xx = [xx, x];
    yy = [yy, y];
    hold on
    scatter(x,y,1)
end
s = (yy-yy(1))*44.2./(yy(3)-yy(1));
h = (abs(xx-xx(2))*600./abs(xx(2)));