# 定义了一个 Azure 虚拟网络（VNet）
resource "azurerm_virtual_network" "myvnet" {
    #VPC名称
    name = "myvnet-1"
    #VPC的IP address range
    address_space = ["10.0.0.0/16"] 
    #继承(引用)资源组的位置
    location = azurerm_resource_group.myrg.location
    #继承(引用)资源组的名称
    resource_group_name = azurerm_resource_group.myrg.name
}

# Resource: subnet
resource "azurerm_subnet" "mysubnet" {
    name                 = "mysubnet-1"
    # Attach Resource Group and VPN
    resource_group_name  = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes     = ["10.0.2.0/24"]
}

# Resource: Public IP Address
resource "azurerm_public_ip" "mypublicip" {
    # Attach Resource Group and Location
    name                = "mypublicip-1"
    resource_group_name = azurerm_resource_group.myrg.name
    location            = azurerm_resource_group.myrg.location
    allocation_method   = "Static"
    tags = {
    environment = "Dev"
    }
}

