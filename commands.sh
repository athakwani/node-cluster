#!/bin/bash

function ls-rules()
{
    IFS=$'\r\n'

    local max_url_len=0
    local max_priority_len=0
    local max_labels_len=0
    local max_args_len=0

    for instance in `cat $RULES | jq -c '.[] | .'`
    do
        local url="$(echo "$instance" | jq '.url')"
        local url_len=${#url}
        if [ ${url_len} -gt ${max_url_len} ]
        then
          max_url_len=${url_len}
        fi

        local priority="$(echo "$instance" | jq '.priority')"
        local priority_len=${#priority}
        if [ ${priority_len} -gt ${max_priority_len} ]
        then
          max_priority_len=${priority_len}
        fi

        local labels="$(echo "$instance" | jq -c '.labels')"
        local labels_len=${#labels}
        if [ ${labels_len} -gt ${max_labels_len} ]
        then
          max_labels_len=${labels_len}
        fi

        local args="$(echo "$instance" | jq '.args')"
        local args_len=${#args}
        if [ ${args_len} -gt ${max_args_len} ]
        then
          max_args_len=${args_len}
        fi

    done

    printf "%-*s\t%-*s\t%-*s\t%-*s\n" \
         "${max_url_len}" "GITURL" \
         "${max_priority_len}" "PRIORITY" \
         "${max_labels_len}" "LABELS" \
         "${max_args_len}" "ARGUMENTS" 

    for instance in `cat $RULES | jq -c '.[] | .'`
    do
        local url="$(echo "$instance" | jq '.url')"
        local priority="$(echo "$instance" | jq '.priority')"
        local labels="$(echo "$instance" | jq -c '.labels')"
        local args="$(echo "$instance" | jq '.args')"


        printf "%-*s\t%-*s\t\t%-*s\t%-*s\t\n"        \
               "${max_url_len}" "${url}"           \
               "${max_priority_len}" "${priority}" \
               "${max_labels_len}" "${labels}"     \
               "${max_args_len}" "${args}" 

    done

}