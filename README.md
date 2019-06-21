# pizero_opencv_and_friends
Docker image for Raspberry Pi Zero with OpenCV 4.1, Dlib 19.17.0, Scikit-learn, Scikit-Image and Scikit-Video


To generate the image directly on your PC, first install:  
```$ sudo apt install qemu qemu-user-static binfmt-support-```

And this line is responsible for enabling it (MUST run after a restart):    
```$ docker run --privileged linuxkit/binfmt:v0.7```


On your Raspberry Pi Zero or PC:  
```$ docker run --rm -v $(pwd):/data --privileged -it ricardodeazambuja/pizero_opencv_and_friends bash```

**Warning:**  
The argument ``--privileged`` gives full access to docker. See more [here](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities).
