module "gather_output" {
    source 						= "git::https://github.com/IBM-CAMHub-Open/template_icp_modules.git?ref=2.3//public_cloud_output"
	cluster_CA_domain 			= "${var.user_provided_cert_dns != "" ? var.user_provided_cert_dns : aws_lb.icp-console.dns_name}"
	icp_master 					= "${aws_network_interface.mastervip.*.private_ip}"
	ssh_user 					= "icpdeploy"
	ssh_key_base64 				= "${base64encode(tls_private_key.installkey.private_key_pem)}"
	bastion_host 				= "${aws_instance.bastion.0.public_ip}"
	bastion_user    			= "ubuntu"
	bastion_private_key_base64 	= "${var.privatekey}"
}

output "registry_ca_cert"{
  value = "${module.gather_output.registry_ca_cert}"
} 

output "icp_install_dir"{
  value = "${module.gather_output.icp_install_dir}"
} 

output "registry_config_do_name"{
	value = "${var.instance_name}${random_id.clusterid.hex}RegistryConfig"
}