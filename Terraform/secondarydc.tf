####################################################################
#
# CREATE INSTANCE for "secondarydc"
#
data "openstack_images_image_v2" "secondarydc-image" {
  name        = var.secondarydc_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "secondarydc" {
  name        = "ATB-DC02"
  flavor_name = var.secondarydc_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.secondarydc-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,42)
  }
}

resource "openstack_networking_floatingip_v2" "secondarydc" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "secondarydc" {
  floating_ip = "${openstack_networking_floatingip_v2.secondarydc.address}"
  instance_id = "${openstack_compute_instance_v2.secondarydc.id}"
}