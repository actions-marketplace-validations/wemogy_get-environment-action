# ![wemogy](https://wemogyimages.blob.core.windows.net/logos/wemogy-github-tiny.png) Get Environment (GitHub Action)

A GitHub Action to detect on which branch or Pull Request a workflow is running on and derive an environment name, domain-prefix and version-suffix from that.

## Usage

```yaml
- name: Get Environment
  id: get-environment
  uses: wemogy/get-environment-action@2.0.3

- run: echo ${{ steps.get-environment.outputs.env }}
```

## Inputs

| Input                   | Description                                                    | Default     |
| ----------------------- | -------------------------------------------------------------- | ----------- |
| `prod-branch`           | Name of the branch that should result in environment 'prod'    | `"prod"`    |
| `prod-domain-prefix`    | Prefix to use in domains when environment is 'prod'            | `""`        |
| `staging-branch`        | Name of the branch that should result in environment 'staging' | `"staging"` |
| `staging-domain-prefix` | Prefix to use in domains when environment is 'staging'         | `"staging"` |
| `dev`                   | Name of the branch that should result in environment 'dev'     | `"main"`    |
| `dev-domain-prefix`     | Prefix to use in domains when environment is 'dev'             | `"dev"`     |
| `pr-environment`        | Environment that should be used for Pull Request deployments   | `"dev"`     |

## Outputs

| Output           | Description                                                    |
| ---------------- | -------------------------------------------------------------- |
| `env`            | Does the current branch exactly match one of the environments? |
| `exact-match`    | The current branch exactly matches                             |
| `pull-request`   | Is the current branch part of a pull request?                  |
| `branch-name`    | Name of the branch this is running on.                         |
| `domain-prefix`  | Prefix to use in domains                                       |
| `version-suffix` | Suffix to attach to versions                                   |
