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