output "vmss_id" {
  value       = module.lake_loader_service.vmss_id
  description = "ID of the VM scale-set"
}

output "nsg_id" {
  value       = module.lake_loader_service.nsg_id
  description = "ID of the network security group attached to the Lake Loader Server nodes"
}
