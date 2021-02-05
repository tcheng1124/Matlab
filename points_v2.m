function [w,x,y,z] = ch_(domain_name,name,mum_per_z,AA)
directory = dir(domain_name);
s = size(directory);%for for loop
count = 0;
mu = [];
intensity_total = 0;

for u = 1:s(1)%goes through every image in the folder
    f = strfind(directory(u).name,'.tif');
    f_size = size(f);
    if f_size(1,1) == 1
        count = count + 1;
        r = imread(directory(u).name);
%         r_size = size(r);
%         A = r_size(1)*r_size(2);
        R_r = r(:,:,1);
        R_g = r(:,:,2);
        R_b = r(:,:,3);
%         r_sum(count) = sum(R_r(:))/A;
%         g_sum(count) = sum(R_g(:))/A;
%         b_sum(count) = sum(R_b(:))/A;
        r_sum(count) = sum(R_r(:))/AA;
        g_sum(count) = sum(R_g(:))/AA;
        b_sum(count) = sum(R_b(:))/AA;
        mu(count) = count*mum_per_z;
        imwrite(R_r, strcat(name,'_red.tiff'),'WriteMode', 'append', 'Compression', 'none')
        imwrite(R_g, strcat(name,'_green.tiff'),'WriteMode', 'append', 'Compression', 'none')
        imwrite(R_b, strcat(name,'_blue.tiff'),'WriteMode', 'append', 'Compression', 'none')
        intensity_total = intensity_total + r_sum(count)+g_sum(count)+b_sum(count);
    end
end

figure(100)
hold on
title('Mean Red Channel Intensity Distribution')
plot(mu,r_sum)
xlabel('mu(microns)')
ylabel('Intensity/mu^2(micron^2)')
hold off

figure(101)
hold on
title('Mean Green Channel Intensity Distribution')
plot(mu,g_sum)
xlabel('mu(microns)')
ylabel('Intensity/mu^2(micron^2 )')
hold off

figure(102)
hold on
title('Mean Blue Channel Intensity Distribution')
plot(mu,b_sum)
xlabel('mu(microns)')
ylabel('Intensity/mu^2(micron^2)')
hold off

intensity_total;
new_int_tot = 0;

for o = 1:count
    rrr = imread(strcat(name,'_red.tiff'),o);
    ggg = imread(strcat(name,'_green.tiff'),o);
    bbb = imread(strcat(name,'_blue.tiff'),o);
%     s = size(rrr);
    rrr_sum = sum(rrr(:));
    ggg_sum = sum(ggg(:));
    bbb_sum = sum(bbb(:));
    new_int_tot = new_int_tot +rrr_sum+ggg_sum+bbb_sum;
end
new_int_tot= new_int_tot/AA;
% new_int_tot= new_int_tot/(s(1)*s(2));

Intensity_ratio = new_int_tot/intensity_total

w = mu;
x= r_sum;
y= g_sum;
z = b_sum;

end

