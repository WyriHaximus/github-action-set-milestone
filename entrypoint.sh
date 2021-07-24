#!/bin/bash

set -eo pipefail

if [ $(echo ${GITHUB_REPOSITORY} | wc -c) -eq 1 ] ; then
  echo -e "\033[31mRepository cannot be empty\033[0m"
  exit 1
fi

if [ $(echo ${INPUT_ISSUE_NUMBER} | wc -c) -eq 1 ] ; then
  echo -e "\033[31mIssue number cannot be empty\033[0m"
  exit 1
fi

if [ $(echo ${INPUT_MILESTONE_NUMBER} | wc -c) -eq 1 ] ; then
  echo -e "\033[31mMilestone number cannot be empty\033[0m"
  exit 1
fi

printf "\u001b[30;40m♫♪.ılılıll|̲̅̅●̲̅̅|̲̅̅=̲̅̅|̲̅̅●̲̅̅|%s|̲̅̅●̲̅̅|̲̅̅=̲̅̅|̲̅̅●̲̅̅|llılılı.♫♪\u001b[0m\n" "milestone"
printf "\u001b[30;40m»-(¯`·.·´¯)->%s<-(¯`·.·´¯)-«\u001b[0m\n" ${INPUT_ISSUE_NUMBER}

jq -nc \
--arg milestone ${INPUT_MILESTONE_NUMBER} \
'{
  "milestone": $milestone
}' \
> /workdir/payload.json

curl --request PATCH \
  --url https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${INPUT_ISSUE_NUMBER} \
  --header "Authorization: Bearer ${GITHUB_TOKEN}" \
  --header 'Content-Type: application/json' \
  --data "$(cat /workdir/payload.json)"
