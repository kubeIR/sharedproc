FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update --yes
RUN apt install software-properties-common wget git gcc --yes

RUN wget -P /tmp https://dl.google.com/go/go1.16.7.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go1.16.7.linux-amd64.tar.gz && \
    rm -f /tmp/go1.16.7.linux-amd64.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && \
    chmod -R 777 "$GOPATH"

RUN add-apt-repository ppa:criu/ppa --yes && \
    apt update --yes && \
    apt install criu --yes

RUN git clone --depth 1 https://github.com/containerd/containerd.git && \
    cd containerd && \
    go build -o /usr/bin/ctr cmd/ctr/main.go

CMD ["cat"]
