#!/bin/sh

apt update && apt upgrade -y && 
pkg install wget -y && 
echo "clear && proot-distro login kali" >> $PREFIX/etc/bash.bashrc && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/setup.sh | sh && 
proot-distro login kali


chsh -s ["/~"]=$ nano
cat /data/data/com.termux/files/usr/etc/bash.bashrc
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
        command_not_found_handle() {
                 "[/~]$1"

                ["/~]$ pkg upgradeable
chmod a+x $PREFIX
[~]$ pkg upgradeable
apt install -y proot-distro 
###
wget -O $PREFIX/etc/proot-distro/kali.sh https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/kali.sh
###
chmod a+x $PREFIX/etc/proot-distro/kali.sh
###
proot-distro install kali 

***$$$$*** ~$chsh -s [`/~"]=$ = ~$ nano
`# cat /data/data/com.termux/files/usr/etc/bash.bashrc
if [ /chmod chroot a+x /data/data/com.termux/files/ ]



#!/bin/bash
# Top-level build script called from Dockerfile

# Stop at any error, show all commands
set -exuo pipefail

# Get script directory
MY_DIR=$(dirname "${BASH_SOURCE[0]}")

# Get build utilities
source $MY_DIR/build_utils.sh

# Install newest automake
check_var ${AUTOMAKE_ROOT}
check_var ${AUTOMAKE_HASH}
check_var ${AUTOMAKE_DOWNLOAD_URL}

AUTOMAKE_VERSION=${AUTOMAKE_ROOT#*-}
if automake --version > /dev/null 2>&1; then
	# || test $? -eq 141 is there to ignore SIGPIPE with set -o pipefail
	# c.f. https://stackoverflow.com/questions/22464786/ignoring-bash-pipefail-for-error-code-141#comment60412687_33026977
	INSTALLED=$((automake --version | head -1 || test $? -eq 141) | awk '{ print $NF }')
	SMALLEST=$(echo -e "${INSTALLED}\n${AUTOMAKE_VERSION}" | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | head -1 || test $? -eq 141)
	if [ "${SMALLEST}" == "${AUTOMAKE_VERSION}" ]; then
		echo "skipping installation of automake ${AUTOMAKE_VERSION}, system provides automake ${INSTALLED}"
		exit 0
	fi
fi

fetch_source ${AUTOMAKE_ROOT}.tar.gz ${AUTOMAKE_DOWNLOAD_URL}
check_sha256sum ${AUTOMAKE_ROOT}.tar.gz ${AUTOMAKE_HASH}
tar -zxf ${AUTOMAKE_ROOT}.tar.gz
pushd ${AUTOMAKE_ROOT}
DESTDIR=/manylinux-rootfs do_standard_install
popd
rm -rf ${AUTOMAKE_ROOT} ${AUTOMAKE_ROOT}.tar.gz

# Strip what we can
strip_ /manylinux-rootfs

# Install
cp -rlf /manylinux-rootfs/* /

# Remove temporary rootfs
rm -rf /manylinux-rootfs

hash -r
automake --version

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

configure_prompt() {
    prompt_symbol=㉿
    # Skull emoji for root terminal
    #[ "$EUID" -eq 0 ] && prompt_symbol=💀
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            user=kali
            PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'$user%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            # Right-side prompt with exit codes and background processes
            #RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
            ;;
        oneline)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
        backtrack)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
    esac
    unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    configure_prompt

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=bold
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
       ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

source /.kali-config/language.conf



echo -e "\e[1;32m"
echo " __    _  _______  _       _________   _       _________ _     _  _     _          ";
echo "|  |  / \|  ___  || |      \__   __/  | |      \__   __/| \   | || |   | ||\     /|";
echo "|  | /  /| |   | || |         | |     | |         | |   |  \  | || |   | || \   / |";
echo "|  |/  / | |___| || |         | |     | |         | |   |   \ | || |   | | \ \_/ / ";
echo "|     {  |  ___  || |         | |     | |         | |   | |\ \| || |   | |  ) _ (  ";
echo "|  |\  \ | |   | || |         | |     | |         | |   | | \   || |   | | / / \ \ ";
echo "|  | \  \| |   | || |____/\___| |___  | |____/\___| |___| |  \  || |___| || /   \ |";
echo "|__|  \_/|_|   |_||_______/\_______/  |_______/\_______/|_|   \_||_______||/     \|";
echo "                                                                                   ";
echo " _     _  _______ _________ _     _  _     _  _     _ _________ _______  _______   ";
echo "| \   | || _____ \ __   __/| |   | || |   | || \   | |\__   __/|  ____ \|  ____ |  ";
echo "|  \  | || |    \/   | |   | |   | || |   | ||  \  | |   | |   | |    \/| |    ||  ";
echo "|   \ | || |__       | |   | |___| || |   | ||   \ | |   | |   | |__    | |____||  ";
echo "| |\ \| ||  __|      | |   |  ___  || |   | || |\ \| |   | |   |  __|   |     __|  ";
echo "| | \   || |         | |   | |   | || |   | || | \   |   | |   | |      | |\ \     ";
echo "| |  \  || |____/\   | |   | |   | || |___| || |  \  |   | |   | |____/\| | \ \__  ";
echo "|_|   \_||_______/   |_|   |_|   |_||_______||_|   \_|   |_|   |_______/|_|  \___| ";
echo

#!/bin/bash
# Top-level build script called from Dockerfile

# Stop at any error, show all commands
set -exuo pipefail

# Get script directory
MY_DIR=$(dirname "${BASH_SOURCE[0]}")

# Get build utilities
source $MY_DIR/build_utils.sh

# Install a more recent openssl
check_var ${OPENSSL_ROOT}
check_var ${OPENSSL_HASH}
check_var ${OPENSSL_DOWNLOAD_URL}

OPENSSL_VERSION=${OPENSSL_ROOT#*-}
OPENSSL_MIN_VERSION=1.1.1

# || test $? -eq 141 is there to ignore SIGPIPE with set -o pipefail
# c.f. https://stackoverflow.com/questions/22464786/ignoring-bash-pipefail-for-error-code-141#comment60412687_33026977
INSTALLED=$((openssl version | head -1 || test $? -eq 141) | awk '{ print $2 }')
SMALLEST=$(echo -e "${INSTALLED}\n${OPENSSL_MIN_VERSION}" | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | head -1 || test $? -eq 141)

# Ignore letters in version numbers
if [ "${SMALLEST}" = "${OPENSSL_MIN_VERSION}" ]; then
	echo "skipping installation of openssl ${OPENSSL_VERSION}, system provides openssl ${INSTALLED} which is newer than openssl ${OPENSSL_MIN_VERSION}"
	exit 0
fi

if which yum; then
	yum erase -y openssl-devel
else
	apk del openssl-dev
fi

fetch_source ${OPENSSL_ROOT}.tar.gz ${OPENSSL_DOWNLOAD_URL}
check_sha256sum ${OPENSSL_ROOT}.tar.gz ${OPENSSL_HASH}
tar -xzf ${OPENSSL_ROOT}.tar.gz
pushd ${OPENSSL_ROOT}
./config no-shared --prefix=/usr/local/ssl --openssldir=/usr/local/ssl CPPFLAGS="${MANYLINUX_CPPFLAGS}" CFLAGS="${MANYLINUX_CFLAGS} -fPIC" CXXFLAGS="${MANYLINUX_CXXFLAGS} -fPIC" LDFLAGS="${MANYLINUX_LDFLAGS} -fPIC" > /dev/null
make > /dev/null
make install_sw > /dev/null
popd
rm -rf ${OPENSSL_ROOT} ${OPENSSL_ROOT}.tar.gz


/usr/local/ssl/bin/openssl version


#!/bin/bash
# Install packages that will be needed at runtime

# Stop at any error, show all commands
set -exuo pipefail

# Set build environment variables
MY_DIR=$(dirname "${BASH_SOURCE[0]}")

# Get build utilities
source $MY_DIR/build_utils.sh

# Libraries that are allowed as part of the manylinux2014 profile
# Extract from PEP: https://www.python.org/dev/peps/pep-0599/#the-manylinux2014-policy
# On RPM-based systems, they are provided by these packages:
# Package:    Libraries
# glib2:      libglib-2.0.so.0, libgthread-2.0.so.0, libgobject-2.0.so.0
# glibc:      libresolv.so.2, libutil.so.1, libnsl.so.1, librt.so.1, libpthread.so.0, libdl.so.2, libm.so.6, libc.so.6
# libICE:     libICE.so.6
# libX11:     libX11.so.6
# libXext:    libXext.so.6
# libXrender: libXrender.so.1
# libgcc:     libgcc_s.so.1
# libstdc++:  libstdc++.so.6
# mesa:       libGL.so.1
#
# PEP is missing the package for libSM.so.6 for RPM based system
#
# With PEP600, more packages are allowed by auditwheel policies
# - libz.so.1
# - libexpat.so.1


# MANYLINUX_DEPS: Install development packages (except for libgcc which is provided by gcc install)
if [ "${AUDITWHEEL_POLICY}" == "manylinux2014" ] || [ "${AUDITWHEEL_POLICY}" == "manylinux_2_28" ]; then
	MANYLINUX_DEPS="glibc-devel libstdc++-devel glib2-devel libX11-devel libXext-devel libXrender-devel mesa-libGL-devel libICE-devel libSM-devel zlib-devel expat-devel"
elif [ "${AUDITWHEEL_POLICY}" == "musllinux_1_1" ]; then
	MANYLINUX_DEPS="musl-dev libstdc++ glib-dev libx11-dev libxext-dev libxrender-dev mesa-dev libice-dev libsm-dev zlib-dev expat-dev"
else
	echo "Unsupported policy: '${AUDITWHEEL_POLICY}'"
	exit 1
fi

# RUNTIME_DEPS: Runtime dependencies. c.f. install-build-packages.sh
if [ "${AUDITWHEEL_POLICY}" == "manylinux2014" ] || [ "${AUDITWHEEL_POLICY}" == "manylinux_2_28" ]; then
	RUNTIME_DEPS="zlib bzip2 expat ncurses readline gdbm libpcap xz openssl keyutils-libs libkadm5 libcom_err libidn libcurl uuid libffi libdb"
    if [ "${AUDITWHEEL_POLICY}" == "manylinux_2_28" ]; then
        RUNTIME_DEPS="${RUNTIME_DEPS} tk"
    fi
elif [ "${AUDITWHEEL_POLICY}" == "musllinux_1_1" ]; then
	RUNTIME_DEPS="zlib bzip2 expat ncurses5-libs readline tk gdbm db xz openssl keyutils-libs krb5-libs libcom_err libidn2 libcurl libuuid libffi"
else
	echo "Unsupported policy: '${AUDITWHEEL_POLICY}'"
	exit 1
fi

BASETOOLS="autoconf automake bison bzip2 diffutils file make patch unzip"
if [ "${AUDITWHEEL_POLICY}" == "manylinux2014" ]; then
	PACKAGE_MANAGER=yum
	BASETOOLS="${BASETOOLS} hardlink hostname which"
	# See https://unix.stackexchange.com/questions/41784/can-yum-express-a-preference-for-x86-64-over-i386-packages
	echo "multilib_policy=best" >> /etc/yum.conf
	# Error out if requested packages do not exist
	echo "skip_missing_names_on_install=False" >> /etc/yum.conf
	# Make sure that locale will not be removed
	sed -i '/^override_install_langs=/d' /etc/yum.conf
	# Exclude mirror holding broken package metadata
	echo "exclude = d36uatko69830t.cloudfront.net" >> /etc/yum/pluginconf.d/fastestmirror.conf
	yum -y update
	yum -y install yum-utils curl
	yum-config-manager --enable extras
	TOOLCHAIN_DEPS="devtoolset-10-binutils devtoolset-10-gcc devtoolset-10-gcc-c++ devtoolset-10-gcc-gfortran"
	if [ "${AUDITWHEEL_ARCH}" == "x86_64" ]; then
		# Software collection (for devtoolset-10)
		yum -y install centos-release-scl-rh
		# EPEL support (for yasm)
		yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
		TOOLCHAIN_DEPS="${TOOLCHAIN_DEPS} yasm"
	elif [ "${AUDITWHEEL_ARCH}" == "aarch64" ] || [ "${AUDITWHEEL_ARCH}" == "ppc64le" ] || [ "${AUDITWHEEL_ARCH}" == "s390x" ]; then
		# Software collection (for devtoolset-10)
		yum -y install centos-release-scl-rh
	elif [ "${AUDITWHEEL_ARCH}" == "i686" ]; then
		# No yasm on i686
		# Install mayeut/devtoolset-10 repo to get devtoolset-10
		curl -fsSLo /etc/yum.repos.d/mayeut-devtoolset-10.repo https://copr.fedorainfracloud.org/coprs/mayeut/devtoolset-10/repo/custom-1/mayeut-devtoolset-10-custom-1.repo
	fi
elif [ "${AUDITWHEEL_POLICY}" == "manylinux_2_28" ]; then
	PACKAGE_MANAGER=dnf
	BASETOOLS="${BASETOOLS} curl glibc-locale-source glibc-langpack-en hardlink hostname libcurl libnsl libxcrypt which"
	# See https://unix.stackexchange.com/questions/41784/can-yum-express-a-preference-for-x86-64-over-i386-packages
	echo "multilib_policy=best" >> /etc/yum.conf
	# Error out if requested packages do not exist
	echo "skip_missing_names_on_install=False" >> /etc/yum.conf
	# Make sure that locale will not be removed
	sed -i '/^override_install_langs=/d' /etc/yum.conf
	dnf -y upgrade
	dnf -y install dnf-plugins-core
	dnf config-manager --set-enabled powertools # for yasm
	TOOLCHAIN_DEPS="gcc-toolset-12-binutils gcc-toolset-12-gcc gcc-toolset-12-gcc-c++ gcc-toolset-12-gcc-gfortran"
	if [ "${AUDITWHEEL_ARCH}" == "x86_64" ]; then
		TOOLCHAIN_DEPS="${TOOLCHAIN_DEPS} yasm"
	fi
elif [ "${AUDITWHEEL_POLICY}" == "musllinux_1_1" ]; then
	TOOLCHAIN_DEPS="binutils gcc g++ gfortran"
	BASETOOLS="${BASETOOLS} curl util-linux tar"
	PACKAGE_MANAGER=apk
	apk add --no-cache ca-certificates gnupg
else
	echo "Unsupported policy: '${AUDITWHEEL_POLICY}'"
	exit 1
fi

if [ "${PACKAGE_MANAGER}" == "yum" ]; then
	yum -y install ${BASETOOLS} ${TOOLCHAIN_DEPS} ${MANYLINUX_DEPS} ${RUNTIME_DEPS}
elif [ "${PACKAGE_MANAGER}" == "apk" ]; then
	apk add --no-cache ${BASETOOLS} ${TOOLCHAIN_DEPS} ${MANYLINUX_DEPS} ${RUNTIME_DEPS}
elif [ "${PACKAGE_MANAGER}" == "dnf" ]; then
	dnf -y install --allowerasing ${BASETOOLS} ${TOOLCHAIN_DEPS} ${MANYLINUX_DEPS} ${RUNTIME_DEPS}
else
	echo "Not implemented"
	exit 1
fi

# update system packages, we already updated them but
# the following script takes care of cleaning-up some things
# and since it's also needed in the finalize step, everything's
# centralized in this script to avoid code duplication
LC_ALL=C ${MY_DIR}/update-system-packages.sh

if [ "${BASE_POLICY}" == "manylinux" ]; then
	# we'll be removing libcrypt.so.1 later on
	# this is needed to ensure the new one will be found
	# as LD_LIBRARY_PATH does not seem enough.
	# c.f. https://github.com/pypa/manylinux/issues/1022
	echo "/usr/local/lib" > /etc/ld.so.conf.d/00-manylinux.conf
	ldconfig
fi


#!/bin/bash
# Install packages that will be needed at runtime

# Stop at any error, show all commands
set -exuo pipefail


# if a devel package is added to COMPILE_DEPS,
# make sure the corresponding library is added to RUNTIME_DEPS if applicable

if [ "${AUDITWHEEL_POLICY}" == "manylinux2014" ] || [ "${AUDITWHEEL_POLICY}" == "manylinux_2_28" ]; then
	COMPILE_DEPS="bzip2-devel ncurses-devel readline-devel gdbm-devel libpcap-devel xz-devel openssl openssl-devel keyutils-libs-devel krb5-devel libcom_err-devel libidn-devel curl-devel uuid-devel libffi-devel kernel-headers libdb-devel"
	if [ "${AUDITWHEEL_POLICY}" == "manylinux2014" ]; then
		PACKAGE_MANAGER=yum
	else
		PACKAGE_MANAGER=dnf
		COMPILE_DEPS="${COMPILE_DEPS} tk-devel"
	fi
elif [ "${AUDITWHEEL_POLICY}" == "musllinux_1_1" ]; then
	PACKAGE_MANAGER=apk
	COMPILE_DEPS="bzip2-dev ncurses-dev readline-dev tk-dev gdbm-dev libpcap-dev xz-dev openssl openssl-dev keyutils-dev krb5-dev libcom_err libidn-dev curl-dev util-linux-dev libffi-dev linux-headers"
else
	echo "Unsupported policy: '${AUDITWHEEL_POLICY}'"
	exit 1
fi


if [ "${PACKAGE_MANAGER}" == "yum" ]; then
	yum -y install ${COMPILE_DEPS}
	yum clean all
	rm -rf /var/cache/yum
elif [ "${PACKAGE_MANAGER}" == "apk" ]; then
	apk add --no-cache ${COMPILE_DEPS}
elif [ "${PACKAGE_MANAGER}" == "dnf" ]; then
 	dnf -y install --allowerasing ${COMPILE_DEPS}
 	dnf clean all
 	rm -rf /var/cache/yum
else
	echo "Not implemented"
	exit 1
fi



#!/bin/bash

# Stop at any error, show all commands
set -exuo pipefail

# Get script directory
MY_DIR=$(dirname "${BASH_SOURCE[0]}")

# Get build utilities
source $MY_DIR/build_utils.sh

if [ "${BASE_POLICY}" == "musllinux" ]; then
	echo "Skip PyPy build on musllinux"
	exit 0
fi

PYTHON_VERSION=$1
PYPY_VERSION=$2
PYPY_DOWNLOAD_URL=https://downloads.python.org/pypy


function get_shortdir {
	local exe=$1
	$exe -c 'import sys; print("pypy%d.%d-%d.%d.%d" % (sys.version_info[:2]+sys.pypy_version_info[:3]))'
}


mkdir -p /tmp
cd /tmp

case ${AUDITWHEEL_ARCH} in
	x86_64) PYPY_ARCH=linux64;;
	i686) PYPY_ARCH=linux32;;
	aarch64) PYPY_ARCH=aarch64;;
	*) echo "No PyPy for ${AUDITWHEEL_ARCH}"; exit 0;;
esac

EXPAND_NAME=pypy${PYTHON_VERSION}-v${PYPY_VERSION}-${PYPY_ARCH}
TMPDIR=/tmp/${EXPAND_NAME}
TARBALL=${EXPAND_NAME}.tar.bz2
PREFIX="/opt/_internal"

mkdir -p ${PREFIX}

fetch_source ${TARBALL} ${PYPY_DOWNLOAD_URL}

# We only want to check the current tarball sha256sum
grep " ${TARBALL}\$" ${MY_DIR}/pypy.sha256 > ${TARBALL}.sha256
# then check sha256 sum
sha256sum -c ${TARBALL}.sha256

tar -xf ${TARBALL}

# the new PyPy 3 distributions don't have pypy symlinks to pypy3
if [ ! -f "${TMPDIR}/bin/pypy" ]; then
	ln -s pypy3 ${TMPDIR}/bin/pypy
fi

# rename the directory to something shorter like pypy3.7-7.3.4
PREFIX=${PREFIX}/$(get_shortdir ${TMPDIR}/bin/pypy)
mv ${TMPDIR} ${PREFIX}

# add a generic "python" symlink
if [ ! -f "${PREFIX}/bin/python" ]; then
	ln -s pypy ${PREFIX}/bin/python
fi

# remove debug symbols
rm ${PREFIX}/bin/*.debug

# We do not need precompiled .pyc and .pyo files.
clean_pyc ${PREFIX}

#!/bin/bash
# Update system packages

# Stop at any error, show all commands
set -exuo pipefail

# Get script directory
MY_DIR=$(dirname "${BASH_SOURCE[0]}")

# Get build utilities
source $MY_DIR/build_utils.sh

fixup-mirrors
if [ "${AUDITWHEEL_POLICY}" == "manylinux2014" ]; then
	yum -y update
	if ! localedef -V &> /dev/null; then
		# somebody messed up glibc-common package to squeeze image size, reinstall the package
		fixup-mirrors
		yum -y reinstall glibc-common
	fi
	yum clean all
	rm -rf /var/cache/yum
elif [ "${AUDITWHEEL_POLICY}" == "manylinux_2_28" ]; then
	dnf -y upgrade
	dnf clean all
	rm -rf /var/cache/yum
elif [ "${AUDITWHEEL_POLICY}" == "musllinux_1_1" ]; then
	apk upgrade --no-cache
else
	echo "Unsupported policy: '${AUDITWHEEL_POLICY}'"
	exit 1
fi
fixup-mirrors

# do we want to update locales ?
if [ "${BASE_POLICY}" == "manylinux" ]; then
	LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
	TIMESTAMP_FILE=${LOCALE_ARCHIVE}.ml.timestamp
	if [ ! -f ${TIMESTAMP_FILE} ] || [ ${LOCALE_ARCHIVE} -nt ${TIMESTAMP_FILE} ]; then
		# upgrading glibc-common can end with removal on en_US.UTF-8 locale
		localedef -i en_US -f UTF-8 en_US.UTF-8

		# if we updated glibc, we need to strip locales again...
		if localedef --list-archive | grep -sq -v -i ^en_US.utf8; then
			localedef --list-archive | grep -v -i ^en_US.utf8 | xargs localedef --delete-from-archive
		fi
		if [ "${AUDITWHEEL_POLICY}" == "manylinux2014" ]; then
			mv -f ${LOCALE_ARCHIVE} ${LOCALE_ARCHIVE}.tmpl
			build-locale-archive --install-langs="en_US.utf8"
		fi
		touch ${TIMESTAMP_FILE}
	fi
fi

if [ -d /usr/share/locale ]; then
	find /usr/share/locale -mindepth 1 -maxdepth 1 -not \( -name 'en*' -or -name 'locale.alias' \) | xargs rm -rf
fi
if [ -d /usr/local/share/locale ]; then
	find /usr/local/share/locale -mindepth 1 -maxdepth 1 -not \( -name 'en*' -or -name 'locale.alias' \) | xargs rm -rf
fi

# Fix libc headers to remain compatible with C99 compilers.
find /usr/include/ -type f -exec sed -i 's/\bextern _*inline_*\b/extern __inline __attribute__ ((__gnu_inline__))/g' {} +

if [ "${DEVTOOLSET_ROOTPATH:-}" != "" ]; then
	# remove useless things that have been installed/updated by devtoolset
	if [ -d $DEVTOOLSET_ROOTPATH/usr/share/man ]; then
		rm -rf $DEVTOOLSET_ROOTPATH/usr/share/man
	fi
	if [ -d $DEVTOOLSET_ROOTPATH/usr/share/locale ]; then
		find $DEVTOOLSET_ROOTPATH/usr/share/locale -mindepth 1 -maxdepth 1 -not \( -name 'en*' -or -name 'locale.alias' \) | xargs rm -rf
	fi
fi

if [ -d /usr/share/backgrounds ]; then
	rm -rf /usr/share/backgrounds
fi

if [ -d /usr/local/share/man ]; then
	# https://github.com/pypa/manylinux/issues/1060
	# wrong /usr/local/man symlink
	# only delete the content
	rm -rf /usr/local/share/man/*
fi

if [ -f /usr/local/lib/libcrypt.so.1 ]; then
	# Remove libcrypt to only use installed libxcrypt instead
	find /lib* /usr/lib* \( -name 'libcrypt.a' -o -name 'libcrypt.so' -o -name 'libcrypt.so.*' -o -name 'libcrypt-2.*.so' \) -delete
fi

if [ "${BASE_POLICY}" == "musllinux" ]; then
	ldconfig /
elif [ "${BASE_POLICY}" == "manylinux" ]; then
	ldconfig
fi

#!/bin/bash

# Stop at any error, show all commands
set -exuo pipefail

# Get script directory
MY_DIR=$(dirname "${BASH_SOURCE[0]}")

# Get build utilities
source $MY_DIR/build_utils.sh

mkdir /opt/python
for PREFIX in $(find /opt/_internal/ -mindepth 1 -maxdepth 1 \( -name 'cpython*' -o -name 'pypy*' \)); do
	# Some python's install as bin/python3. Make them available as
	# bin/python.
	if [ -e ${PREFIX}/bin/python3 ] && [ ! -e ${PREFIX}/bin/python ]; then
		ln -s python3 ${PREFIX}/bin/python
	fi
    # RYAN w/o this bin can't find libcpython*.so* since we seperate it out with --enable-shared
    export LD_LIBRARY_PATH=${PREFIX}/lib:${LD_LIBRARY_PATH}
	${PREFIX}/bin/python -m ensurepip
	if [ -e ${PREFIX}/bin/pip3 ] && [ ! -e ${PREFIX}/bin/pip ]; then
		ln -s pip3 ${PREFIX}/bin/pip
	fi
	PY_VER=$(${PREFIX}/bin/python -c "import sys; print('.'.join(str(v) for v in sys.version_info[:2]))")
	# Since we fall back on a canned copy of pip, we might not have
	# the latest pip and friends. Upgrade them to make sure.
	${PREFIX}/bin/pip install -U --require-hashes -r ${MY_DIR}/requirements${PY_VER}.txt
	# Create a symlink to PREFIX using the ABI_TAG in /opt/python/
	ABI_TAG=$(${PREFIX}/bin/python ${MY_DIR}/python-tag-abi-tag.py)
	ln -s ${PREFIX} /opt/python/${ABI_TAG}
	# Make versioned python commands available directly in environment.
	if [[ "${PREFIX}" == *"/pypy"* ]]; then
		ln -s ${PREFIX}/bin/python /usr/local/bin/pypy${PY_VER}
	else
		ln -s ${PREFIX}/bin/python /usr/local/bin/python${PY_VER}
	fi
done

# Create venv for auditwheel & certifi
TOOLS_PATH=/opt/_internal/tools
/opt/python/cp310-cp310/bin/python -m venv $TOOLS_PATH
source $TOOLS_PATH/bin/activate

# Install default packages
pip install -U --require-hashes -r $MY_DIR/requirements3.10.txt
# Install certifi and pipx
pip install -U --require-hashes -r $MY_DIR/requirements-base-tools.txt

# Make pipx available in PATH,
# Make sure when root installs apps, they're also in the PATH
cat <<EOF > /usr/local/bin/pipx
#!/bin/bash

set -euo pipefail

if [ \$(id -u) -eq 0 ]; then
	export PIPX_HOME=/opt/_internal/pipx
	export PIPX_BIN_DIR=/usr/local/bin
fi
${TOOLS_PATH}/bin/pipx "\$@"
EOF
chmod 755 /usr/local/bin/pipx

# Our openssl doesn't know how to find the system CA trust store
#   (https://github.com/pypa/manylinux/issues/53)
# And it's not clear how up-to-date that is anyway
# So let's just use the same one pip and everyone uses
ln -s $(python -c 'import certifi; print(certifi.where())') /opt/_internal/certs.pem
# If you modify this line you also have to modify the versions in the Dockerfiles:
export SSL_CERT_FILE=/opt/_internal/certs.pem

# Deactivate the tools virtual environment
deactivate

# install other tools with pipx
pushd $MY_DIR/requirements-tools
for TOOL_PATH in $(find . -type f); do
	TOOL=$(basename ${TOOL_PATH})
	pipx install --pip-args="--require-hashes -r" ${TOOL}
done
popd

# We do not need the precompiled .pyc and .pyo files.
clean_pyc /opt/_internal

# remove cache
rm -rf /root/.cache

hardlink -cv /opt/_internal

# update system packages
LC_ALL=C ${MY_DIR}/update-system-packages.sh

#!/bin/bash
# Fix up mirrors once distro reaches EOL

# Stop at any error, show all commands
set -exuo pipefail

# Utility script to print the python tag + the abi tag for a Python
# See PEP 425 for exactly what these are, but an example would be:
#   cp27-cp27mu

from wheel.vendored.packaging.tags import sys_tags


# first tag is always the more specific tag
tag = next(sys_tags())
print("{0}-{1}".format(tag.interpreter, tag.abi))

a1a84882525dd574c4b051b66e9b7ef0e132392acc2f729420d7825f96835216  pypy3.7-v7.3.7-aarch64.tar.bz2
0ab9e2e8ae1ac463bb811b9d3ba24d138f41f7378c17ca9e2d8dee51bf151d19  pypy3.7-v7.3.7-linux32.tar.bz2
8332f923755441fedfe4767a84601c94f4d6f8475384406cb5f259ad8d0b2002  pypy3.7-v7.3.7-linux64.tar.bz2
cbd44e0a9146b3c03a9d14b265774a848f387ed846316c3e984847e278d0efd3  pypy3.8-v7.3.7-aarch64.tar.bz2
dfb9d005f0fc917edc60fd618143e4934c412f9168b55166f5519ba0a3b1a835  pypy3.8-v7.3.7-linux32.tar.bz2
5dee37c7c3cb8b160028fbde3a5901c68043dfa545a16794502b897d4bc40d7e  pypy3.8-v7.3.7-linux64.tar.bz2
dfc62f2c453fb851d10a1879c6e75c31ffebbf2a44d181bb06fcac4750d023fc  pypy3.7-v7.3.9-aarch64.tar.bz2
3398cece0167b81baa219c9cd54a549443d8c0a6b553ec8ec13236281e0d86cd  pypy3.7-v7.3.9-linux32.tar.bz2
c58195124d807ecc527499ee19bc511ed753f4f2e418203ca51bc7e3b124d5d1  pypy3.7-v7.3.9-linux64.tar.bz2
5e124455e207425e80731dff317f0432fa0aba1f025845ffca813770e2447e32  pypy3.8-v7.3.9-aarch64.tar.bz2
4b261516c6c59078ab0c8bd7207327a1b97057b4ec1714ed5e79a026f9efd492  pypy3.8-v7.3.9-linux32.tar.bz2
08be25ec82fc5d23b78563eda144923517daba481a90af0ace7a047c9c9a3c34  pypy3.8-v7.3.9-linux64.tar.bz2
2e1ae193d98bc51439642a7618d521ea019f45b8fb226940f7e334c548d2b4b9  pypy3.9-v7.3.9-aarch64.tar.bz2
0de4b9501cf28524cdedcff5052deee9ea4630176a512bdc408edfa30914bae7  pypy3.9-v7.3.9-linux32.tar.bz2
46818cb3d74b96b34787548343d266e2562b531ddbaf330383ba930ff1930ed5  pypy3.9-v7.3.9-linux64.tar.bz2
e4caa1a545f22cfee87d5b9aa6f8852347f223643ad7d2562e0b2a2f4663ad98  pypy3.8-v7.3.10-aarch64.tar.bz2
b70ed7fdc73a74ebdc04f07439f7bad1a849aaca95e26b4a74049d0e483f071c  pypy3.8-v7.3.10-linux32.tar.bz2
ceef6496fd4ab1c99e3ec22ce657b8f10f8bb77a32427fadfb5e1dd943806011  pypy3.8-v7.3.10-linux64.tar.bz2
657a04fd9a5a992a2f116a9e7e9132ea0c578721f59139c9fb2083775f71e514  pypy3.9-v7.3.10-aarch64.tar.bz2
b6db59613b9a1c0c1ab87bc103f52ee95193423882dc8a848b68850b8ba59cc5  pypy3.9-v7.3.10-linux32.tar.bz2
95cf99406179460d63ddbfe1ec870f889d05f7767ce81cef14b88a3a9e127266  pypy3.9-v7.3.10-linux64.tar.bz2
9a2fa0b8d92b7830aa31774a9a76129b0ff81afbd22cd5c41fbdd9119e859f55  pypy3.8-v7.3.11-aarch64.tar.bz2
a79b31fce8f5bc1f9940b6777134189a1d3d18bda4b1c830384cda90077c9176  pypy3.8-v7.3.11-linux32.tar.bz2
470330e58ac105c094041aa07bb05676b06292bc61409e26f5c5593ebb2292d9  pypy3.8-v7.3.11-linux64.tar.bz2
09175dc652ed895d98e9ad63d216812bf3ee7e398d900a9bf9eb2906ba8302b9  pypy3.9-v7.3.11-aarch64.tar.bz2
0099d72c2897b229057bff7e2c343624aeabdc60d6fb43ca882bff082f1ffa48  pypy3.9-v7.3.11-linux32.tar.bz2
d506172ca11071274175d74e9c581c3166432d0179b036470e3b9e8d20eae581  pypy3.9-v7.3.11-linux64.tar.bz2
e9327fb9edaf2ad91935d5b8563ec5ff24193bddb175c1acaaf772c025af1824  pypy3.9-v7.3.12-aarch64.tar.bz2
aa04370d38f451683ccc817d76c2b3e0f471dbb879e0bd618d9affbdc9cd37a4  pypy3.9-v7.3.12-linux32.tar.bz2
84c89b966fab2b58f451a482ee30ca7fec3350435bd0b9614615c61dc6da2390  pypy3.9-v7.3.12-linux64.tar.bz2
26208b5a134d9860a08f74cce60960005758e82dc5f0e3566a48ed863a1f16a1  pypy3.10-v7.3.12-aarch64.tar.bz2
811667825ae58ada4b7c3d8bc1b5055b9f9d6a377e51aedfbe0727966603f60e  pypy3.10-v7.3.12-linux32.tar.bz2
6c577993160b6f5ee8cab73cd1a807affcefafe2f7441c87bd926c10505e8731  pypy3.10-v7.3.12-linux64.tar.bz2

const assert = require('assert');
const fs = require('fs');
const path = require('path');

describe('VS Code settings', () => {
  let settings;

  before(() => {
    const settingsPath = path.join(__dirname, '..', 'settings.json');
    const settingsContent = fs.readFileSync(settingsPath, 'utf8');
    settings = JSON.parse(settingsContent);
  });
});
it('should handle empty string values for the Linux automation profile', () => {
  const linuxProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.strictEqual(typeof linuxProfile, 'object');
  assert.strictEqual(Object.keys(linuxProfile).length, 0);
});it('should override existing Linux automation profile settings', () => {
  const linuxProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.strictEqual(typeof linuxProfile, 'object');
  assert.notStrictEqual(Object.keys(linuxProfile).length, 0);
  assert.strictEqual(typeof linuxProfile.env, 'object');
  assert.strictEqual(Object.keys(linuxProfile.env).length, 0);
});it('should validate the syntax of the Linux automation profile configuration', () => {
  const linuxProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.strictEqual(typeof linuxProfile, 'object');
  assert.ok(Object.keys(linuxProfile).length > 0, 'Linux automation profile should not be empty');
  assert.strictEqual(typeof linuxProfile.env, 'object');
});it('should integrate with other terminal settings without conflicts', () => {
  const linuxProfile = settings['terminal.integrated.automationProfile.linux'];
  const allowedLinkSchemes = settings['terminal.integrated.allowedLinkSchemes'];
  
  assert.strictEqual(typeof linuxProfile, 'object');
  assert.strictEqual(typeof allowedLinkSchemes, 'object');
  assert.ok(Array.isArray(allowedLinkSchemes));
  
  // Check that the Linux profile doesn't override allowedLinkSchemes
  assert.ok(!linuxProfile.hasOwnProperty('allowedLinkSchemes'));
  
  // Verify that allowedLinkSchemes is still intact
  assert.ok(allowedLinkSchemes.includes('file'));
  assert.ok(allowedLinkSchemes.includes('http'));
  assert.ok(allowedLinkSchemes.includes('https'));
});it('should throw an error for invalid Linux automation profile configurations', () => {
  const invalidConfig = {
    'terminal.integrated.automationProfile.linux': 'invalid'
  };

  assert.throws(() => {
    const parsedSettings = JSON.parse(JSON.stringify(invalidConfig));
    const linuxProfile = parsedSettings['terminal.integrated.automationProfile.linux'];
    assert.strictEqual(typeof linuxProfile, 'object');
  }, {
    name: 'AssertionError',
    message: 'The expression evaluated to a falsy value:\n\n  assert.strictEqual(typeof linuxProfile, \'object\')\n'
  });
});it('should support different Linux distributions for automation profiles', () => {
  const linuxProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.strictEqual(typeof linuxProfile, 'object');
  
  // Test for Ubuntu
  const ubuntuConfig = { ...linuxProfile, path: '/bin/bash', args: ['--login'] };
  assert.doesNotThrow(() => {
    settings['terminal.integrated.automationProfile.linux'] = ubuntuConfig;
  });
  
  // Test for CentOS
  const centosConfig = { ...linuxProfile, path: '/usr/bin/bash', args: ['--login'] };
  assert.doesNotThrow(() => {
    settings['terminal.integrated.automationProfile.linux'] = centosConfig;
  });
  
  // Test for Fedora
  const fedoraConfig = { ...linuxProfile, path: '/usr/bin/zsh', args: ['-l'] };
  assert.doesNotThrow(() => {
    settings['terminal.integrated.automationProfile.linux'] = fedoraConfig;
  });
  
  // Verify that the profile can be set back to the original configuration
  assert.doesNotThrow(() => {
    settings['terminal.integrated.automationProfile.linux'] = linuxProfile;
  });
});it('should maintain backward compatibility with older versions of the terminal', () => {
  const linuxProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.strictEqual(typeof linuxProfile, 'object');
  
  // Check if the profile has the basic properties expected in older versions
  assert.ok(linuxProfile.hasOwnProperty('path') || linuxProfile.hasOwnProperty('shell'));
  assert.ok(linuxProfile.hasOwnProperty('args') || linuxProfile.hasOwnProperty('shellArgs'));
  
  // Ensure that new properties don't break older functionality
  const oldVersionKeys = ['path', 'shell', 'args', 'shellArgs', 'env'];
  const profileKeys = Object.keys(linuxProfile);
  const hasOnlyOldOrNewKeys = profileKeys.every(key => oldVersionKeys.includes(key) || key === 'env');
  assert.ok(hasOnlyOldOrNewKeys, 'Profile should only contain old version keys or the new "env" key');
});it('should allow for dynamic updates to the Linux automation profile', () => {
  const originalProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.strictEqual(typeof originalProfile, 'object');

  const updatedProfile = {
    path: '/bin/zsh',
    args: ['-l'],
    env: { CUSTOM_VAR: 'test_value' }
  };

  settings['terminal.integrated.automationProfile.linux'] = updatedProfile;

  const newProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.deepStrictEqual(newProfile, updatedProfile);
  assert.notDeepStrictEqual(newProfile, originalProfile);

  // Restore original profile
  settings['terminal.integrated.automationProfile.linux'] = originalProfile;
});it('should properly escape special characters in the Linux automation profile', () => {
  const linuxProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.strictEqual(typeof linuxProfile, 'object');

  const specialCharsConfig = {
    path: '/bin/bash',
    args: ['-c', 'echo "Hello, World!"'],
    env: {
      SPECIAL_CHARS: '!@#$%^&*()`~[]{}\|;:\'",.<>?'
    }
  };

  settings['terminal.integrated.automationProfile.linux'] = specialCharsConfig;

  const updatedProfile = settings['terminal.integrated.automationProfile.linux'];
  assert.deepStrictEqual(updatedProfile, specialCharsConfig);
  assert.strictEqual(updatedProfile.env.SPECIAL_CHARS, '!@#$%^&*()`~[]{}\|;:\'",.<>?');

  // Restore original profile
  settings['terminal.integrated.automationProfile.linux'] = linuxProfile;
});