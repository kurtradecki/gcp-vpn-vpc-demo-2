# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

terraform {
  required_version = ">= 1.4.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.4.0, < 6.0.0"
    }
  }
}

locals {
  project2_id = coalesce(var.project2_id, var.project1_id)
  region2     = coalesce(var.region2, var.region1)
}

data "google_compute_network" "vpc1" {
  project = var.project1_id
  name    = var.vpc1_name
}

data "google_compute_network" "vpc2" {
  project = local.project2_id
  name    = var.vpc2_name
}

# HA VPN Gateway, Cloud Router, and Tunnels for VPC 1 -> VPC 2
module "vpn-1" {
  source     = "github.com/terraform-google-modules/cloud-foundation-fabric//modules/net-vpn-ha?ref=v28.0.0"
  project_id = var.project1_id
  region     = var.region1
  network    = data.google_compute_network.vpc1.self_link
  name       = "vpngw-${data.google_compute_network.vpc1.name}-${data.google_compute_network.vpc2.name}"

  peer_gateways = {
    default = { gcp = module.vpn-2.self_link }
  }

  router_config = {
    asn              = 64514
    name             = "cldrtr-${data.google_compute_network.vpc1.name}-${data.google_compute_network.vpc2.name}-${var.region1}-internal"
    custom_advertise = var.vpc1_cldrouter_custom
  }

  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.1"
        asn     = 64513
      }
      bgp_session_range     = "169.254.1.2/30"
      vpn_gateway_interface = 0
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.1"
        asn     = 64513
      }
      bgp_session_range     = "169.254.2.2/30"
      vpn_gateway_interface = 1
    }
  }
}

# HA VPN Gateway, Cloud Router, and Tunnels for VPC 2 -> VPC 1
module "vpn-2" {
  source     = "github.com/terraform-google-modules/cloud-foundation-fabric//modules/net-vpn-ha?ref=v28.0.0"
  project_id = local.project2_id
  region     = local.region2
  network    = data.google_compute_network.vpc2.self_link
  name       = "vpngw-${data.google_compute_network.vpc2.name}-${data.google_compute_network.vpc1.name}"

  peer_gateways = {
    default = { gcp = module.vpn-1.self_link }
  }

  router_config = {
    asn              = 64513
    name             = "cldrtr-${data.google_compute_network.vpc2.name}-${data.google_compute_network.vpc1.name}-${local.region2}-internal"
    custom_advertise = var.vpc2_cldrouter_custom
  }

  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.2"
        asn     = 64514
      }
      bgp_session_range     = "169.254.1.1/30"
      shared_secret         = module.vpn-1.random_secret
      vpn_gateway_interface = 0
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.2"
        asn     = 64514
      }
      bgp_session_range     = "169.254.2.1/30"
      shared_secret         = module.vpn-1.random_secret
      vpn_gateway_interface = 1
    }
  }
}
