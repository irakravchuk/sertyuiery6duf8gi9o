provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.38.0"
}

resource "azurerm_network_interface" "main" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  tags = merge({ "Name" = format("k.kotov-test -> %s", substr ("🤔🤷", 0,1)) }, var.tags)

  ip_configuration {
    name                          = var.name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "web" {
  location = var.region
  name = var.name
  network_interface_ids = [azurerm_network_interface.main.id]
  resource_group_name = var.resource_group
  vm_size = var.instance_type
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    admin_username = var.name
    computer_name = var.name
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = merge({ "Name" = "k.kotov"}, var.tags)
}

resource "azurerm_resource_group" "test" {
  name = "acctest"
  location = "West US"
}

resource "azurerm_image" "test" {
  name = "acctest"
  location = "West US"
  resource_group_name = "${azurerm_resource_group.test.name}"

  os_disk {
    os_type = "Linux"
    os_state = "Generalized"
    #blob_uri = "{blob_uri}"
    size_gb = 30
  }
}

resource "azurerm_resource_group" "testqa" {
  name = "acctestRG"
  location = "West US 2"
}

resource "azurerm_managed_disk" "testqa" {
  name = "acctestmd"
  location = "West US 2"
  resource_group_name = "${azurerm_resource_group.test.name}"
  storage_account_type = "Standard_LRS"
  create_option = "Empty"
  disk_size_gb = "1"

}

# Pay As You Go
resource "azurerm_resource_group" "test234" {
  name     = "api-rg-pro"
  location = "West Europe"
}

resource "azurerm_mysql_server" "test234" {
  name                = "mysql-server-1"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    name = "B_Gen4_2"
    capacity = 2
    tier = "Basic"
    family = "Gen4"
  }

  storage_profile {
    storage_mb = 5120
    backup_retention_days = 7
    geo_redundant_backup = "Disabled"
  }

  administrator_login = "psqladminun"
  administrator_login_password = "H@Sh1CoR3!"
  version = "5.7"
  ssl_enforcement = "Enabled"
}

resource "azurerm_mysql_configuration" "test234" {
  name                = "interactive_timeout"
  resource_group_name = "${azurerm_resource_group.test234.name}"
  server_name         = "${azurerm_mysql_server.test234.name}"
  value               = "600"
}
