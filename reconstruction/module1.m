
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
for i = 1:3 % ��Ӧ���ֲ�ͬ��Ƶ��
    for  j = 0:3 % ��Ӧ������λ
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
% �������Ƶ�ʵ���λ��ֵ������������
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
  
% �������
% ����������ڶ�Ƶ���ļ���
PH1 = phi{1,1};   %Ƶ��1
PH2 = phi{2,1};   %Ƶ��2
PH3 = phi{3,1};   %Ƶ��3
 
% ��ʼ��������
% ��Ƶ���
PH12 = zeros(heigth,width);
PH23 = zeros(heigth,width);
PH123 = zeros(heigth,width);


% PH12 = PH1 + 2*pi*round(((freq(2)/freq(1))*PH1-PH2)/(2*pi));
% PH23 = PH2 + 2*pi*round(((freq(3)/freq(2))*PH2-PH3)/(2*pi));

% �������
% ������
% ����
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
% ��λ�����  ��λչ��
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
title("���յ���λ������");
figure,imshow(mat2gray(PH12));title('1,2���');   imwrite(mat2gray(PH12),'12���.bmp');
figure,imshow(mat2gray(PH23));title('2,3���');   imwrite(mat2gray(PH23),'23���.bmp');
figure,imshow(mat2gray(PH123));title('1,2,3���');imwrite(mat2gray(PH123),'123���.bmp');
figure,imshow(mat2gray(PH1));title('1��λ��ֵ');  imwrite(mat2gray(PH1),'1��λ��ֵ.bmp');  
figure,imshow(mat2gray(PH2));title('2��λ��ֵ');  imwrite(mat2gray(PH2),'2��λ��ֵ.bmp');  
figure,imshow(mat2gray(PH3));title('3��λ��ֵ');  imwrite(mat2gray(PH3),'3��λ��ֵ.bmp');