---
layout: post
title: A New Bash Prompt
location: New York, NY
h1: An overdue overhaul
---

## TODO: FIXME

For months, my `$HOME/.bashrc` had a big fat FIXME above the prompt. Like most shell users, I'm a relentless tweaker and I just couldn't get it to a place I liked. A [recent blog post](http://briancarper.net/blog/570/git-info-in-your-zsh-prompt) about Git information in a ZSH prompt gave me some new ideas. Here's the code I came up with as well as a screenshot.

        ## The prompt below gets ideas from the following:
        # http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
        # http://github.com/adamv/dotfiles/blob/master/bashrc
        # http://wiki.archlinux.org/index.php/Color_Bash_Prompt
        txtred='\[\e[0;31m\]' # Red
        txtwht='\[\e[0;37m\]' # White
        bldred='\[\e[1;31m\]' # Red
        bldgrn='\[\e[1;32m\]' # Green
        bldylw='\[\e[1;33m\]' # Yellow
        bldwht='\[\e[1;37m\]' # White
        end='\[\e[0m\]'    # Text Reset

        function parse_git {
            branch=$(__git_ps1 "%s")
            if [[ -z $branch ]]; then
                return
            fi

            local forward="⟰"
            local behind="⟱"
            local dot="•"

            remote_pattern_ahead="# Your branch is ahead of"
            remote_pattern_behind="# Your branch is behind"
            remote_pattern_diverge="# Your branch and (.*) have diverged"

            status="$(git status 2>/dev/null)"

            state=""
            if [[ $status =~ "working directory clean" ]]; then
                state=${bldgrn}${dot}${end}
            else
                if [[ $status =~ "Untracked files" ]]; then
                    state=${bldred}${dot}${end}
                fi
                if [[ $status =~ "Changed but not updated" ]]; then
                    state=${state}${bldylw}${dot}${end}
                fi
                if [[ $status =~ "Changes to be committed" ]]; then
                    state=${state}${bldylw}${dot}${end}
                fi
            fi

            direction=""
            if [[ $status =~ $remote_pattern_ahead ]]; then
                direction=${bldgrn}${forward}${end}
            elif [[ $status =~ $remote_pattern_behind ]]; then
                direction=${bldred}${behind}${end}
            elif [[ $status =~ $remote_pattern_diverge ]]; then
                direction=${bldred}${forward}${end}${bldgrn}${behind}${end}
            fi

            branch=${txtwht}${branch}${end}
            git_bit="${bldred}[${end}${branch}${state}\
        ${git_bit}${direction}${bldred}]${end}"

            printf "%s" "$git_bit"
        }

        function set_titlebar {
            case $TERM in
                *xterm*|ansi|rxvt)
                    printf "\033]0;%s\007" "$*"
                    ;;
            esac
        }

        function set_prompt {
            git="$(parse_git)"

            PS1="${txtred}\u${end} ${txtred}\W${end}"
            if [[ -n "$git" ]]; then
                PS1="$PS1 $git ${bldcyn}❯❯${end} "
            else
                PS1="$PS1 ${bldcyn}❯❯${end} "
            fi
            export PS1

            set_titlebar "$USER@${HOSTNAME%%.*} $PWD"
        }

        export PROMPT_COMMAND=set_prompt

And a screenshot:

![The new PS1](/images/ps1.jpg "Shiny, right?")


## Colors

The theme itself is a lightly modified version of Todd Werth's [IR_Black](http://blog.infinitered.com/entries/show/6), and the traffic lights colors idea I took from Brian Carper's [ZSH version](http://briancarper.net/blog/570/git-info-in-your-zsh-prompt). I like the result a lot, but I have a hard time seeing the difference between the green dot (a clean repo) and the yellow (items staged but not yet committed). This may be because the colors are so close, and it may be because I'm red-green color blind. In any case, I'm leaving it as-is for the moment, but that's the next thing I'll obsess over.

## Share and share alike

The code for both the prompt and the adjusted theme are in [my dotfiles repo on Github](http://github.com/telemachus/dotfiles). If you do something better with it, drop me an email at telemachus /at/ arpinum /dot/ org.
