# Use the specified base image
FROM python:3.12-alpine

# Install required packages
RUN apk update && apk add --no-cache \
    zsh \
    fzf \
    zoxide \
    eza \
    tmux \
    stow \
    git \
    nodejs \
    neovim \
    ripgrep \
    build-base \
    wget \
    curl \
    openssh-client

# Clone the NvChad starter repository
RUN git clone https://github.com/NvChad/starter /root/.config/nvim

# Install zinit
RUN zsh -y -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install p10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# RUN echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

RUN echo 'q'

# Clone dotfiles from repository
RUN git clone --depth=1 https://github.com/Troublesis/dotfile.git $HOME/dotfiles \
    && cd $HOME/dotfiles

RUN cp ~/dotfiles/.zshrc ~/dotfiles/.zshrc.bak

RUN cp ~/dotfiles/.zshrc ~/dotfiles/.zshrc.rep

RUN cp ~/dotfiles/.zshrc.bak ~/.zshrc

# RUN source $HOME/.zshrc

# Set the working directory
WORKDIR /root

# Command to keep the container running
CMD ["zsh"]


