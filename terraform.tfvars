# Your Hetzner Cloud Project Token. 
# Create one from https://console.hetzner.cloud/ -> Project -> Security -> API TOKENS
# Should have Read & Write Permission
hcloud_token = "<YOUR_API_TOKEN>"
# You better don't change this if you do, be sure to change the it
# on ansible playbooks as well. 
ip_range = "10.10.0.0/16" 
# Default is ~/.ssh/id_rsa.pub
ssh_public_key = "~/.ssh/id_rsa.pub" 
