# ![wemogy](https://wemogyimages.blob.core.windows.net/logos/wemogy-github-tiny.png) Get Environment (GitHub Action)

A GitHub Action to detect on which branch or Pull Request a workflow is running on and derive an environment name, domain-prefix and version-suffix from that.

## Usage

```yaml
- uses: actions/checkout@v2

- name: Get Environment
  id: get-environment
  uses: wemogy/get-environment-action@v6.0
  with:
    github-token: ${{ secrets.GITHUB_TOKEN }}

- run: echo ${{ steps.get-environment.outputs.env }}
```

## Inputs

| Input                    | Description                                                          | Default              |
| ------------------------ | -------------------------------------------------------------------- | -------------------- |
| `github-token`           | (**Required**) GitHub Token                                          |                      |
| `prod-branch`            | Name of the branch that should result in environment 'prod'          | `"prod"`             |
| `prod-domain-prefix`     | Prefix to use in domains when environment is 'prod'                  | `""`                 |
| `staging-branch`         | Name of the branch that should result in environment 'staging'       | `"staging"`          |
| `staging-domain-prefix`  | Prefix to use in domains when environment is 'staging'               | `"staging"`          |
| `dev-branch`             | Name of the branch that should result in environment 'dev'           | `"main"`             |
| `dev-domain-prefix`      | Prefix to use in domains when environment is 'dev'                   | `"dev"`              |
| `pr-environment`         | Default environment that should be used for Pull Request deployments | `"dev"`              |
| `deploy-label`           | Label to trigger the default environment                             | `"deploy-to-dev"`    |
| `deploy-to-custom-label` | Label to trigger a deployment into a custom environment              | `"deploy-to-custom"` |

## Outputs

| Output                  | Description                                                                               |
| ----------------------- | ----------------------------------------------------------------------------------------- |
| `branch-name`           | Clean name of the current branch                                                          |
| `exact-match`           | The current branch exactly matches                                                        |
| `is-pull-request`       | Is this running in context of a Pull Request?                                             |
| `is-deployment-needed`  | Is a deployment or undeployment needed?                                                   |
| `is-custom-environment` | Should a custom environment be used for the deployment?                                   |
| `env`                   | Does the current branch exactly match one of the environments?                            |
| `domain-prefix`         | Prefix to use in domains                                                                  |
| `slug`                  | Environment slug to attach as suffix to versions and resources like Kubernetes namespaces |
