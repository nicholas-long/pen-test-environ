FROM kalilinux/kali-rolling

RUN apt update
RUN apt install -y git seclists neovim fzf tmux git seclists neovim fzf tmux ltrace exploitdb bsdmainutils wget python3-pip

ADD bat_0.19.0_amd64.deb .
RUN dpkg -i bat_0.19.0_amd64.deb
RUN cd /usr/bin && wget https://github.com/akavel/up/releases/download/v0.4/up && chmod +x /usr/bin/up

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
RUN nvim -c ':PluginInstall' -c ':q' -c ':q'

RUN git clone https://github.com/carlospolop/hacktricks

ADD tmux.conf .tmux.conf
RUN echo "TERM=xterm-256color" >> .bashrc

ADD tmux-scripts tmux-scripts
RUN cd tmux-scripts && git clone https://github.com/nicholas-long/tmux-pwn-menu || ls -al tmux-pwn-menu
RUN python3 -m pip install -r $HOME/tmux-scripts/tmux-pwn-menu/requirements.txt
#ADD lazygit_0.32.2_Linux_x86_64.tar.gz tmux-scripts/
ADD banner .
RUN echo "cat ~/banner" >> .bashrc

ENTRYPOINT [ "tmux", "-u" ]

