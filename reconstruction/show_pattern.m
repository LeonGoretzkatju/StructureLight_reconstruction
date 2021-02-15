function [] = show_pattern(I01, I02, I03, I04, suptitle)
% π‚’§Õº∆¨
subplot(2, 2, 1);  imshow(I01); title('I01');
subplot(2, 2, 2);  imshow(I02); title('I02');
subplot(2, 2, 3);  imshow(I03); title('I03');
subplot(2, 2, 4);  imshow(I04); title('I04'); 
 pause;
end

