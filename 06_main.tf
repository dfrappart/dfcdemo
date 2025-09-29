#######################################################
# Base resources

resource "azurerm_resource_group" "RGShared" {
  for_each = var.RgConfig

  location   = each.value.RgLocation
  managed_by = null
  name       = each.key
  #tags       = each.value.RgTags
}

