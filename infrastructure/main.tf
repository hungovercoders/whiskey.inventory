resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.region
  tags     = local.tags
}

data "azurerm_container_app_environment" "app_environment" {
  name                = local.container_environment_name
  resource_group_name = local.container_environment_resource_group_name
}

resource "azurerm_container_app" "api" {
  name                         = local.container_app_api_name
  container_app_environment_id = data.azurerm_container_app_environment.app_environment.id
  resource_group_name          = azurerm_resource_group.rg.name
  tags                         = local.tags
  revision_mode                = "Single"
  template {
    container {
      name   = local.container_api_name
      image  = local.container_api_image_name
      cpu    = 0.25
      memory = "0.5Gi"
      env {
        name  = "APP_ENVIRONMENT"
        value = var.environment
      }
      env {
        name  = "CORS_ORIGINS"
        value = "https://${local.custom_domain}"
      }
    }
  }
  ingress {
    external_enabled = true
    target_port      = var.port_api
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azurerm_container_app" "web" {
  name                         = local.container_app_web_name
  container_app_environment_id = data.azurerm_container_app_environment.app_environment.id
  resource_group_name          = azurerm_resource_group.rg.name
  tags                         = local.tags
  revision_mode                = "Single"
  template {
    container {
      name   = local.container_web_name
      image  = local.container_web_image_name
      cpu    = 0.25
      memory = "0.5Gi"
      env {
        name  = "API_URL"
        value = "https://${azurerm_container_app.api.ingress[0].fqdn}/api"
      }
    }
  }
  ingress {
    external_enabled = true
    target_port      = var.port_web
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
  lifecycle {
    ignore_changes = [
      ingress[0].custom_domain // Ignore changes to the custom domain until terraform can manage it - https://github.com/hashicorp/terraform-provider-azurerm/issues/21866
    ]
  }
}

resource "azurerm_cosmosdb_account" "db" {
  name                              = local.cosmos_name
  location                          = var.region
  resource_group_name               = azurerm_resource_group.rg.name
  offer_type                        = "Standard"
  kind                              = "GlobalDocumentDB"
  tags                              = local.tags
  is_virtual_network_filter_enabled = false
  geo_location {
    location          = var.region
    failover_priority = 0
    zone_redundant    = true
  }

  consistency_policy {
    consistency_level       = "Eventual"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  capabilities {
    name = "EnableServerless"
  }

  backup {
    type = "Continuous"
    tier = "Continuous7Days"
  }
}

output "azurerm_container_api_url" {
  value = azurerm_container_app.api.latest_revision_fqdn
}

output "azurerm_container_api_revision_name" {
  value = azurerm_container_app.api.latest_revision_name
}

output "azurerm_container_web_url" {
  value = azurerm_container_app.web.latest_revision_fqdn
}

output "azurerm_container_web_revision_name" {
  value = azurerm_container_app.web.latest_revision_name
}
