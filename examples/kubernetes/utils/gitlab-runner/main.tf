module "gitlab_runner" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/gitlab-runner?ref=v0.1.0"

  name      = "gitlab-runner"
  namespace = "utils"

  set_sensitive = {
    "runnerRegistrationToken" = "type-token-here",
  }
}
