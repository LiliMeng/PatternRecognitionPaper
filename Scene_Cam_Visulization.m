clear all;
close all;

set(gcf,'Renderer','OpenGL');
gridStep = 1;
for i=1:30
    ply_filename = sprintf('/media/lci/storage/KingsCollege/dense.nvm.cmvs/00/models/option-%04d.ply',i)
    ptCloud = pcdenoise(pcread(ply_filename));
    downsampled=pcdownsample(ptCloud,'gridAverage',gridStep);
    pcshow(downsampled);
    hold on;
end


cameraSize=1;    

for l=0:10:341
    
     poseRTFileName = sprintf('/home/lci/PR2017/visualization/BT16_estimated_poses/camera_%06d.xml', l)
    
    [tree, RootName, DOMnode] = xml_read(poseRTFileName);


    groundtruth_pose_char=strsplit(tree.groundtruth_pose.data);


    for i=1:length(groundtruth_pose_char)
        groundtruth_pose_double_tmp(i)=str2num(cell2mat(groundtruth_pose_char(i)));
    end

    groundtruth_pose_double_tmp1=reshape(groundtruth_pose_double_tmp,4,4);

    groundtruth_pose_double = transpose(groundtruth_pose_double_tmp1);

    estimated_pose_char=strsplit(tree.estimated_pose.data);


    for i=1:length(estimated_pose_char)
        estimated_pose_double_tmp(i)=str2num(cell2mat(estimated_pose_char(i)));
    end

    estimated_pose_double_tmp1=reshape(estimated_pose_double_tmp,4,4);

    estimated_pose_double = transpose(estimated_pose_double_tmp1);

    for j=1:3
      for k=1:3
          R_gt(j,k)=groundtruth_pose_double(j,k);
      end
    end
  
    for m=1:3
      T_gt(m)=groundtruth_pose_double(m,4);
    end 
  
    for j=1:3
      for k=1:3
          R_est(j,k)=estimated_pose_double(j,k);
      end
    end
  
    for m=1:3
      T_est(m)=estimated_pose_double(m,4);
    end 

    
    cam1 = plotCamera('Location',T_gt,'Orientation',R_gt,'Size', cameraSize, ...
     'Color', 'y', 'Opacity', 0);
    grid on
    axis equal
    axis manual
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    hold on;
    cam2 = plotCamera('Location',T_est,'Orientation',R_est,'Size', cameraSize, ...
     'Color', 'r', 'Opacity', 0.4);

end

xlim([-40 100])
ylim([-50 20])
zlim([0 20])
view(3)
