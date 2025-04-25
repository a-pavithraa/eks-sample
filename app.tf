resource "helm_release" "shikshaapp" {
  name              = "springbootmicroservices"
  chart             = "${path.module}/spring-boot-microservices"
  set {
    name  = "domainName"
    value = var.domain_name
  }
  set {
    name  = "certificateArn"
    value = var.certificate_arn
  }
  set {
    name  = "region"
    value = var.region
  }
  set {
    name  = "email"
    value = var.default_email
  }
}