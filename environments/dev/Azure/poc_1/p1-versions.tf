terraform {
     # 指定 Terraform 版本，必须大于等于 1.0.0
    required_version = ">= 1.0.0"
    required_providers {
        azurerm = {
            # 使用 HashiCorp 提供的 Azure 资源管理 (azurerm) 提供程序
            source = "hashicorp/azurerm"
            # 该提供程序版本必须大于等于 2.0
            version = ">=2.0"
        }       
    }
}

# Provider Block 声明 Azure 资源管理器作为提供程序。
provider "azurerm" {
 features {}          
}

