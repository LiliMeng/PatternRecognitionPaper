clear all;
close all;

data = dlmread('/Users/jimmy/Desktop/ICRA2017/SCRF_RGBD_train/4scenes_balanced_v2_new_param/apt1/kitchen/error.txt', '\t', 1, 0);

data_camera_pose=load('/Users/jimmy/Desktop/ICRA2017/SCRF_RGBD_train/4scenes_balanced_v2_new_param/apt1/kitchen/test_files/outfile2.txt')

[N,d]=size(data);
fid = fopen('apt1_kitchen_pose_error.txt', 'w');

for i=1:N
    fprintf(fid, '%d %f %f\n',data_camera_pose(i),data(i,1),data(i,2));
    A(i,:)=[data_camera_pose(i),data(i,1),data(i,2)];
end
fclose(fid);

B=sortrows(A)

figure 
plot(B(:,2))
title('rotation error');

figure 
plot(B(:,3))
title('translation error');
