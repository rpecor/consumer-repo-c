data "terraform_remote_state" "repo_b" {
  backend = "local"

  config = {
    path = "${path.module}/../consumer-repo-b/terraform.tfstate"
  }
}

resource "null_resource" "downstream_app" {
  triggers = {
    vpc_id     = data.terraform_remote_state.repo_b.outputs.vpc_id
    subnet_ids = join(",", data.terraform_remote_state.repo_b.outputs.subnet_ids)
  }
}
