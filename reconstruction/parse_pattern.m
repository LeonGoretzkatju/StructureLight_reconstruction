function [phase] = parse_pattern(I01, I02, I03, I04)
[width, height] = size(I01);  
%��λ����ĳ�ʼ��
phase = zeros(300, 300);
for w = 1: width
    for h = 1: height
        s = abs(atan((I02(w, h) - I04(w, h)) / (I01(w, h) - I03(w, h))));
        if(I02(w, h) >= I04(w, h))     % sin(var) < 0
            if(I01(w, h) <= I03(w, h)) % cos(var) > 0
                phase(w, h) = -s;      % ��������
            else
                phase(w, h) = s - pi;  % ��������
            end
        else                           % sin(var) > 0
            if(I01(w, h) <= I03(w, h)) % cos(var) > 0
                phase(w, h) = s;       % ��һ����
            else
                phase(w, h) = pi - s;  % �ڶ�����
            end
        end
    end
end
end

