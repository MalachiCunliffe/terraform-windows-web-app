resource "azurerm_resource_group" "web_app" {
  name     = "rg-windows-web-app"
  location = "Australia East"
}

resource "azurerm_service_plan" "app_1" {
  name                = "asp-windows-1-qwerty"
  resource_group_name = azurerm_resource_group.web_app.name
  location            = azurerm_resource_group.web_app.location
  sku_name            = "P0v3"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "app_1" {
  name                = "windows-web-app-1-qwerty"
  resource_group_name = azurerm_resource_group.web_app.name
  location            = azurerm_service_plan.app_1.location
  service_plan_id     = azurerm_service_plan.app_1.id

  site_config {

    # Deny all public traffic to the web app main site
    ip_restriction {
      name       = "deny_all"
      ip_address = "0.0.0.0/0"
      action     = "Deny"
      priority   = 1000
    }

    # Deny all public traffic to the web app advanced site
    scm_ip_restriction {
      name       = "deny_all"
      ip_address = "0.0.0.0/0"
      action     = "Deny"
      priority   = 1000
    }

    dynamic "ip_restriction" {
      for_each = var.allowed_ip_addresses

      content {
        ip_address = ip_restriction.value
        action     = "Allow"
        priority   = 400
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = var.allowed_ip_addresses

      content {
        ip_address = scm_ip_restriction.value
        action     = "Allow"
        priority   = 400
      }
    }

  }
}

resource "azurerm_windows_web_app_slot" "staging" {
  name                = "staging"
  service_plan_id     = azurerm_service_plan.app_1.id

  site_config {

    # Deny all public traffic to the web app main site
    ip_restriction {
      name       = "deny_all"
      ip_address = "0.0.0.0/0"
      action     = "Deny"
      priority   = 1000
    }

    # Deny all public traffic to the web app advanced site
    scm_ip_restriction {
      name       = "deny_all"
      ip_address = "0.0.0.0/0"
      action     = "Deny"
      priority   = 1000
    }

    dynamic "ip_restriction" {
      for_each = var.allowed_ip_addresses

      content {
        ip_address = ip_restriction.value
        action     = "Allow"
        priority   = 400
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = var.allowed_ip_addresses

      content {
        ip_address = scm_ip_restriction.value
        action     = "Allow"
        priority   = 400
      }
    }
    
  }
}