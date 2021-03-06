clear all;
close all;

[tree, RootName, DOMnode] = xml_read('/home/lci/PR2017/matlabCode/xmlIOTools/00000000.xml')
 
pts_2d_char=strsplit(tree.pts_2d.data);

for i=1:length(pts_2d_char)
    pts_2d_double_tmp(i)=str2num(cell2mat(pts_2d_char(i)));
end

pts_2d_double_tmp1=reshape(pts_2d_double_tmp,2,[]);

pts_2d_double = transpose(pts_2d_double_tmp1);


pts_3d_char=strsplit(tree.pts_3d.data);

for i=1:length(pts_3d_char)
    pts_3d_double_tmp(i)=str2num(cell2mat(pts_3d_char(i)));
end


pts_3d_double_tmp1=reshape(pts_3d_double_tmp,3,[]);
pts_3d_double = transpose(pts_3d_double_tmp1);



[N_pts2d, d_pts2d]=size(pts_2d_double);
[N_pts3d, d_pts3d]=size(pts_3d_double);

assert(N_pts2d==N_pts3d);

fid1 = fopen('/home/lci/PR2017/matlabCode/SIFTData/pts2d.txt', 'w');

for i=1:N_pts2d
    fprintf(fid1, '%d %d\n', pts_2d_double(i,1), pts_2d_double(i,2));
end

fclose(fid1);

fid2 = fopen('/home/lci/PR2017/matlabCode/SIFTData/pts3d.txt', 'w');

[N_pts3d, d_pts3d]=size(pts_3d_double);

for i=1:N_pts3d
    
    fprintf(fid2, '%d %d %d\n', pts_3d_double(i,1), pts_3d_double(i,2),pts_3d_double(i,3));
end

fclose(fid2);
