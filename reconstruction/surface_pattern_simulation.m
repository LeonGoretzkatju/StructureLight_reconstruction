function [I01, I02, I03, I04, I01d, I02d, I03d, I04d] = surface_pattern_simulation(w, h, f, d, len)
x = 1:w;
y = 1:h;
[X, Y] = meshgrid(x, y);
Z = 0.4*sqrt(100*100-(X-150).^2-(Y-150).^2);
Z(find(angle(Z))) = 0;
figure; mesh(x, y, Z); title('ʵ���������ά����'); 

%--------------�ڶ�����������λ����-------------------
var   = 2 * pi * f.* ones(h, 1) * x; % ԭʼ��λ
var_d = 2 * pi * f * d.* Z / len;    % ������λ

mkdir imgs;
% ԭʼ��դ
I01 = 1 + cos(var);               
I02 = 1 + cos(var + pi / 2);
I03 = 1 + cos(var + pi);
I04 = 1 + cos(var + 3 * pi / 2);
% ���ι�դ
I01d = 1 + cos(var + var_d);
I02d = 1 + cos(var + pi/2 + var_d);
I03d = 1 + cos(var + pi + var_d);
I04d = 1 + cos(var + 3 * pi / 2 + var_d);
end

