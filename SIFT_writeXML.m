clear all;
close all;

%% Read original XML file
frame_num=1000
xml_filename = sprintf('/home/lci/PR2017/matlabCode/SIFTData/%08d.xml',frame_num)

[tree, RootName, DOMnode] = xml_read(xml_filename)
 



NN_sift=load('/home/lci/PR2017/matlabCode/SIFTData/NN_sift_frame01000.mat')

distance = NN_sift.distance;

NN_pts2d_tmp = transpose(NN_sift.NN_pts2d);
NN_pts3d_tmp = transpose(NN_sift.NN_pts3d);
NN_sift_descriptor_tmp= transpose(NN_sift.NNsift_descriptor);

NN_pts2d = reshape(NN_pts2d_tmp,1,[]);
NN_pts3d = reshape(NN_pts3d_tmp,1,[]);
NN_sift_descriptor = reshape(NN_sift_descriptor_tmp,1,[]);

[N_pts2d,d_pts2d] = size(NN_sift.NN_pts2d);
[N_pts3d,d_pts3d] = size(NN_sift.NN_pts3d);
[N_sift, d_sift] = size(NN_sift.NNsift_descriptor);

NN_pts2d_char='';
for i=1:length(NN_pts2d)
    NN_pts2d_char_tmp=num2str(NN_pts2d(i));
    NN_pts2d_char = char(strcat({NN_pts2d_char}, {' '},{NN_pts2d_char_tmp}));
end

NN_pts3d_char='';
for i=1:length(NN_pts3d)
    NN_pts3d_char_tmp=num2str(NN_pts3d(i));
    NN_pts3d_char = char(strcat({NN_pts3d_char}, {' '}, {NN_pts3d_char_tmp}));
end

NN_sift_char='';
for i=1:length(NN_sift_descriptor)
    NN_sift_char_tmp=num2str(NN_sift_descriptor(i));
    NN_sift_char = char(strcat({NN_sift_char}, {' '}, {NN_sift_char_tmp}));
end




%% Write XML file based on a Struct using "xml_write"
% Any MATLAB data struct can be saved to XML file.
MyTree=[];
MyTree.image_name = tree.image_name;
MyTree.K = tree.K;
MyTree.R = tree.R;
MyTree.T = tree.T;
MyTree.radial = tree.radial;
MyTree.pts2d.rows = N_pts2d;
MyTree.pts2d.cols = 1;
MyTree.pts2d.dt = '"2d"';
MyTree.pts2d.data = NN_pts2d_char;
MyTree.pts2d.ATTRIBUTE.type_id = 'opencv-matrix';
MyTree.pts3d.rows = N_pts3d;
MyTree.pts3d.cols = 1;
MyTree.pts3d.dt = '3d';
MyTree.pts3d.data = NN_pts3d_char;
MyTree.pts3d.ATTRIBUTE.type_id = 'opencv-matrix';
MyTree.sift.rows = N_sift;
MyTree.sift.cols = 1;
MyTree.sift.data = NN_sift_char;
MyTree.sift.ATTRIBUTE.type_id = 'opencv-matrix';

new_xml_filename = sprintf('/home/lci/PR2017/matlabCode/SIFTData/new_%08d.xml',frame_num)
xml_write(new_xml_filename, MyTree);
