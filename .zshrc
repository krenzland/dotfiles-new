HISTFILE=~/.histfile
HISTSIZE=9999999
SAVEHIST=9999999
bindkey -e

# End of lines added by compinstall

ZGEN_RESET_ON_CHANGE=("${HOME}/.zshrc")
source "${HOME}/bin/zgen/zgen.zsh"

if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/colorize
    zgen oh-my-zsh plugins/common-aliases
    zgen oh-my-zsh themes/blinks
    zgen save

fi

export EDITOR="vi"

# Used functions
# Setup git repository for dotfiles, see e.g.
# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

function ownip() {
    command curl --silent 'https://httpbin.org/ip' | command grep -o -e '[0-9\.]*' 
}

function agr() {
    (cd $(git root) && ag $1)
}

export PATH=$HOME/bin:$PATH:${HOME}/.local/bin/
export LD_LIBRARY_PATH=$HOME/lib:$HOME/lib64:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$HOME/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$HOME/include:$CPLUS_INCLUDE_PATH
export LD_LIBRARY_PATH="${HOME}/lib:${LD_LIBRARY_PATH}"
export PKG_CONFIG_PATH="${HOME}/lib/pkgconfig/:${PKG_CONFIG_PATH}"

# PC specific settings
function __sccs_settings() {
    export PATH=/work/krenz/bin/texlive/2019/bin/x86_64-linux:$PATH
    source /home/software/intel/bin/compilervars.sh intel64 # Intel compiler
    export I_MPI_CC="/usr/bin/gcc-9"
    export I_MPI_CXX="/usr/bin/g++-9"
    export I_MPI_F90="/usr/bin/gfortran-9"

    # Spack
    export SPACK_ROOT="${HOME}/src/spack/"
    export PATH="${SPACK_ROOT}/bin:${PATH}"

}

function __xps_settings() {
    # Anaconda
    PATH=~/bin/anaconda3/bin:$PATH
}

function __thinkpad_settings() {

}

case "$(hostname)" in
    *sccs*)  __sccs_settings ;;
    *xps*)  __xps_settings ;;
    *thinkpad*) __thinkpad_settings ;;
    *) echo "Default";;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


