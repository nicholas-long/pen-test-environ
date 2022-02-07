FROM kalilinux/kali-rolling

RUN apt update
RUN apt install -y git seclists neovim fzf tmux
RUN apt install -y ltrace

RUN useradd -ms /bin/bash coyote
USER coyote
WORKDIR /home/coyote

ADD .environ .

ADD neovim-bindings.vim /home/coyote/.config/nvim/.vimrc

ENTRYPOINT [ "bash" ]

