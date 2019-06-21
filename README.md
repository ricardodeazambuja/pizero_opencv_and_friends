# pizero_opencv_and_friends
[Docker image](https://hub.docker.com/r/ricardodeazambuja/pizero_opencv_and_friends) for Raspberry Pi Zero with OpenCV 4.1, Dlib 19.17.0, Scikit-learn, Scikit-Image and Scikit-Video.


To generate the image directly on your PC, first install:  
```$ sudo apt install qemu qemu-user-static binfmt-support-```

And this line is responsible for enabling it (MUST run after a restart):    
```$ docker run --privileged linuxkit/binfmt:v0.7```

To install docker on the Raspberry Pi Zero (tested on Raspbian Stretch Lite, 2019-04-08):  
```$ curl -fsSL https://get.docker.com -o get-docker.sh```  
```$ sudo sh get-docker.sh```  
However, the lines above will install a version that does NOT work with the Zero (2019-06-21), but it will install dependencies and add the docker to the sources list. After that, let's downgrade docker:  
```$ sudo apt-get install docker-ce=18.06.2~ce~3-0~raspbian```  
```$ sudo groupadd docker```  
```$ sudo usermod -aG docker $USER```  
Finally, the good ol' reboot:  
```$ sudo reboot now```  

On your Raspberry Pi Zero or PC:  
```$ docker run --rm -v $(pwd):/data --privileged -it ricardodeazambuja/pizero_opencv_and_friends bash```

**Warning:**  
The argument ``--privileged`` gives full access to docker. See more [here](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities).
