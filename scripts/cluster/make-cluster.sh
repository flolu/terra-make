# bin/bash
set -o errexit
set -o nounset
set -o pipefail
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# "---------------------------------------------------------"
# "-                                                       -"
# "-  Create or configure kubernetes cluster on gke      -"
# "-                                                       -"
# "---------------------------------------------------------"

echo ""
echo "==============================="
echo " Create new kubernetes cluster:"
echo "==============================="
echo ""

echo "* Initialize Terraform"
echo "==============================="
# https://www.terraform.io/docs/commands/init.html
(cd "$ROOT/terraform/main"; terraform init -input=false)

echo "* Validate Terraform"
echo "==============================="
# https://www.terraform.io/docs/commands/validate.html
(cd "$ROOT/terraform/main"; terraform validate)

echo "* Plan Terraform"
echo "==============================="
# https://www.terraform.io/docs/commands/plan.html
(cd "$ROOT/terraform/main"; terraform plan -out=gke.plan)

echo "* Run (apply) Terraform"
echo "==============================="
# https://www.terraform.io/docs/commands/apply.html
(cd "$ROOT/terraform/main"; terraform apply -input=false -auto-approve "gke.plan")

TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`

mv "$ROOT/terraform/main/gke.plan" "$ROOT/terraform/main/gke.plan.deployed.${TIMESTAMP}"

echo ""
echo "==============================="
echo "New kubernetes cluster created."
echo "==============================="
echo ""

echo "To deploy or update quantum, "
echo "please run the following command: "
echo "==============================="
echo "* make quantum "
echo "==============================="
echo ""
