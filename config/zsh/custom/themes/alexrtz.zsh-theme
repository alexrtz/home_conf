if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="cyan"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

source ~/.config/zsh/oh-my-zsh/plugins/gitfast/git-prompt.sh

my_git_prompt() {
    __git_ps1 "${ZSH_THEME_GIT_PROMPT_PREFIX//\%/%%}%s${ZSH_THEME_GIT_PROMPT_SUFFIX//\%/%%}"
}

PROMPT='%{${fg_bold[yellow]}%}alex%{$reset_color%}@${${(%):-%m}} %{${fg_bold[cyan]}%}%3~ $(my_git_prompt)%{${fg_bold[$CARETCOLOR]}%}$%{${reset_color}%} '

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$reset_color%}"
