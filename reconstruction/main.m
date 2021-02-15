
% ######### 01 ���� #########
w = 300;
h = 300; 
f   = 1 / 5;                     % һ����դ�ռ�Ƶ��
p   = 1 / f;                      % ͶӰ��դ�Ŀռ�����
len = 100;                        % ����ľ�ͷ���ĵ��ο���ľ���
d   = 20;                         % ͶӰ���ĵ�������ĵľ���

% ######### 02 ���� #########
[I01, I02, I03, I04, I01d, I02d, I03d, I04d] = surface_pattern_simulation_distortion(w, h, f, d, len);

% ######### 03 ��ʾ #########
show_pattern(I01, I02, I03, I04, "ԭʼ����");
show_pattern(I01d, I02d, I03d, I04d, "��������");

% ######### 04 �˲� #########
[I01, I02, I03, I04] = filter_pattern(I01, I02, I03, I04);
[I01d, I02d, I03d, I04d] = filter_pattern(I01d, I02d, I03d, I04d);

% ######### 05 ����λ #########
phase0 = parse_pattern(I01, I02, I03, I04);
phase1 = parse_pattern(I01d, I02d, I03d, I04d);
% ����������λ��������õ�������λ���ٴ������λ�õ�������λ
phase = unwrap(phase1 - phase0);
% ����������λ�ķֲ�ͼ
figure; mesh(phase); title('������λ�ķֲ�ͼ');

% ######### 06 ��ø߶� #########
H = -p * len * phase./ (p * phase +2 * pi * d);
figure; 
mesh(H); 
title('����������Ϣ');
hold on;
% x1 = 1:w;
% y1 = 1:h;
% [X1,Y1] = meshgrid(x1,y1);
% X1transform = X1(:)';
% Y1transform = Y1(:)';
% Htransform = H(:)';
% scatter3(X1transform,Y1transform,Htransform,'.','b');
% % plot3(X1transform,Y1transform,Htransform,'.','MarkerSize',0.5,'color',[rand rand rand])
% %close all; clear; clc;