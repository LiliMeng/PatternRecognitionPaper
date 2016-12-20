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
opencv_storage=[];
opencv_storage.image_name = tree.image_name;
opencv_storage.K = tree.K;
opencv_storage.R = tree.R;
opencv_storage.T = tree.T;
opencv_storage.radial = tree.radial;
opencv_storage.pts_2d.rows = N_pts2d;
opencv_storage.pts_2d.cols = 1;
opencv_storage.pts_2d.dt = '"2d"';
opencv_storage.pts_2d.data = NN_pts2d_char;
opencv_storage.pts_2d.ATTRIBUTE.type_id = 'opencv-matrix';
opencv_storage.pts_3d.rows = N_pts3d;
opencv_storage.pts_3d.cols = 1;
opencv_storage.pts_3d.dt = '"3d"';
opencv_storage.pts_3d.data = NN_pts3d_char;
opencv_storage.pts_3d.ATTRIBUTE.type_id = 'opencv-matrix';
opencv_storage.sift.rows = N_sift;
opencv_storage.sift.cols = 128;
opencv_storage.sift.dt = tree.K.dt;
opencv_storage.sift.data = NN_sift_char;
opencv_storage.sift.ATTRIBUTE.type_id = 'opencv-matrix';

new_xml_filename = sprintf('/home/lci/PR2017/matlabCode/SIFTData/new_%08d.xml',frame_num)
xml_write(new_xml_filename, opencv_storage);

