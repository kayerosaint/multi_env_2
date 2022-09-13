FROM alpine/terragrunt:1.1.3

RUN apk update && apk upgrade
RUN apk add bash groff openssh git vim jq make cmake curl gcc aws-cli

WORKDIR /infra

ENV PS1 '\[\033[1;37m\]($(echo `terraform workspace show`)) \[\033[1;33m\]\u \[\033[1;36m\]\h \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'

RUN echo 'alias t=terragrunt' > ~/.bashrc

ENTRYPOINT "bash"
