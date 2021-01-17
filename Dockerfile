FROM golang:1.15-alpine3.12 as builder

RUN mkdir /go/src/mhmtbtn

WORKDIR /go/src/mhmtbtn

#install nano, zip and git
RUN apk add nano zip git

#install golang dependencies
RUN go get -u github.com/aws/aws-lambda-go/lambda

#install aws cli
RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/*

COPY ./ ./

#build main
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main

#zip main
RUN zip main.zip main

#update the lambda function
RUN export AWS_ACCESS_KEY_ID=your_aws_acces_key_id \
    AWS_DEFAULT_REGION=your_aws_region \
    AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key && \
    aws configure list && \
    aws lambda update-function-code --function-name  hello --zip-file fileb://main.zip

#docker build . -t hello