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

| Input     | Description                                                  |
| --------- | ------------------------------------------------------------ |
| `staging` | Name of the staging branch (Default: staging)                |
| `prod`    | Name of the production branch (Default: prod)                |
| `dev`     | Name of the development branch (Default: dev)                |
| `default` | Default environment, if no branch match found (Default: dev) |

## Outputs

| Output | Description                              |
| ------ | ---------------------------------------- |
| `env`  | The Environment this branch is targeting |
