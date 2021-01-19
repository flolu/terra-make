# bin/bash
set -o errexit
set -o nounset
set -o pipefail
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# "---------------------------------------------------------"
# "-                                                       -"
# "-  Destroys complete kubernetes cluster                 -"
# "-                                                       -"
# "---------------------------------------------------------"

echo ""
echo "==============================="
echo " Destroys kubernetes cluster  "
echo "==============================="
echo ""
# https://www.terraform.io/docs/commands/destroy.html
(cd "$ROOT/terraform/main"; terraform destroy)