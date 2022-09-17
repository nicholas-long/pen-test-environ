FROM kalilinux/kali-rolling

WORKDIR /root

RUN apt update

ADD stuff-that-docker-needs.sh .
RUN ./stuff-that-docker-needs.sh

RUN useradd -ms /bin/bash coyote
RUN usermod --shell /bin/bash coyote
RUN echo "coyote\tALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD . /home/coyote/pen-test-environ/
RUN chown -R coyote:coyote /home/coyote/pen-test-environ

USER coyote
WORKDIR /home/coyote

RUN cd /home/coyote/pen-test-environ && ./setup-environment.sh

RUN touch ~/.hushlogin

ENTRYPOINT [ "tmux", "-u" ]
