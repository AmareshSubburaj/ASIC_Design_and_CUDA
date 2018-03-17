# Import the os module, for the os.walk function
import os
import csv


rootDir = '/usr/local/'
for dirName, subdirList, fileList in os.walk(rootDir):
    if(dirName == "/usr/local/cuda-8.0"):
        with open("envset.sh", "w") as fp:
            string1 = "export PATH=/usr/local/cuda-8.0/bin:$PATH\nexport LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH\nexport CUDA_PATH=\"/usr/local/cuda-8.0\""
            fp.write(string1)
    elif (dirName == "/usr/local/cuda-7.5"):
        with open("envset.sh", "w") as fp:
            string1 = "export PATH=/usr/local/cuda-7.5/bin:$PATH\nexport LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH\nexport CUDA_PATH=\"/usr/local/cuda-7.5\""
            fp.write(string1)


