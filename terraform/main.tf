/* Example for the following section on a Windows machine:
   host   = "https://192.168.99.100:8443"
   client_certificate = file("C:\\minikubepath\\client.crt")
   client_key = file("C:\\minikubepath\\client.key")
   cluster_ca_certificate = file("C:\\minikubepath\\ca.crt")
*/

provider "kubernetes" {
  host   = "https://XXX.XXX.XXX.XXX:8443"  // Use the command kubectl config view and put the server value here 
  client_certificate = file("XXXX\\client.crt")  // Use the command kubectl config view and put the client-certificate value here
  client_key = file("XXXX\\client.key")  // Use the command kubectl config view and put the client-key value here
  cluster_ca_certificate = file("XXXX\\ca.crt")  // Use the command kubectl config view and put the certificate-authority value here
}

resource "kubernetes_namespace" "minikube-namespace" {
  metadata {
        name = "treeapp-namespace"
  }
}

resource "kubernetes_deployment" "treeassignment-dep" {
  metadata {
    name      = "treeassignment-dep"
    namespace = kubernetes_namespace.minikube-namespace.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "treeassignment-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "treeassignment-app"
        }
      }
      spec {
        container {
          image = "treeassignment-app"
          name  = "treeassignment-app"
          image_pull_policy = "Never"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
  wait_for_rollout = false
}

resource "kubernetes_service" "treeassignment-svc" {
  metadata {
    name      = "treeassignment-svc"
    namespace = kubernetes_namespace.minikube-namespace.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.treeassignment-dep.spec.0.template.0.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8000
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress" "treeassignment-ing" {
  metadata {
    name = "treeassignment-ing"
    namespace = kubernetes_namespace.minikube-namespace.metadata.0.name
    annotations = { "ingress.kubernetes.io/rewrite-target" = "/tree"
    }
  }
  spec {
    backend {
      service_name = "treeassignment-svc"
      service_port = 8000
    }
    rule {
      host = "local.ecosia.org"
      http {
        path {
          backend {
            service_name = "treeassignment-svc"
            service_port = 8000
          }
          path = "/"
        }
      }
    }
  }
  wait_for_load_balancer = false
}
