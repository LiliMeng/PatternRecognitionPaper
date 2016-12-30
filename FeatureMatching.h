//
//  FeatureMatching.h
//  OutdoorCameraReloc
//
//  Created by Lili on 12/29/16.
//  Copyright (c) 2016 Nowhere Planet. All rights reserved.
//

#ifndef __OutdoorCameraReloc__FeatureMatching__
#define __OutdoorCameraReloc__FeatureMatching__



#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <assert.h>
#include "eigenVLFeatSIFT.h"
#include "vl_sift_param.h"
#include "eigenFlann.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include "cv_draw.hpp"

using std::string;
using std::vector;
using std::cout;
using std::endl;


class FeatureMatching
{
public:
    FeatureMatching();
    ~FeatureMatching();
    
    static bool sift_featureMatching(string img1_name,
                                     string img2_name,
                                     string match_filename,
                                     string matched_img);
};



#endif /* defined(__OutdoorCameraReloc__FeatureMatching__) */


