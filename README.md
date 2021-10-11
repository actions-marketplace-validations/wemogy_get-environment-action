# ![wemogy](https://wemogyimages.blob.core.windows.net/logos/wemogy-github-tiny.png) Get Environment (GitHub Action)

A GitHub Action to detect on which branch a workflow is running on and derive an environment name from that.

## Usage

```yaml
- name: Get Environment
  id: get-environment
  uses: wemogy/get-environment

- run: echo ${{ steps.get-environment.outputs.env }}
```

## Inputs

| Input     | Description                                                                       |
| --------- | --------------------------------------------------------------------------------- |
| `staging` | Name of the branch that should result in environment 'staging' (Default: staging) |
| `prod`    | Name of the branch that should result in environment 'prod' (Default: prod)       |
| `dev`     | Name of the branch that should result in environment 'dev' (Default: dev)         |
| `default` | Default environment, if no branch match found (Default: dev)                      |

## Outputs

| Output         | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| `env`          | Does the current branch exactly match one of the environments? |
| `exact-match`  | The current branch exactly matches                             |
| `pull-request` | Is the current branch part of a pull request?                  |
