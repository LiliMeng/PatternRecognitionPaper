#include <opencv2/core/core.hpp>
#include <iostream>
#include <string>

using namespace cv;
using namespace std;


int main(int ac, char** av)
{

  //  string filename = "/home/lci/PR2017/CppCode/00001000.xml";
   //string filename = "/home/lci/PR2017/CppCode/new_00001000.xml";
    //string filename = "/home/lci/PR2017/CppCode/new1_00001000.xml";
     string filename = "/home/lci/PR2017/matlabCode/SIFTData/new_00001000.xml";
    //string filename = "/home/lci/PR2017/CppCode/I.xml";
    {//read
        cout << endl << "Reading: " << endl<<endl;
        FileStorage fs;
        fs.open(filename, FileStorage::READ);


        FileNode n = fs["image_name"];

        FileNodeIterator it = n.begin(), it_end = n.end(); // Go through the node
        for (; it != it_end; ++it)
            cout << (string)*it << endl;


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

        fs["sift"] >> sift;

        cout<<"pts_2d "<<pts_2d<<endl;

        cout<<"pts_3d "<<pts_3d<<endl;

        cout<<"sift "<<sift<<endl;




    }

    return 0;
}
