# syntax=docker/dockerfile:1

#FROM ros:noetic
#RUN apt-get update && apt-get install -y \
#      ros-${ROS_DISTRO}-demo-nodes-cpp \
#      ros-${ROS_DISTRO}-demo-nodes-py && \

# install ros package
#RUN apt-get update && apt-get install -y \
#      ros-${ROS_DISTRO}-demo-nodes-cpp \
#      ros-${ROS_DISTRO}-demo-nodes-py && \
#    rm -rf /var/lib/apt/lists/*

# launch ros package
#CMD ["ros2", "launch", "demo_nodes_cpp", "talker_listener.launch.py"]

  
#FROM ros:galactic

# install ros package
#RUN apt-get update && apt-get install -y \
#        git

#RUN mkdir Dev/
#RUN mkdir Dev/ROS2
#RUN cd Dev/ROS2 && git clone https://github.com/YonyIIT/april_ros2.git
#RUN /bin/bash -c "source Dev/ROS2/april_ros2/scripts/ros2_init.sh"

#      ros-${ROS_DISTRO}-demo-nodes-cpp \
#      ros-${ROS_DISTRO}-demo-nodes-py && \
#    rm -rf /var/lib/apt/lists/*

# launch ros package
#CMD ["ros2", "launch", "demo_nodes_cpp", "talker_listener.launch.py"]

#FROM golang:1.16 AS builder
#WORKDIR /go/src/github.com/alexellis/href-counter/
#RUN go get -d -v golang.org/x/net/html  
#COPY app.go ./
#RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o app .

#FROM alpine:latest  
#RUN apk --no-cache add ca-certificates
#WORKDIR /root/
#COPY --from=builder /go/src/github.com/alexellis/href-counter/app ./
#CMD ["./app"]  


#FROM ubuntu:20.04

#ENV TERM linux
#ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get update
#RUN apt-get install -y  

#CMD ["/bin/bash"]


#FROM ubuntu:20.04

#ENV TERM linux
#ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get update
#RUN apt-get install -y  

#CMD ["/bin/bash"]

#COPY /scripts/ /scripts/

FROM ubuntu:20.04


# install app dependencies
#xRUN apt-get update && apt-get install -y python3 python3-pip
#RUN pip install flask==2.1.*
RUN apt-get update && apt-get install -y lsb-release && apt-get clean all
RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# install app
COPY /scripts/ /scripts/
#RUN cd /scripts/ && /bin/bash -c "source 1_first_time_april_total_deploy.sh" 
RUN cd /scripts/ && /bin/bash -c "source ros2_install.sh" 
RUN cd /scripts/april_ros2 && /bin/bash -c "source april_ros_build.sh" 
RUN cd /scripts/april_ros2 && /bin/bash -c "source april_ros_run.sh" 

#CMD . /scripts/1_first_time_april_total_deploy.sh

# final configuration
#ENV FLASK_APP=hello
#EXPOSE 8000
#CMD flask run --host 0.0.0.0 --port 8000
