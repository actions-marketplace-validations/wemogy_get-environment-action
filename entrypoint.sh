#!/bin/bash

# Ensure that the scrip is running with these environment variables:
DEPLOY_LABEL=$DEPLOY_LABEL
DEPLOY_CUSTOM_LABEL=$DEPLOY_CUSTOM_LABEL
GITHUB_TOKEN=$GITHUB_TOKEN
DEV_BRANCH=$DEV_BRANCH
DEV_DOMAIN_PREFIX=$DEV_DOMAIN_PREFIX
STAGING_BRANCH=$STAGING_BRANCH
STAGING_DOMAIN_PREFIX=$STAGING_DOMAIN_PREFIX
PROD_BRANCH=$PROD_BRANCH
PROD_DOMAIN_PREFIX=$PROD_DOMAIN_PREFIX
PR_ENVIRONMENT=$PR_ENVIRONMENT

GITHUB_EVENT_PULL_REQUEST_NUMBER=$GITHUB_EVENT_PULL_REQUEST_NUMBER
GITHUB_EVENT_LABEL_NAME=$GITHUB_EVENT_LABEL_NAME

isCustomEnvironment=false

# Find current branch
# When executing this in context of a pull request, the GITHUB_HEAD_REF points to the source branch.
# When executing this outside of a pull request, the GITHUB_HEAD_REF is empty and GITHUB_REF points to the current branch.
if [[ "${GITHUB_HEAD_REF}" != "" ]]; then
  branchName=$(echo ${GITHUB_HEAD_REF})
  isPullRequest=true
else
  branchName=$(echo ${GITHUB_REF#refs/heads/})
  isPullRequest=false
fi

if [[ "$isPullRequest" == "true" ]]; then
  # Get labels of the pull request
  labels=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${GITHUB_EVENT_PULL_REQUEST_NUMBER}/labels")
  echo $labels
  # Check if labels contain the deploy-to-dev label
  if [[ "$labels" == *"$DEPLOY_LABEL"* || "${GITHUB_EVENT_LABEL_NAME}" == "$DEPLOY_LABEL" ]]; then
    isDeploymentNeeded=true
  fi
  # Check if labels contain the deploy-to-custom label
  if [[ "$labels" == *"$DEPLOY_CUSTOM_LABEL"* || "${GITHUB_EVENT_LABEL_NAME}" == "$DEPLOY_CUSTOM_LABEL" ]]; then
    isDeploymentNeeded=true
    isCustomEnvironment=true
  fi
else
  isDeploymentNeeded=true
fi

# Compare current branch with environments
if [[ "$currentBranch" == "$DEV_BRANCH" ]]; then
  environment=dev
  exactMatch=true
  domainPrefix=$DEV_DOMAIN_PREFIX
  slug=dev
elif [[ "$currentBranch" == "$STAGING_BRANCH" ]]; then
  environment=staging
  exactMatch=true
  domainPrefix=$STAGING_DOMAIN_PREFIX
  slug=staging
elif [[ "$currentBranch" == "$PROD_BRANCH" ]]; then
  environment=prod
  exactMatch=true
  domainPrefix=$PROD_DOMAIN_PREFIX
  slug=prod
elif [[ "$isPullRequest" == "true" ]]; then
  if [[ "$IS_CUSTOM_ENVIRONMENT" == "true" ]]; then
    environment=pr${GITHUB_EVENT_PULL_REQUEST_NUMBER}
  else
    environment=$PR_ENVIRONMENT
  fi

  exactMatch=false
  domainPrefix=${GITHUB_EVENT_PULL_REQUEST_NUMBER}.pr
  slug=pr${GITHUB_EVENT_PULL_REQUEST_NUMBER}
else
  echo "::warning title=Could not find environment::No matching branch and no Pull Request found."
fi

echo "Current branch: $branchName"
echo "::set-output name=branch-name::$branchName"
echo "Pull Request: $isPullRequest"
echo "::set-output name=is-pull-request::$isPullRequest"
echo "Environment: $environment"
echo "::set-output name=env::$environment"
echo "Exact match: $exactMatch"
echo "::set-output name=exact-match::$exactMatch"
echo "Domain prefix: $domainPrefix"
echo "::set-output name=domain-prefix::$domainPrefix"
echo "Slug: $slug"
echo "::set-output name=slug::$slug"
echo "Deployment needed: $isDeploymentNeeded"
echo "::set-output name=is-deployment-needed::$isDeploymentNeeded"
echo "Custom env: $isCustomEnvironment"
echo "::set-output name=is-custom-environment::$isCustomEnvironment"
