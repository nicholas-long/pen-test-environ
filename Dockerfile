FROM kalilinux/kali-rolling

RUN apt update
RUN apt install -y git seclists neovim fzf tmux
RUN apt install -y ltrace

RUN useradd -ms /bin/bash coyote
USER coyote
WORKDIR /home/coyote

ADD .environ .
ADD init.sh .

ADD neovim-bindings.vim /home/coyote/.config/nvim/init.vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/coyote/.vim/bundle/Vundle.vim
RUN git clone https://github.com/nicholas-long/kb
RUN touch .hustlogin
#RUN nvim -c ':execute "normal! :PluginInstall<CR>:q!\<CR>"'


ENTRYPOINT [ "bash" ]

