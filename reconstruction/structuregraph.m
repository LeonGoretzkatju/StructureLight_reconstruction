clc;clear;
CameraCenter = [-64,0,80];
ProjectorCenter = [0,0,80];
SphereCenter = [-32,20,0];
Radius = 30;
Distance = 6;
Width = 1280;
Height = 1080;
PixelLength = 0.005;
LeftBound = CameraCenter(1) - 0.5*Width*PixelLength;
RightBound = CameraCenter(1) + 0.5*Width*PixelLength;
DownBound = CameraCenter(2) - 0.5*Height*PixelLength;
UpBound = CameraCenter(2) + 0.5*Height*PixelLength;
x1 = LeftBound:0.2:RightBound;
y1 = DownBound:0.2:UpBound;
[X1,Y1] = meshgrid(x1,y1);
Z1 = zeros(28,33);
Z1(:,:) = CameraCenter(3)+Distance;

LeftBound1 = ProjectorCenter(1) - 0.5*Width*PixelLength;
RightBound1 = ProjectorCenter(1) + 0.5*Width*PixelLength;
DownBound1 = ProjectorCenter(2) - 0.5*Height*PixelLength;
UpBound1 = ProjectorCenter(2) + 0.5*Height*PixelLength;
x2 = LeftBound1:0.2:RightBound1;
y2 = DownBound1:0.2:UpBound1;
[X2,Y2] = meshgrid(x2,y2);
Z2 = zeros(28,33);
Z2(:,:) = ProjectorCenter(3)+Distance;

figure;%create a new window
set(gcf,'color','white');
set(gcf,'outerposition',get(0,'screensize'));
x = -42:1:-22;
y = 10:1:30;
[X,Y] = meshgrid(x,y);
Z = surfun(Radius,X,Y);
Xtransform = X(:)';
Ytransform = Y(:)';
Ztransform = Z(:)';
X1transform = X1(:)';
Y1transform = Y1(:)';
Z1transform = Z1(:)';
X2transform = X2(:)';
Y2transform = Y2(:)';
Z2transform = Z2(:)';
FinalPointsX = [CameraCenter(1),Xtransform];
FinalPointsY = [CameraCenter(2),Ytransform];
FinalPointsZ = [CameraCenter(3),Ztransform];
FinalPointsX1 = [CameraCenter(1),X1transform];
FinalPointsY1 = [CameraCenter(2),Y1transform];
FinalPointsZ1 = [CameraCenter(3),Z1transform];
FinalPointsX2 = [ProjectorCenter(1),X2transform];
FinalPointsY2 = [ProjectorCenter(2),Y2transform];
FinalPointsZ2 = [ProjectorCenter(3),Z2transform];
surf(X,Y,Z);
shading interp;
hold on;
for i = 2:442
   ProcessX = [FinalPointsX(1),FinalPointsX(i)];
   ProcessY = [FinalPointsY(1),FinalPointsY(i)];
   ProcessZ = [FinalPointsZ(1),FinalPointsZ(i)];
   plot3(ProcessX,ProcessY,ProcessZ);
   hold on;
   ProjectorX = [ProjectorCenter(1),FinalPointsX(i)];
   ProjectorY = [ProjectorCenter(2),FinalPointsY(i)];
   ProjectorZ = [ProjectorCenter(3),FinalPointsZ(i)];
   plot3(ProjectorX,ProjectorY,ProjectorZ);
   hold on;
end
hold on;
for j = 1:925
   PixelX = [FinalPointsX1(1),FinalPointsX1(j)];
   PixelY = [FinalPointsY1(1),FinalPointsY1(j)];
   PixelZ = [FinalPointsZ1(1),FinalPointsZ1(j)];
   plot3(PixelX,PixelY,PixelZ);
   hold on;
end
hold on;
for j = 1:925
   PixelX1 = [FinalPointsX2(1),FinalPointsX2(j)];
   PixelY1 = [FinalPointsY2(1),FinalPointsY2(j)];
   PixelZ1 = [FinalPointsZ2(1),FinalPointsZ2(j)];
   plot3(PixelX1,PixelY1,PixelZ1);
   hold on;
end




