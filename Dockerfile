FROM ubuntu:19.10

ENV DEBIAN_FRONTEND noninteractive
ENV GOPATH "/go"
ENV PATH "$PATH:/usr/local/go/bin:$GOPATH/bin"

# Install dependencies
RUN apt-get update
RUN apt-get install curl linux-libc-dev git-all build-essential -y

# Install go
RUN curl -O https://storage.googleapis.com/golang/go1.13.12.linux-armv6l.tar.gz
RUN tar -xvf go1.13.12.linux-armv6l.tar.gz
RUN chown -R root:root ./go
RUN mv go /usr/local

# Get ethereum code
RUN git clone https://github.com/ethereum/go-ethereum
WORKDIR /go-ethereum
RUN make geth

EXPOSE 30303

ENTRYPOINT ["/go-ethereum/build/bin/geth"]
