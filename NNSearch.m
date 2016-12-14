clear all;
close all;

sift_data=load('/home/lci/PR2017/matlabCode/SIFTData/sift_frame00178.mat');

pts2d=load('/home/lci/PR2017/matlabCode/SIFTData/pts2d.txt');
pts3d=load('/home/lci/PR2017/matlabCode/SIFTData/pts3d.txt');

pts2d_sift(:,1)=sift_data.f(1,:);
pts2d_sift(:,2)=sift_data.f(2,:);

%[IDX, D] = knnsearch(pts2d(1),pts2d_sift);

%figure
%plot(pts2d(:,1),pts2d(:,2),'*');
%hold on;
%plot(pts2d_sift(:,1),pts2d_sift(:,2),'o');
%legend('SIFT from Changchang Wu','SIFT from VLfeat');

figure
x=pts2d_sift;
%gscatter(x(:,1),x(:,2))

[N_pts2d, d]=size(pts2d);

fid1 = fopen('/home/lci/PR2017/matlabCode/SIFTData/sift_index.txt', 'w');

for i=1:N_pts2d
    
    queryPoint = pts2d(i,:);
    %line(newpoint(1),newpoint(2),'marker','x','color','k',...
    % 'markersize',10,'linewidth',2)

   % Mdl = KDTreeSearcher(pts2d_sift)
    Mdl =  createns(pts2d_sift,'NSMethod','kdtree','Distance','euclidean','BucketSize',10);

    
    [n,d] = knnsearch(Mdl,queryPoint,'k',1);
%line(x(n,1),x(n,2),'color',[.5 .5 .5],'marker','o',...
    %'linestyle','none','markersize',10)
    sift_index(i)=n
    distance(i)=d;
    NNpts(i,:)=x(n,:);
    fprintf(fid1, '%d %d %d %d\n', n, d, x(n,1),x(n,2));
end

%inlier percentage
count1=0;
count2=0;
for i=1:N_pts2d
    if distance(i)<1
        count1=count1+1;
    end
end

inlier_percen1=count1/N_pts2d

for i=1:N_pts2d
    if distance(i)<2
        count2=count2+1;
    end
end

inlier_percen2=count2/N_pts2d
