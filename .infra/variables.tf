// tenant_id
variable "tenant_id" {
  type        = string
  description = "Id of your azure tenant"
}

variable "client_id" {
  type        = string
  description = "Client ID of the Service Principal"
}

// client_secret
variable "client_secret" {
  type        = string
  description = "value of the client_secret"
}

// subscription_id
variable "subscription_id" {
  type        = string
  description = "Subscription ID of your Azure Subscription"
}

// allowed_ip_addresses
variable "allowed_ip_addresses" {
  type        = list(string)
  description = "List of allowed IP addresses"
  default     = [""]
}