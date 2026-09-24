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

variable "project1_id" {
  description = "The GCP project ID hosting VPC 1."
  type        = string
}

variable "project2_id" {
  description = "The GCP project ID hosting VPC 2. If omitted or null, defaults to project1_id."
  type        = string
  default     = null
}

variable "vpc1_name" {
  description = "The name of the first VPC network."
  type        = string
}

variable "vpc2_name" {
  description = "The name of the second VPC network."
  type        = string
}

variable "region1" {
  description = "The GCP region for VPC 1 resources (HA VPN Gateway and Cloud Router)."
  type        = string
}

variable "region2" {
  description = "The GCP region for VPC 2 resources (HA VPN Gateway and Cloud Router). If omitted or null, defaults to region1."
  type        = string
  default     = null
}

variable "vpc1_cldrouter_custom" {
  description = "Custom Cloud Router configuration for VPC 1 (BGP ASN and route advertisements). If null, defaults to ASN 64514 and default route advertisement."
  type = object({
    asn              = optional(number, 64514)
    all_subnets      = optional(bool)
    ip_ranges        = optional(map(string))
    custom_advertise = optional(object({
      all_subnets = optional(bool, true)
      ip_ranges   = optional(map(string), {})
    }))
  })
  default = null
}

variable "vpc2_cldrouter_custom" {
  description = "Custom Cloud Router configuration for VPC 2 (BGP ASN and route advertisements). If null, defaults to ASN 64513 and default route advertisement."
  type = object({
    asn              = optional(number, 64513)
    all_subnets      = optional(bool)
    ip_ranges        = optional(map(string))
    custom_advertise = optional(object({
      all_subnets = optional(bool, true)
      ip_ranges   = optional(map(string), {})
    }))
  })
  default = null
}

