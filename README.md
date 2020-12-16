# Kubernetes Installation on Hetzner with Terraform and Ansible

```bash
git clone git@github.com:cdalar/hcloud-iac.git
cd hcloud-iac
terraform init
sudo terraform apply 
ansible-playbook -i tf_hosts.yml playbooks/main.yml
kubectl get nodes -o wide --kubeconfig config
```

* Fully automated k8s installation on Hetzner
* Hetzner Components (CSI, Controller Manager)
* Cilium as CNI
* 

Please check my story on medium below for details. 

* https://cdalar.medium.com/kubernetes-installation-on-hetzner-cloud-with-terraform-and-ansible-dce117f185ee
