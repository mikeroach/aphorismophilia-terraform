variable "dns_hostname" {
  type        = string
  description = "Third-level DNS hostname for this environment (used by dynamic DNS K8s DaemonSet and Nginx ingress controller)"
}

variable "dns_domain" {
  type        = string
  description = "Base (second level) DNS domain name for this environment (used by dynamic DNS K8s DaemonSet and Nginx ingress controller)"
}

variable "dockerhub_credentials" {
  type        = string
  description = "Base64 encoded configuration and credentials for Docker Hub container registry"
}

variable "service_aphorismophilia_namespace" {
  type        = string
  description = "Kubernetes namespace in which to deploy the aphorismophilia service"
}

variable "service_aphorismophilia_version" {
  type        = string
  description = "Service version of aphorismophilia to deploy"
}