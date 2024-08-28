####################################################################
#
# CREATE INSTANCE for "ghosts"
#
data "openstack_images_image_v2" "ghosts-image" {
  name        = var.ghosts_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "ghosts" {
  name        = "GHOSTS-Server"
  flavor_name = var.ghosts_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.ghosts-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,32)
  }

}

resource "openstack_networking_floatingip_v2" "ghosts" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "ghosts" {
  floating_ip = "${openstack_networking_floatingip_v2.ghosts.address}"
  instance_id = "${openstack_compute_instance_v2.ghosts.id}"
}