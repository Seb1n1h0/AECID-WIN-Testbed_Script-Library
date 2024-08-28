####################################################################
#
# CREATE INSTANCE for "client02"
#
data "openstack_images_image_v2" "client02-image" {
  name        = var.client02_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "client02" {
  name        = "ATB-Client02"
  flavor_name = var.client02_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.client02-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,22)
  }
}

resource "openstack_networking_floatingip_v2" "client02" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "client02" {
  floating_ip = "${openstack_networking_floatingip_v2.client02.address}"
  instance_id = "${openstack_compute_instance_v2.client02.id}"
}