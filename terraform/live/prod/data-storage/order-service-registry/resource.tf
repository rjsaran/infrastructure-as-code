module "order_service" {
    source      = "../../../../modules/data-storage/docker-registry"

    name        = "order-service-prod"
    environment = "prod"
}