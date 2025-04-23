resource "helm_release" "shikshaapp" {
  name              = "springbootmicroservices"
  chart             = "${path.module}/spring-boot-microservices"
  values = {
    domain_name = var.domain_name
    certificate_arn = var.certificate_arn
    region = var.region
  }
  
 
}