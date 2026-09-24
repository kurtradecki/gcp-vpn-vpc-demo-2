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

# --- Project & VPC Configuration ---

# Project ID for VPC 1 (Required)
project1_id = "ADD 1ST PROJECT ID HERE"

# Project ID for VPC 2 (Optional)
# If VPC 2 is in the same project as VPC 1, leave this commented out or set to null.
# If VPC 2 is in a different project, uncomment and specify the project ID.
# project2_id = "ADD 2ND PROJECT ID HERE"

# VPC Names (Required)
vpc1_name = "ADD 1ST VPC NAME HERE"
vpc2_name = "ADD 2ND VPC NAME HERE"

# Region for VPC 1 (Required)
region1 = "ADD 1ST REGION HERE"

# Region for VPC 2 (Optional)
# If VPC 2 is in the same region as VPC 1, leave this commented out or set to null.
# If VPC 2 is in a different region, uncomment and specify the region.
# region2 = "ADD 2ND REGION HERE"

# --- Cloud Router BGP Configuration (Optional) ---
# By default, Cloud Routers automatically advertise all VPC subnets (default mode).
# Uncomment and configure below if you need custom route advertisements:
#
# vpc1_cldrouter_custom = {
#   all_subnets = true # Set to false to advertise only custom ip_ranges
#   ip_ranges = {
#     "10.0.0.0/8" = "10 range" # Add CIDR ranges as needed: "CIDR" = "description"
#   }
# }
#
# vpc2_cldrouter_custom = {
#   all_subnets = true # Set to false to advertise only custom ip_ranges
#   ip_ranges = {
#     "172.16.0.0/12"  = "172.16 range"
#     "192.168.0.0/16" = "192.168 range"
#   }
# }