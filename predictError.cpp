//
//  main.cpp
//  LoopClosure
//
//  Created by Lili on 2016-02-16.
//  Copyright © 2016 jimmy. All rights reserved.
//

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include "cvxImage_310.hpp"
#include "cvxIO.hpp"
#include "cvxPoseEstimation.hpp"
#include "ms7ScenesUtil.hpp"
#include "dataset_param.h"
#include <numeric>


using namespace::std;

#if 1

double l2_norm(vector<double> const& u) {
    double accum = 0.;
    for (double x : u) {
        accum += x * x;
    }
    return sqrt(accum);
}

static void help()
{
    printf("program             predictionFile     saveFile  \n");
    printf("PredictionError     predictions/*.txt  predError \n");
    printf("predictionFile: predicted 3D location files\n");
    printf("saveFile: predicted 3D location error (meter) \n");
}

int main(int argc, const char * argv[])
{
   /* if (argc != 3) {
        help();
        printf("parameter number is %d, should be 8.\n", argc);
        return -1;
    }
    
   
    const char *prediction_folder        = argv[1];
    const char *predictionErrorFileName = argv[2];
    */
     
    
    const char *prediction_folder = "/Users/jimmy/Desktop/BT_random_v1/4scenes/apt2/living_depth25_nobalance/unbalanced_predictions/*.txt";
    const char *predictionErrorFileName = "apt2_living_unbalanced_predictions_error.txt";
    
    
    ofstream fout(predictionErrorFileName);
   
    
    vector<string> files = CvxIO::read_files(prediction_folder);
    assert(files.size() > 0);
    
    vector<double> pred_error;
    
    for(int k = 0; k < files.size(); k++)
    {
        string cur_file = files[k];
        string rgb_img_file, depth_img_file, camera_pose_file;
        cout<<cur_file<<endl;
        
        vector<cv::Point2d> img_pts;
        vector<cv::Point3d> wld_pts_gt;
        vector< vector<cv::Point3d> > wld_pts_pred_candidate;
        vector< vector<double > > candidate_feature_dists;
        cout<<"hello"<<endl;
        bool is_read = Ms7ScenesUtil::load_prediction_result_with_distance(cur_file.c_str(), rgb_img_file, depth_img_file, camera_pose_file,
                                                                           img_pts, wld_pts_gt, wld_pts_pred_candidate, candidate_feature_dists);
       
        assert(is_read);
        
        for(int i=0; i<wld_pts_pred_candidate.size(); i++)
        {
            double error_x = wld_pts_gt[i].x - wld_pts_pred_candidate[i][0].x;
            double error_y = wld_pts_gt[i].y - wld_pts_pred_candidate[i][0].y;
            double error_z = wld_pts_gt[i].z - wld_pts_pred_candidate[i][0].z;
            
            double distance=sqrt(error_x*error_x+error_y*error_y+error_z*error_z);
            cout<<distance<<endl;
            fout<<distance<<endl;
            pred_error.push_back(distance);
        }
       
       
  
    }
   
    cout<<"predicted points number"<<pred_error.size()<<endl;
    
    return 0;
}

#endif
