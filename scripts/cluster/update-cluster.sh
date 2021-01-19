# bin/bash
set -o errexit
set -o nounset
set -o pipefail
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# "---------------------------------------------------------"
# "-                                                       -"
# "-  Updates complete kubernetes cluster                 -"
# "-                                                       -"
# "---------------------------------------------------------"

echo ""
echo "==============================="
echo " Updates kubernetes cluster  "
echo "==============================="
echo ""

echo "* Plan Terraform"
echo "==============================="
# https://www.terraform.io/docs/commands/plan.html
(cd "$ROOT/terraform/main"; terraform plan -out=gke.plan)

echo "* Run (apply) to update Terraform"
echo "==============================="
# https://www.terraform.io/docs/commands/apply.html
(cd "$ROOT/terraform/main"; terraform apply -input=false -auto-approve "gke.plan")

TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`

mv "$ROOT/terraform/main/gke.plan" "$ROOT/terraform/main/gke.plan.deployed.${TIMESTAMP}"

echo ""
echo "==============================="
echo " Cluster updated.              "
echo "==============================="
echo ""