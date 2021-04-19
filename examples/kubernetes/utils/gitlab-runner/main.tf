module "gitlab_runner" {
  # source = "github.com/makezbs/toolbox/modules/gitlab-runner"
  source = "../../../../modules/gitlab-runner"

  name      = "gitlab-runner"
  namespace = "utils"

  set_sensitive = {
    "runnerRegistrationToken" = "type-token-here",
  }
}
