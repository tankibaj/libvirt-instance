module "instance" {
  source = "../../"

  user_data = templatefile("${path.module}/user-data.yaml", { HOST_NAME = "k8s", USERNAME = "naim", PASSWORD = "123123" })
}