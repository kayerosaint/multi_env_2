Create instances using Fedora Coreos with Docker inside, security group, ssh-poseidon, IGW, Routing, Subnets, ElasticIP, SSH keys inside Terraform state, Multi environments & Tfvars files. This version with additional network settings (private subnets,nat) and some fixes. ADD ECS cluster/roles/task def/ALB/service/logs. Created using Modules by Maksim Kulikov, 2022
P.S. You should create new VPC manually with this settings ( >>> "dev" / CIDR 10.0.0.0/16 / eu-west-3 <<< ) if you want to apply.
P.S.S. If you have an issue "permission denied" while ssh connection, just run script manually in the terraform working directory > fix.sh
