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
  description = "Custom BGP route advertisement configuration for the Cloud Router in VPC 1. If null, default route advertisement is used."
  type = object({
    all_subnets = bool
    ip_ranges   = map(string)
  })
  default = null
}

variable "vpc2_cldrouter_custom" {
  description = "Custom BGP route advertisement configuration for the Cloud Router in VPC 2. If null, default route advertisement is used."
  type = object({
    all_subnets = bool
    ip_ranges   = map(string)
  })
  default = null
}
