#资源组是 Azure 资源的基本管理单元，所有资源都必须属于某个资源组。
#里面的属性可以被后续资源所引用. 引用的方式参考: azurerm_resource_group.myrg.name 和 azurerm_resource_group.myrg.location
resource "azurerm_resource_group" "myrg" {
    # 资源组的名称
    name = "myrg-1" 
    # 资源组所在的Azure区域
    location = "East US"
}