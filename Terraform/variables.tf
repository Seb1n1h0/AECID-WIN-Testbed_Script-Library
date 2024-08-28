variable "primarydc_image" {
  type        = string
  description = "image of the primarydc host"
  default = "WinServer19"
}

variable "primarydc_flavor" {
  type        = string
  description = "flavor of the primarydc host"
  default     = "m1.large"
}

variable "secondarydc_image" {
  type        = string
  description = "image of the secondarydc host"
  default = "WinServer22"
}

variable "secondarydc_flavor" {
  type        = string
  description = "flavor of the secondarydc host"
  default     = "m1.large"
}

variable "webserver_image" {
  type        = string
  description = "image of the webserver host"
  default     = "WinServer19"
}

variable "webserver_flavor" {
  type        = string
  description = "flavor of the webserver host"
  default     = "m1.medium"
}

variable "wineventcollector_image" {
  type        = string
  description = "image of the wineventcollector host"
  default     = "WinServer19"
}

variable "wineventcollector_flavor" {
  type        = string
  description = "flavor of the wineventcollector host"
  default     = "m1.large"
}

variable "fileserver_image" {
  type        = string
  description = "image of the fileserver host"
  default     = "WinServer22"
}

variable "fileserver_flavor" {
  type        = string
  description = "flavor of the fileserver host"
  default     = "m1.medium"
}

variable "client01_image" {
  type        = string
  description = "image of the client01 host"
  default = "Win10"
}

variable "client01_flavor" {
  type        = string
  description = "flavor of the client01 host"
  default     = "m1.medium"
}

variable "client02_image" {
  type        = string
  description = "image of the client02 host"
  default     = "win11Test"
}

variable "client02_flavor" {
  type        = string
  description = "flavor of the client02 host"
  default     = "m1.medium"
}

variable "kafka_image" {
  type        = string
  description = "image of the kafka host"
}

variable "kafka_flavor" {
  type        = string
  description = "flavor of the kafka host"
  default     = "m1.small"
}

variable "ghosts_image" {
  type        = string
  description = "image of the ghosts host"
}

variable "ghosts_flavor" {
  type        = string
  description = "flavor of the ghosts host"
  default     = "m1.small"
}

variable "sshkey" {
  type        = string
  description = "sshkey for linux hosts"
}

variable "net_cidr" {
  type        = string
  description = "CIDR of the local subnet"
  default     = "192.168.10.0/24"
}

variable "floating_pool" {
  type        = string
  description = "Pool for floating ip-addresses"
}
