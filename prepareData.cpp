void test_extract_framename_from_xml()
{
     
     ofstream fout("/Users/jimmy/Desktop/PR2017/dataPreparation/ShopFacade/xml_frame_list.txt");
     
     for(int i=0; i<334; i++)
     //int i=0;
     {
     
     char filename[1024] = {NULL};
     
     sprintf(filename,"/Users/jimmy/Desktop/images/posenet/ShopFacade_frames/%08d.xml",i);
     
     
     //cout << endl << "Reading: " << endl<<endl;
     FileStorage fs;
     fs.open(filename, FileStorage::READ);
     
     
     FileNode n = fs["image_name"];
     
     FileNodeIterator it = n.begin(), it_end = n.end(); // Go through the node
   
     for (; it != it_end; ++it)
     {
     cout << (string)*it << endl;
     fout << (string)*it << endl;
     }
     
 
    /*
     Mat K, R, T;
     
     fs["K"] >> K;
     fs["R"] >> R;                                      // Read cv::Mat
     fs["T"] >> T;
     
     cout<<endl;
     cout<< "K = "<< K <<endl<<endl;
     cout << endl
     << "R = " << R << endl<<endl;
     
     cout << "T = " << T << endl << endl;
     
     FileNode radi = fs["radial"];                         // Read string sequence - Get node
     
     FileNodeIterator it1 = radi.begin(), it1_end = radi.end(); // Go through the node
     for (; it1 != it1_end; ++it1)
     cout << (string)*it1 << endl;
     
     Mat pts_2d, pts_3d, sift;
     
     fs["pts_2d"] >> pts_2d;
     
     fs["pts_3d"] >> pts_3d;
     */
    //fs["sift"] >> sift;
    
    //cout<<"pts_2d "<<pts_2d<<endl;
    
    // cout<<"pts_3d "<<pts_3d<<endl;
    
    // cout<<"sift "<<sift<<endl;
    }

}

void test_xml()
{
    ofstream fout2("/Users/jimmy/Desktop/PR2017/dataPreparation/ShopFacade/train_xml_list.txt");
    ofstream fout3("/Users/jimmy/Desktop/PR2017/dataPreparation/ShopFacade/test_xml_list.txt");
    
    
    const char* filename_train="/Users/jimmy/Desktop/PR2017/dataPreparation/ShopFacade/train_imgfile.txt";
  
    vector<string> train_file_vec=Ms7ScenesUtil::read_file_names(filename_train);
    
    const char* filename_test="/Users/jimmy/Desktop/PR2017/dataPreparation/ShopFacade/test_imgfile.txt";
    
    vector<string> test_file_vec=Ms7ScenesUtil::read_file_names(filename_test);
    
    const char* xml_img_filename="/Users/jimmy/Desktop/PR2017/dataPreparation/ShopFacade/new_xml_list.txt";
    
    vector<string> xml_img_file_vec=Ms7ScenesUtil::read_file_names(xml_img_filename);
    
    const char* xml_filename="/Users/jimmy/Desktop/PR2017/dataPreparation/ShopFacade/nvm_sift_list.txt";
    
    vector<string> xml_file_vec=Ms7ScenesUtil::read_file_names(xml_filename);
    
    assert(xml_img_file_vec.size()==xml_file_vec.size());
    
    vector<int> matched_train_vec, matched_train_xml_vec;
    
    for(int i=0; i<train_file_vec.size();i++)
    {
        for(int j=0; j<xml_img_file_vec.size();j++)
        {
            if(strcmp(train_file_vec[i].c_str(), xml_img_file_vec[j].c_str())==0)
            {
               // cout<<"i "<<i<<" j "<<j<<"  they are equal"<<endl;
                matched_train_xml_vec.push_back(i);
                matched_train_vec.push_back(j);
                fout2<<xml_file_vec[j]<<endl;
            }
        }
    
    }
    
    assert(matched_train_xml_vec.size()==matched_train_vec.size());
    
    cout<<"matched_train_xml_vec.size() "<<matched_train_xml_vec.size()<<endl;
    
    vector<int> matched_test_vec, matched_test_xml_vec;
    
    for(int i=0; i<test_file_vec.size();i++)
    {
        for(int j=0; j<xml_img_file_vec.size();j++)
        {
            if(strcmp(test_file_vec[i].c_str(), xml_img_file_vec[j].c_str())==0)
            {
               // cout<<"i "<<i<<" j "<<j<<"  test file they are equal"<<endl;
                matched_test_xml_vec.push_back(i);
                matched_test_vec.push_back(j);
                fout3<<xml_file_vec[j]<<endl;
            }
        }
        
    }
    
    assert(matched_test_xml_vec.size()==matched_test_vec.size());
    
    cout<<"matched_test_xml_vec.size() "<<matched_test_xml_vec.size()<<endl;
}
