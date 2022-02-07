FROM kalilinux/kali-rolling

RUN apt update
RUN apt install -y git seclists neovim fzf tmux
RUN apt install -y git seclists neovim fzf tmux
RUN apt install -y ltrace
RUN apt install -y exploitdb bsdmainutils

ADD bat_0.19.0_amd64.deb .
RUN dpkg -i bat_0.19.0_amd64.deb

RUN useradd -ms /bin/bash coyote
RUN usermod --shell /bin/bash coyote
USER coyote
WORKDIR /home/coyote

ADD .environ .
ADD init.sh .

ADD neovim-bindings.vim /home/coyote/.config/nvim/init.vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/coyote/.vim/bundle/Vundle.vim
RUN git clone https://github.com/nicholas-long/kb
RUN touch .hushlogin
#RUN nvim -c ':execute "normal! :PluginInstall<CR>:q!\<CR>"'
ADD search-fzf-sploit.sh ./tmux-scripts/search-fzf-sploit.sh
ADD preview.sh ./tmux-scripts/preview.sh
ADD tmux.conf .tmux.conf
RUN echo "TERM=xterm-256color" >> .bashrc


ENTRYPOINT [ "tmux", "-u" ]

