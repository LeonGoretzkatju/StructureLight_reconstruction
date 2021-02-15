function [I01, I02, I03, I04, I01d, I02d, I03d, I04d] = surface_pattern_simulation_distortion(w, h, f, d, len)

x = 1:w;
y = 1:h;
[X, Y] = meshgrid(x,y);

X1=X*(1+(0.02+0.04*(X.*X+Y.*Y)))/1000000; 
Y1=Y*(1+(0.02+0.04*(X.*X+Y.*Y)))/1000000; 
Z = 0.4*sqrt(100*100-(X1-150).^2-(Y1-150).^2);
Z(find(angle(Z))) = 0;
figure; mesh(x, y, Z); title('实际物体的三维轮廓'); 

%--------------第二步，调制相位产生-------------------
var   = 2 * pi * f.* ones(h, 1) * x; % 原始相位
var_d = 2 * pi * f * d.* Z/ len;    % 调制相位

mkdir imgs;
% 原始光栅
I01 = 1 + cos(var);               
I02 = 1 + cos(var + pi / 2);
I03 = 1 + cos(var + pi);
I04 = 1 + cos(var + 3 * pi / 2);
% 变形光栅
I01d = 1 + cos(var + var_d);
I02d = 1 + cos(var + pi/2 + var_d);
I03d = 1 + cos(var + pi + var_d);
I04d = 1 + cos(var + 3 * pi / 2 + var_d);
end

