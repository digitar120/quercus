#!/bin/bash
gitAddFunction(){
	git add \*$1\*
}

gitCommitFunction(){
	git commit -m "$*"
}

alias gstat="clear && git status"
alias gdiff="clear && git diff"
alias gadd="gitAddFunction"
alias gcom="gitCommitFunction"
alias glog="clear && git reflog"
alias gall="git add *"
alias editBashConf="vim ~/.bashrc && . ~/.bashrc"
