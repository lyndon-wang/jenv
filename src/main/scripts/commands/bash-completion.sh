#!/bin/sh

#
#   Copyright 2012 Marco Vermeulen, Jacky Chan
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# Bash Maven2 completion
#

_jenv_comp()
{
  typeset cur
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $( compgen -W "$1" -- "$cur" ) )
}

_jenv_commands()
{
   _jenv_comp "${JENV_COMMANDS}"
   return 0
}

_jenv_use()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}

_jenv_update()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}

_jenv_list()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}

_jenv_default()
{
  candidates="${JENV_CANDIDATES[@]}"
  _jenv_comp "$candidates"
  return 0
}

_jenv_show()
{
  candidates="${JENV_CANDIDATES[@]}"
  _jenv_comp "$candidates"
  return 0
}

_jenv_which()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
}

_jenv_install()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}

_jenv_execute()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}

_jenv_cd()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}

_jenv_pause()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}


_jenv_uninstall()
{
   candidates="${JENV_CANDIDATES[@]}"
   _jenv_comp "$candidates"
   return 0
}

_jenv_repo()
{
   _jenv_comp "add update"
   return 0
}

_jenv()
{
    typeset prev
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case "${prev}" in
    use)       _jenv_use ;;
    pause)     _jenv_pause ;;
    update)    _jenv_update ;;
    list)      _jenv_list ;;
    ls)        _jenv_list ;;
    install)   _jenv_install ;;
    reinstall) _jenv_install ;;
    execute)   _jenv_execute ;;
    exe)       _jenv_execute ;;
    show)      _jenv_show ;;
    default)   _jenv_default ;;
    which)     _jenv_which ;;
    cd)        _jenv_cd ;;
    uninstall) _jenv_uninstall ;;
    add)       return 0 ;;
    repo)      _jenv_repo ;;
    *)        _jenv_commands ;;
    esac

    # completion for candidate version
    if [[ "$COMP_CWORD" == "3" ]]; then
        command=${COMP_WORDS[COMP_CWORD-2]}
        candidate="${prev}"
        if __jenvtool_utils_array_contains "JENV_CANDIDATES[@]" "${candidate}"; then
           if [[ "$command" == "default" || "$command" == "uninstall" || "$command" == "cd" || "$command" == "use" ]]; then
              versions=$(__jenvtool_candidate_installed_versions "${candidate}")
           else
              versions=$(__jenvtool_candidate_versions "${candidate}")
           fi
           _jenv_comp "${versions}"
           unset versions
        fi
        unset candidate
    fi

     return 0
} &&

complete -F _jenv jenv