####################################################################
#
# CREATE INSTANCE for "fileserver"
#
data "openstack_images_image_v2" "fileserver-image" {
  name        = var.fileserver_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "fileserver" {
  name        = "ATB-Fileserver01"
  flavor_name = var.fileserver_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.fileserver-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,31)
  }

}

resource "openstack_networking_floatingip_v2" "fileserver" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "fileserver" {
  floating_ip = "${openstack_networking_floatingip_v2.fileserver.address}"
  instance_id = "${openstack_compute_instance_v2.fileserver.id}"
}