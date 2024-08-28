####################################################################
#
# CREATE INSTANCE for "webserver"
#
data "openstack_images_image_v2" "webserver-image" {
  name        = var.webserver_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "webserver" {
  name        = "ATB-Webserver"
  flavor_name = var.webserver_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.webserver-image.id

  network {
    name = "sebahattins-public"
    # Below IP Adr.
    fixed_ip_v4 = cidrhost(var.net_cidr,171)
  }
}

resource "openstack_networking_floatingip_v2" "webserver" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "webserver" {
  floating_ip = "${openstack_networking_floatingip_v2.webserver.address}"
  instance_id = "${openstack_compute_instance_v2.webserver.id}"
}