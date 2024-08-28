####################################################################
#
# CREATE INSTANCE for "primarydc"
#
data "openstack_images_image_v2" "primarydc-image" {
  name        = var.primarydc_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "primarydc" {
  name        = "ATB-DC01"
  flavor_name = var.primarydc_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.primarydc-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,41)
  }
}

resource "openstack_networking_floatingip_v2" "primarydc" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "primarydc" {
  floating_ip = "${openstack_networking_floatingip_v2.primarydc.address}"
  instance_id = "${openstack_compute_instance_v2.primarydc.id}"
}