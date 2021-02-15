clear;clc
x=12;y=13;z=15;%角点
l=2;w=5;h=5;%长，宽，高
[a,b,c]=meshgrid([0 1]);
p=alphaShape(l*a(:)-(l-x),w*b(:)-(w-y),h*c(:)-(0-z));
plot(p,'edgecolor','none')
xlabel('x');ylabel('y');zlabel('z');
camlight
grid on;
hold on;
x=2;y=13;z=15;%角点
l=2;w=2;h=2;%长，宽，高
[a,b,c]=meshgrid([0 1]);
p=alphaShape(l*a(:)-(l-x),w*b(:)-(w-y),h*c(:)-(0-z));
plot(p,'edgecolor','none')
xlabel('x');ylabel('y');zlabel('z');

axis([0 21,0,21,0,20]);
