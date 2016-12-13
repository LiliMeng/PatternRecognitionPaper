clear all;
close all;

[tree, RootName, DOMnode] = xml_read('/home/lci/PR2017/matlabCode/xmlIOTools/00000000.xml')
 
pts_2d_char=tree.pts_2d.data;
 
pts_2d_double_tmp=strread(pts_2d_char);

pts_2d_double=reshape(pts_2d_double_tmp,[],2);



pts_3d_char=tree.pts_3d.data;

pts_3d_double_tmp=strread(pts_3d_char);

pts_3d_double=reshape(pts_3d_double_tmp,[],3);


fid1 = fopen('/home/lci/PR2017/matlabCode/pts2d.txt', 'w');

[N_pts2d, d_pts2d]=size(pts_2d_double);
[N_pts3d, d_pts3d]=size(pts_3d_double);

for i=1:N_pts2d
    fprintf(fid1, '%d %d\n', pts_2d_double(i,1), pts_2d_double(i,2));
end

fclose(fid1);

fid2 = fopen('/home/lci/PR2017/matlabCode/pts3d.txt', 'w');

[N_pts3d, d_pts3d]=size(pts_3d_double);

for i=1:N_pts3d
    fprintf(fid2, '%d %d %d\n', pts_3d_double(i,1), pts_3d_double(i,2),pts_3d_double(i,3));
end

fclose(fid2);
