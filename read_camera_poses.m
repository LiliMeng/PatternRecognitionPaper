clear all;
close all;

[tree, RootName, DOMnode] = xml_read('/Users/jimmy/Desktop/Nvm_BTDTR/Street_separate/Street_east/estimated_poses/camera_000000.xml')
 
estimated_pose_char=strsplit(tree.estimated_pose.data);

for i=1:length(estimated_pose_char)
    estimated_pose_char_tmp(i)=str2num(cell2mat(estimated_pose_char(i)));
end

estimated_pose_char_tmp1=reshape(estimated_pose_char_tmp,4,4);

estimated_pose = transpose(estimated_pose_char_tmp1)
