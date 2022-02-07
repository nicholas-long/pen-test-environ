FROM kalilinux/kali-rolling

WORKDIR /root


RUN apt update
RUN apt install -y git seclists neovim fzf tmux

ADD setup-environ.sh .
RUN /root/setup-environ.sh

ADD neovim-bindings.vim /root/.vimrc

ENTRYPOINT [ "tmux" ]

