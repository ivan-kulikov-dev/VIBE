FROM nvidia/cudagl:10.1-runtime

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends software-properties-common \
 && add-apt-repository ppa:deadsnakes/ppa \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends \
        build-essential \
	bash \
	nano \
	curl \
	python3.7 \
	python3.7-dev\
	git \
	unzip \
	libglib2.0-0 \
	libsm6 \
	freeglut3-dev \
	ffmpeg \
	wget \
	python3-pip \
	python3-setuptools \
 && python3.7 -m pip install --upgrade pip \
 && python3.7 -m pip install --upgrade setuptools \
 && python3.7 -m pip install wheel \
 && python3.7 -m pip install git+https://github.com/giacaglia/pytube.git \
 && python3.7 -m pip install numpy==1.17.5 torch==1.4.0 torchvision==0.5.0 numba==0.49.1 \
 && rm /usr/bin/python3 /usr/bin/python3m \
 && ln -s /usr/bin/python3.7 /usr/bin/python3 \
 && ln -s /usr/bin/python3.7m /usr/bin/python3m
 

COPY . /opt/vibe
WORKDIR /opt/vibe

RUN python3.7 -m pip install -r requirements.txt
RUN ./scripts/prepare_data.sh

# VOLUME ["/opt/vibe/output", "/opt/vibe/vibe_data"]

CMD ["/bin/bash"]
