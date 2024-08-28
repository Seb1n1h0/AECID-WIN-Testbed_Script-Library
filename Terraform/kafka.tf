####################################################################
#
# CREATE INSTANCE for "kafka"
#
data "openstack_images_image_v2" "kafka-image" {
  name        = var.kafka_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "kafka" {
  name        = "kafka"
  flavor_name = var.kafka_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.kafka-image.id

  network {
    name = "sebahattins-public"
    fixed_ip_v4 = cidrhost(var.net_cidr,33)
  }

}

resource "openstack_networking_floatingip_v2" "kafka" {
  pool = var.floating_pool
}

resource "openstack_compute_floatingip_associate_v2" "kafka" {
  floating_ip = "${openstack_networking_floatingip_v2.kafka.address}"
  instance_id = "${openstack_compute_instance_v2.kafka.id}"
}
