terraform {
  required_providers {
    azurerm = {
        source ="hashicorp/azurerm"
        version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "waRG" {
  name     = "web-app-rg"
  location = "East US2"
  tags = {
    env = "dev"
  }
}

resource "azurerm_storage_account" "faSA" {
  name                     = "devfappsa"
  resource_group_name      = azurerm_resource_group.waRG.name
  location                 = azurerm_resource_group.waRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
  enable_https_traffic_only = true
  allow_nested_items_to_be_public  = false
  shared_access_key_enabled        = true
  tags = {
    env = "dev"
  }
}

resource "azurerm_service_plan" "dev-asp" {
  name                = "dev-app-service-plan"
  resource_group_name = azurerm_resource_group.waRG.name
  location            = azurerm_resource_group.waRG.location
  os_type             = "Linux"
  sku_name            = "S1"
  tags = {
    env = "dev"
  }
}


resource "azurerm_linux_function_app" "dev-fa" {
  name                = "dev-saacessdemo-fa" #has to be unique
  resource_group_name = azurerm_resource_group.waRG.name
  location            = azurerm_resource_group.waRG.location
  service_plan_id     = azurerm_service_plan.dev-asp.id
  storage_account_name = azurerm_storage_account.faSA.name
  storage_uses_managed_identity = true
  https_only                    = true
  builtin_logging_enabled       = false
  functions_extension_version   = "~4"
  identity {
    type = "SystemAssigned"
  }
  site_config {
    http2_enabled       = true
    minimum_tls_version = "1.2"
    application_stack {
        node_version = "16"
    }
    #application_insights_key               = azurerm_application_insights.this.instrumentation_key
    #application_insights_connection_string = azurerm_application_insights.this.connection_string
  }
  tags = {
    env = "dev"
  }
}