####################################################################
#
# CREATE INSTANCE for "wineventcollector"
#
data "openstack_images_image_v2" "wineventcollector-image" {
  name        = var.wineventcollector_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "wineventcollector" {
  name        = "ATB-wineventcollector"
  flavor_name = var.wineventcollector_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.wineventcollector-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,43)
  }
}

resource "openstack_networking_floatingip_v2" "wineventcollector" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "wineventcollector" {
  floating_ip = "${openstack_networking_floatingip_v2.wineventcollector.address}"
  instance_id = "${openstack_compute_instance_v2.wineventcollector.id}"
}