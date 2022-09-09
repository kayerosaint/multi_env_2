

resource "docker_image" "multi_env" {
  name = var.image
}

resource "docker_container" "multi_env" {
  image = docker_image.multi_env.latest
  name  = "multi_env"
  env = [
    "PORT=4000",
  ]

  ports {
    internal = 4000
    external = 80
  }
  restart = "unless-stopped"

}
