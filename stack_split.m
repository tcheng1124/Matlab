clear all; close all

%directory search
thisfile = uigetdir('stackanalysis.m');
directory = dir(thisfile);
s = size(directory);%Will be needed for the for loop below
count = 1;

mum_per_z = double(1); % microns per stack thickness of z.
im_height = 101.6149 ;%image height in microns;
im_width =101.6149; %image width in microns;
im_A = double(im_width*im_height); %image area calculated from im_width and im_height
set(0, 'DefaultTextInterpreter', 'none')
name = "New folder (2) 2"; %EXACT name of the folder of interest.



%looping through all folders
for u = 3:s(1)

%     fil = filter__(directory(u).name, ch_f);%disregards every folder not including CH_f.
    name_find = size(strfind(directory(u).name, name));
    if directory(u).name ~= name
        0;
    else
        directory(u).name
        addpath(directory(u).name)
        pull(count) = string(directory(u).name);
        d_ = strcat(thisfile, '/', directory(u).name); %renaming direcotory for dir() in points(d_)
        [l, R, G, B] = points_v2(d_, directory(u).name,mum_per_z, im_A);
        m = [l',R',G',B'];
        count = count + 1;
    end
end

