#!/bin/bash

# This script provides build-feedback to a GitHub pull-request based on the parameters.
# Parameters:
#   1. GITHUB_PR_STATE: pass "success" to pass the build or "failure" to break it.
#   2. GITHUB_OWNER: name of the GitHub user or organization where the repository is hosted
#   3. GITHUB_REPO: name of the GitHub repository
#   4. GITHUB_COMMIT_ID: commit ID for the build
#
# Required environment variable:
#   GITHUB_TOKEN: access token with 'repo:status' permission. If you define it in a pipeline, make sure that it is encrypted
#
# Required environment variables, set up by GoCD:
#   GO_PIPELINE_NAME
#   GO_PIPELINE_COUNTER
#   GO_STAGE_NAME
#   GO_STAGE_COUNTER
#   GO_JOB_NAME

GITHUB_PR_STATE="$1"
GITHUB_OWNER="$2"
GITHUB_REPO="$3"
GITHUB_COMMIT_ID="$4"

echo "PAYLOAD:"
echo '{"state":"'"${GITHUB_PR_STATE}"'", "target_url":"'"https://aww.adnovum.ch/go/tab/build/detail/${GO_PIPELINE_NAME}/${GO_PIPELINE_COUNTER}/${GO_STAGE_NAME}/${GO_STAGE_COUNTER}/${GO_JOB_NAME}"'", "context":"AdNovum GoCD/'"${GO_PIPELINE_NAME}"'"}'
echo "URL:"
echo "https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/statuses/${!GITHUB_COMMIT_ID}"

curl -d '{"state":"'"${GITHUB_PR_STATE}"'", "target_url":"'"https://aww.adnovum.ch/go/tab/build/detail/${GO_PIPELINE_NAME}/${GO_PIPELINE_COUNTER}/${GO_STAGE_NAME}/${GO_STAGE_COUNTER}/${GO_JOB_NAME}"'", "context":"AdNovum GoCD/'"${GO_PIPELINE_NAME}"'"}' -H 'Accept: application/json' -H "Content-Type: application/json" -H "Authorization: Bearer ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/statuses/${!GITHUB_COMMIT_ID}"
