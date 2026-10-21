# HA-VPN Between 2 VPCs

![architecture](./vpn-vpc-arch.jpg)

## Notes
* The intent of this repo is to create a fixed environment for learning, demonstration, and proofs of concept (PoCs), **not production**.
* The script relies on the Google Cloud org policy constraints/compute.restrictVpnPeerIPs not restricting IPs at the project level, so the script may fail in highly regulated environments.
* The actions taken by deploying this repo will add cost. To minimize costs, instructions are provided for how to teardown the demo environment. For more on cost, please refer to Google Cloud public pricing pages for components such as HA VPN and Data Transfer. 

## Setup instructions

1. Clone the this repo

```sh
git clone https://github.com/kurtradecki/gcp-vpn-vpc-demo-2.git
```

2. Ensure you have an active GCP account selected to run gcloud commands with [gcloud CLI](https://cloud.google.com/sdk/docs/install) (not needed in Cloud Shell).

```sh
gcloud auth login
gcloud auth application-default login
```

## Deploy the script

To deploy the script, follow this process:
1. Create one or two projects in GCP, depending on whether VPCs reside in the same project or across different projects. Reference if needed [Creating and managing projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
2. Add a VPC to each project (or 2 VPCs within the same project), if not already created. Reference if needed [Create and manage VPC networks](https://cloud.google.com/vpc/docs/create-modify-vpc-networks)
3. Set the Google Cloud org policy constraints/compute.restrictVpnPeerIPs to Allow All, if not already. Reference if needed [Creating and updating managed constraints](https://cloud.google.com/resource-manager/docs/organization-policy/using-constraints#creating_and_updating_managed_constraints)
4. Rename example.tfvars to terraform.tfvars
5. In terraform.tfvars, add the values for variables that need values (see the file for details). All other values can stay the same unless customization is required. Reference if needed for how to find project ID, see [Find the project name, number, and ID](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects)
6. At the command prompt where you'll run the script, in the Terraform directory, run:

```sh 
terraform init
terraform plan
terraform apply -auto-approve
```

4. Wait a few minutes for the script to complete. You'll see a message similar to "Apply complete!" and then move to the next section.

## Test reachability across the VPN

To test control plane and data plane, add a VM in each VPC and firewall rules to allow at least icmp, then ping between the VMs. 

## Conclusion & Cleanup

Congratulations! You've successfully deployed the script.

To delete the created infrastructure, run the following command:

```sh
terraform destroy -auto-approve
```

Wait a few minutes for the components created by the Terraform script to be removed. You'll see a message similar to "Destroy complete!" 
