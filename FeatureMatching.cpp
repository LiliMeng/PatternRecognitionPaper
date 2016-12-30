//
//  FeatureMatching.cpp
//  OutdoorCameraReloc
//
//  Created by Lili on 12/29/16.
//  Copyright (c) 2016 Nowhere Planet. All rights reserved.
//

#include <iostream>
#include "FeatureMatching.h"
#include "eigenVLFeatSIFT.h"

using std::vector;
using std::string;


bool FeatureMatching::sift_featureMatching(string img1_name, string img2_name,
                                           string match_filename, string matched_img)
{
    //extract SIFT descriptor from image1
    
    cv::Mat img1 = cv::imread(img1_name.c_str(), 1);
    assert(!img1.empty());
    
    // detect SIFT keypoint
    vector<std::shared_ptr<sift_keypoint> > keypoints1;
    
    vl_feat_sift_parameter sift_param;
    
    EigenVLFeatSIFT::extractSIFTKeypoint(img1, sift_param, keypoints1, false);
    
    cout<<"keypoints1.size() from img1:  "<<keypoints1.size()<<endl;
    
    Eigen::Matrix<float, Eigen::Dynamic, Eigen::Dynamic, Eigen::RowMajor> sift1_eigen_matrix;
    EigenVLFeatSIFT::descriptorToMatrix(keypoints1, sift1_eigen_matrix);
    
    //extract SIFT descriptor from image2
    
    cv::Mat img2 = cv::imread(img2_name.c_str(), 1);
    assert(!img2.empty());
    
    // detect SIFT keypoint
    vector<std::shared_ptr<sift_keypoint> > keypoints2;
    
    EigenVLFeatSIFT::extractSIFTKeypoint(img2, sift_param, keypoints2, false);
    
    cout<<"keypoints2.size() from img2:   "<<keypoints2.size()<<endl;
    
    Eigen::Matrix<float, Eigen::Dynamic, Eigen::Dynamic, Eigen::RowMajor> sift2_eigen_matrix;
    EigenVLFeatSIFT::descriptorToMatrix(keypoints2, sift2_eigen_matrix);
    
    
    //Feature Matching using FLANN, keypoints1 as query_data, keypoints2 as data pool;
    const int trees = 4;
    
    cout<<"number of trees for Flann "<<trees<<endl;
    EigenFlann<float> flann;
    flann.setData(sift2_eigen_matrix, trees);
    
    vector<vector<int> >  indices;
    const int knn=3;
    vector<vector<float> > dists;
    cout<<"knn "<<knn<<endl;
    flann.search(sift1_eigen_matrix, indices, dists, knn, 128);
    
    cout<<"indices.size() "<<indices.size()<<endl;
    cout<<"dists.size() "<<dists.size()<<endl;
    
    
    
    //find the location of keypoints in image
    vector<cv::Point2d> pts1, pts2;
    
    /// Process Nearest Neighbor Distance Ratio
    float nndRatio = 0.6;
    
    for (int i = 0; i<indices.size(); i++) {
        
        if(dists[i][0]<nndRatio*dists[i][1])
        {
            pts1.push_back(cv::Point2d(keypoints1[i]->location_x(), keypoints1[i]->location_y()));
            pts2.push_back(cv::Point2d(keypoints2[indices[i][0]]->location_x(), keypoints2[indices[i][0]]->location_y()));
        }
    }
    assert(pts1.size()==pts2.size());
    
    cout<<"matched_points size  "<<pts1.size()<<endl;
    
    
    cv::hconcat(img1,img2,img1);
    
    for(int i=0; i<pts1.size(); i++)
    {
        cv::line(img1, cv::Point2i(pts1[i]),cv::Point2i(pts2[i])+ cv::Point2i(img2.cols, 0), cv::Scalar(255, 0, 0), 1, 8, 0);
        
    }
    
    
    
 //   cv::namedWindow( "SIFT featureMatching", cv::WINDOW_AUTOSIZE );// Create a window for display.
    
 //   cv::imshow( "SIFT featureMatching", img1 );                   // Show our image inside it.
    
    cv::imwrite(matched_img, img1);
    
    
    cv::FileStorage fs(match_filename, cv::FileStorage::WRITE);
    
    if (!fs.isOpened())    {
        std::cerr << "Failed to open " << match_filename << std::endl;
        return false;
    }
    
    
    fs<<"image_name"<<img1_name;
    fs<<"image_name"<<img2_name;
    fs<<"pts_2d"<<pts1;
    fs<<"pts_2d"<<pts2;
    
    return true;
    
}
