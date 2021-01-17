# Update Golang Lambda Functions with Docker

By using this repository, you can update your `lambda` functions without installing `golang` or `aws-cli` on any operating system.

## Requirements

You just need to have [Docker](https://docs.docker.com/get-docker/) installed. 

## Usage

Edit the `main.go` file. Type your information in the `your_aws_acces_key_id`, `your_aws_region` and `your_aws_secret_access_key` fields in the Dockerfile.

And run the following command in your working directory:
``` bash
docker build -t mhmtbtn/hello .
```

That is all...