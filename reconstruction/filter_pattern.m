function [I01, I02, I03, I04] = filter_pattern(I01, I02, I03, I04)
kernel = fspecial('gaussian', 9, 1);%������˹��ͨ�˲���
I01 = double(filter2(kernel, double(I01)));
I02 = double(filter2(kernel, double(I02)));
I03 = double(filter2(kernel, double(I03)));
I04 = double(filter2(kernel, double(I04)));
