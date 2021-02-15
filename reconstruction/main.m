
% ######### 01 参数 #########
w = 300;
h = 300; 
f   = 1 / 5;                     % 一个光栅空间频率
p   = 1 / f;                      % 投影光栅的空间周期
len = 100;                        % 相机的镜头中心到参考面的距离
d   = 20;                         % 投影中心到相机中心的距离

% ######### 02 仿真 #########
[I01, I02, I03, I04, I01d, I02d, I03d, I04d] = surface_pattern_simulation_distortion(w, h, f, d, len);

% ######### 03 显示 #########
show_pattern(I01, I02, I03, I04, "原始条纹");
show_pattern(I01d, I02d, I03d, I04d, "调制条纹");

% ######### 04 滤波 #########
[I01, I02, I03, I04] = filter_pattern(I01, I02, I03, I04);
[I01d, I02d, I03d, I04d] = filter_pattern(I01d, I02d, I03d, I04d);

% ######### 05 解相位 #########
phase0 = parse_pattern(I01, I02, I03, I04);
phase1 = parse_pattern(I01d, I02d, I03d, I04d);
% 两个部分相位的相减，得到最后的相位，再从相对相位得到绝对相位
phase = unwrap(phase1 - phase0);
% 画出绝对相位的分布图
figure; mesh(phase); title('绝对相位的分布图');

% ######### 06 获得高度 #########
H = -p * len * phase./ (p * phase +2 * pi * d);
figure; 
mesh(H); 
title('物体的深度信息');
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