variable env {
    type = string
    description = "Environment resources deployed"
    validation {
        condition = var.env != "" && lower(var.env) == var.env
        error_message = "Environment can't be empty and in small case"
    }
}

variable location {
  type        = string
  default     = "East US2"
  description = "Region resources needs to be deployed"
}

variable resourceGroupName {
  type        = string
  description = "Name of the resource group"
}

variable storageAccountName {
    type = string
    description = "Name of the storage account"
    validation {
        condition = (length(var.storageAccountName) < 20) # we are adding sa{env} as suffix in main file
        error_message = "Storage account should be less than 20 characters"
    }
}

variable storageAccountTier {
    type = string
    default = "Standard"
    description = "Tier of the storage account"
}

variable appServicePlanName {
  type        = string
  description = "description"
}

variable functionAppName {
  type        = string
  description = "description"
}