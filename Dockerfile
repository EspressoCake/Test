FROM mono:latest
LABEL maintainer="jlucas@ingressive.com"

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND noninteractive 

EXPOSE 8080

WORKDIR /root

RUN apt-get update && \
    apt-get install file -y && \
    apt-get install apt-utils -y && \
    apt-get install git iproute2 -y && \
    apt-get install net-tools -y && \
    apt-get install screen -y && \
    git clone https://github.com/outflanknl/EvilClippy.git

WORKDIR /root/EvilClippy
ADD EvilClippyDocs/* /root/EvilClippy/

RUN mcs /reference:OpenMcdf.dll,System.IO.Compression.FileSystem.dll /out:EvilClippy.exe *.cs 

ENTRYPOINT ["mono", "EvilClippy.exe", "-s", "webvba.vba", "-w", "8080", "-g", "-r", "templateTest.dot"]

