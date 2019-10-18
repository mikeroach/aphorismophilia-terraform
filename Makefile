#terraform-cmd = docker run -it -e "TF_IN_AUTOMATION=1" -w /data --rm -v ${CURDIR}:/data hashicorp/terraform:0.12.6
terraform-cmd = TF_IN_AUTOMATION=1 terraform

test: tf-init tf-fmt tf-validate

tf-init:
	$(terraform-cmd) init -input=false

tf-fmt:
	$(terraform-cmd) fmt -check -recursive -diff

tf-validate:
	$(terraform-cmd) validate