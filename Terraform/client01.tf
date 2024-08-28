####################################################################
#
# CREATE INSTANCE for "client01"
#
data "openstack_images_image_v2" "client01-image" {
  name        = var.client01_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "client01" {
  name        = "ATB-Client01"
  flavor_name = var.client01_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.client01-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,21)
  }

}

resource "openstack_networking_floatingip_v2" "client01" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "client01" {
  floating_ip = "${openstack_networking_floatingip_v2.client01.address}"
  instance_id = "${openstack_compute_instance_v2.client01.id}"
}