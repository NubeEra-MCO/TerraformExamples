cat<<EOF >> ~/.bashrc
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"
EOF

source ~/.bashrc

chmod +x load_env.sh
source load_env.sh