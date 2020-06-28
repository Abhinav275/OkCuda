NVCC=nvcc -std=c++11

###################################
# These are the default install   #
# locations on most linux distros #
###################################

OPENCV_LIBPATH=/usr/local/lib/
OPENCV_INCLUDEPATH=/usr/local/include/opencv4

###################################################
# On Macs the default install locations are below #
###################################################

#OPENCV_LIBPATH=/usr/local/lib
#OPENCV_INCLUDEPATH=/usr/local/include

# or if using MacPorts

#OPENCV_LIBPATH=/opt/local/lib
#OPENCV_INCLUDEPATH=/opt/local/include

OPENCV_LIBS=-lopencv_core -lopencv_imgproc -lopencv_highgui

CUDA_INCLUDEPATH=/usr/local/cuda-10.2/include

######################################################
# On Macs the default install locations are below    #
# ####################################################

#CUDA_INCLUDEPATH=/usr/local/cuda/include
#CUDA_LIBPATH=/usr/local/cuda/lib

NVCC_OPTS=-O3 -Xcompiler -Wall -Xcompiler -Wextra -m64

GCC_OPTS=-O3 -Wall -Wextra -m64

student: main.o student_func.o compare.o reference_calc.o Makefile
	$(NVCC) -o HW1 main.o student_func.o compare.o reference_calc.o `pkg-config --cflags --libs opencv4` $(OPENCV_LIBS) $(NVCC_OPTS)

main.o: main.cpp timer.h utils.h reference_calc.cpp compare.cpp HW1.cpp
	g++ -std=c++11 -c main.cpp $(GCC_OPTS) -L $(OPENCV_LIBPATH) $(OPENCV_LIBS) -I $(CUDA_INCLUDEPATH) -I $(OPENCV_INCLUDEPATH)

student_func.o: student_func.cu utils.h
	nvcc -std=c++11 -c student_func.cu $(NVCC_OPTS)

compare.o: compare.cpp compare.h
	g++ -std=c++11 -c compare.cpp -L $(OPENCV_LIBPATH) $(OPENCV_LIBS) -I $(OPENCV_INCLUDEPATH) $(GCC_OPTS) -I $(CUDA_INCLUDEPATH)

reference_calc.o: reference_calc.cpp reference_calc.h
	g++ -std=c++11 -c reference_calc.cpp -I $(OPENCV_INCLUDEPATH) $(GCC_OPTS) -I $(CUDA_INCLUDEPATH)

clean:
	rm -f *.o *.png hw
