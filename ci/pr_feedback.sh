#!/bin/bash

GITHUB_PR_STATE="$1"
GITHUB_OWNER="$2"
GITHUB_REPO="$3"
GITHUB_COMMIT_ID="$4"

echo "PAYLOAD:"
echo '{"state":"'"${GITHUB_PR_STATE}"'", "target_url":"'"https://aww.adnovum.ch/go/tab/build/detail/${GO_PIPELINE_NAME}/${GO_PIPELINE_COUNTER}/${GO_STAGE_NAME}/${GO_STAGE_COUNTER}/${GO_JOB_NAME}"'", "context":"AdNovum GoCD/'"${GO_PIPELINE_NAME}"'"}'
echo "URL:"
echo "https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/statuses/${!GITHUB_COMMIT_ID}"

curl -d '{"state":"'"${GITHUB_PR_STATE}"'", "target_url":"'"https://aww.adnovum.ch/go/tab/build/detail/${GO_PIPELINE_NAME}/${GO_PIPELINE_COUNTER}/${GO_STAGE_NAME}/${GO_STAGE_COUNTER}/${GO_JOB_NAME}"'", "context":"AdNovum GoCD/'"${GO_PIPELINE_NAME}"'"}' -H 'Accept: application/json' -H "Content-Type: application/json" -H "Authorization: Bearer ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/statuses/${!GITHUB_COMMIT_ID}"
