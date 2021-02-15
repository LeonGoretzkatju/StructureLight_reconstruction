
clc;
close all;
clear;

width = 1280;  
heigth =1080;
N = 4;

freq = [73 64 56]; 
C = cell(3,4);  
for i=1:3
    for j=1:4
        C{i,j} = zeros(heigth,width);
    end
end
for i = 1:3 % 对应三种不同的频率
    for  j = 0:3 % 对应四种相位
        for k = 1:width
            C{i,j+1}(:,k) = 0.5+0.5*cos(2*pi*k*freq(i)/width+2*pi*j/N);
        end
    end
end
for i = 1:3
    for j = 1:4
        C{i,j} = mat2gray(C{i,j});
    end
end
phi = cell(3,1);
for i = 1:3
    phi{i,1} = zeros(heigth,width);
end
% 输出三种频率的相位主值，用于相差计算
for i = 1:3 
     I1 = C{i,1};
     I2 = C{i,2};
     I3 = C{i,3};
     I4 = C{i,4};
      for g = 1:heigth
          for k = 1:width          
            if     I4(g,k)==I2(g,k)&&I1(g,k)>I3(g,k) 
                    phi{i,1}(g,k)=0;
            elseif I4(g,k)==I2(g,k)&&I1(g,k)<I3(g,k) 
                    phi{i,1}(g,k)=pi; 
            elseif I1(g,k)==I3(g,k)&&I4(g,k)>I2(g,k)
                    phi{i,1}(g,k)=pi/2;
            elseif I1(g,k)==I3(g,k)&&I4(g,k)<I2(g,k)
                    phi{i,1}(g,k)=3*pi/2;
            elseif I1(g,k)<I3(g,k)
                    phi{i,1}(g,k)=atan((I4(g,k)-I2(g,k))./(I1(g,k)-I3(g,k)))+pi;
            elseif I1(g,k)>I3(g,k)&&I4(g,k)>I2(g,k) 
                    phi{i,1}(g,k)=atan((I4(g,k)-I2(g,k))./(I1(g,k)-I3(g,k)));
            elseif I1(g,k)>I3(g,k)&&I4(g,k)<I2(g,k)
                    phi{i,1}(g,k)=atan((I4(g,k)-I2(g,k))./(I1(g,k)-I3(g,k)))+2*pi;  
            end
          end             
     end
end
  
% 计算相差
% 保存矩阵，用于多频相差的计算
PH1 = phi{1,1};   %频率1
PH2 = phi{2,1};   %频率2
PH3 = phi{3,1};   %频率3
 
% 初始化相差变量
% 多频相差
PH12 = zeros(heigth,width);
PH23 = zeros(heigth,width);
PH123 = zeros(heigth,width);


% PH12 = PH1 + 2*pi*round(((freq(2)/freq(1))*PH1-PH2)/(2*pi));
% PH23 = PH2 + 2*pi*round(((freq(3)/freq(2))*PH2-PH3)/(2*pi));

% 计算相差
% 相差计算
% 解相
for g = 1:heigth
	for k = 1:width
		if PH1(g,k)>PH2(g,k)
			PH12(g,k) = PH1(g,k)-PH2(g,k);
		else
			PH12(g,k) = PH1(g,k)+2*pi-PH2(g,k);
        end
		if PH2(g,k)>PH3(g,k)
			PH23(g,k) = PH2(g,k)-PH3(g,k);
		else
			PH23(g,k) = PH2(g,k)+2*pi-PH3(g,k);
        end
	end
end
% 相位解包裹  相位展开
for g = 1:heigth
	for k = 1:width 
		if PH12(g,k)>PH23(g,k)
			PH123(g,k) = PH12(g,k)-PH23(g,k);
		else
			PH123(g,k) = PH12(g,k)+2*pi-PH23(g,k);
		end
	end
end
mesh(PH123);
title("最终的相位解算结果");
figure,imshow(mat2gray(PH12));title('1,2外差');   imwrite(mat2gray(PH12),'12外差.bmp');
figure,imshow(mat2gray(PH23));title('2,3外差');   imwrite(mat2gray(PH23),'23外差.bmp');
figure,imshow(mat2gray(PH123));title('1,2,3外差');imwrite(mat2gray(PH123),'123外差.bmp');
figure,imshow(mat2gray(PH1));title('1相位主值');  imwrite(mat2gray(PH1),'1相位主值.bmp');  
figure,imshow(mat2gray(PH2));title('2相位主值');  imwrite(mat2gray(PH2),'2相位主值.bmp');  
figure,imshow(mat2gray(PH3));title('3相位主值');  imwrite(mat2gray(PH3),'3相位主值.bmp');