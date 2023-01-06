resource "kubernetes_secret" "dockerhub-credentials" {
  metadata {
    name      = "a13a-dockerhub-credentials"
    namespace = var.service_aphorismophilia_namespace
  }

  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = base64decode(var.dockerhub_credentials)
  }

}

resource "kubernetes_deployment" "aphorismophilia" {
  metadata {
    name      = "aphorismophilia"
    namespace = var.service_aphorismophilia_namespace

    annotations = {
      description = "Test annotation."
    }

    labels = {
      k8s-app = "aphorismophilia"
      tier    = "frontend"
    }
  }

  spec {
    progress_deadline_seconds = 120
    replicas                  = 1

    selector {
      match_labels = {
        k8s-app = "aphorismophilia"
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }

    template {

      metadata {
        name      = "aphorismophilia"
        namespace = var.service_aphorismophilia_namespace
        labels = {
          k8s-app = "aphorismophilia"
          tier    = "frontend"
        }

        annotations = {
          description = "Test annotation."
        }
      }

      spec {
        image_pull_secrets {
          name = "a13a-dockerhub-credentials"
        }
        container {
          name              = "aphorismophilia"
          image             = "registry.hub.docker.com/mikeroach/aphorismophilia:${var.service_aphorismophilia_version}"
          image_pull_policy = "Always"

          resources {
            requests = {
              cpu    = "100m"
              memory = "30Mi"
            }
          }

          security_context {
            allow_privilege_escalation = false
            privileged                 = false
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "aphorismophilia-service" {
  metadata {
    name      = "aphorismophilia-service"
    namespace = var.service_aphorismophilia_namespace
    labels = {
      k8s-app = "aphorismophilia"
    }
  }
  spec {
    selector = {
      k8s-app = "aphorismophilia"
    }
    port {
      port        = "8888"
      target_port = "8888"
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "aphorismophilia-ingress" {
  metadata {
    name      = "aphorismophilia-ingress"
    namespace = var.service_aphorismophilia_namespace
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "${var.dns_hostname}.${var.dns_domain}"
      http {
        path {
          backend {
            service {
              name = "aphorismophilia-service"
              port {
                number = 8888
              }
            }
          }
        }
      }
    }
  }
}

