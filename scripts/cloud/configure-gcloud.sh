# bin/bash
set -o errexit
set -o nounset
set -o pipefail

# "---------------------------------------------------------"
# "-                                                       -"
# "-  Configures gcloud and terraform for automation       -"
# "-                                                       -"
# "---------------------------------------------------------"

command -v gcloud > /dev/null 2>&1 || { \
 echo >&2 "GCloud required but it's not installed. Run: make setup "; exit 1; }

echo ""
echo "==============================="
echo " Configure gcloud & terraform: "
echo "==============================="
echo ""

PROJECT=$(gcloud config get-value core/project)
if [[ -z "${PROJECT}" ]] ; then
    echo "gcloud cli must be configured with a default project." 1>&2
    echo "Initialize and configure gcloud now"
    command gcloud init
fi
echo "* Get the default gcp project: Check"

REGION=$(gcloud config get-value compute/region)
if [ -z "${REGION}" ]; then
    echo "gcloud cli must be configured with a default zone." 1>&2
    echo "run 'gcloud config set compute/region REGION'." 1>&2
    echo "replace 'ZONE' with the region name like us-west1." 1>&2
    exit 1;
fi
echo "* Get the default gcp region: Check"

ZONE=$(gcloud config get-value compute/zone)
if [ -z "${ZONE}" ]; then
    echo "gcloud cli must be configured with a default zone." 1>&2
    echo "run 'gcloud config set compute/zone ZONE'." 1>&2
    echo "replace 'ZONE' with the zone name like us-west1-a." 1>&2
    exit 1;
fi
echo "* Get the default gcp zone: Check"


ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
TFVARS_FILE="$ROOT/terraform/terraform.tfvars"
# check if a previous tfvars file is present and if so, delete it
if [[ -f "${TFVARS_FILE}" ]]
then
    rm "${TFVARS_FILE}"
fi

# Write out all the values we gathered into a tfvars file to configure terraform
cat <<EOF > "${TFVARS_FILE}"
project_id="${PROJECT}"
region="${REGION}"
zone="${ZONE}"
multi-zones=["${ZONE}"]
EOF

# Copy the tfvars file into target folders; overwrite any previous file.
command cp -f "${TFVARS_FILE}" "$ROOT/terraform/dev/terraform.tfvars"
command cp -f "${TFVARS_FILE}" "$ROOT/terraform/main/terraform.tfvars"
command rm -f "${TFVARS_FILE}"
echo "* Configure terraform: Check"

command gcloud services enable compute.googleapis.com \
        container.googleapis.com \
        cloudbuild.googleapis.com \
        cloudresourcemanager.googleapis.com
echo "* Enable GCloud APIs: Check"

# Check if logged in to gcloud; otherwise  authenticate
TOKEN=$(gcloud auth application-default print-access-token)
if [ -z "${ZONE}" ]; then
    echo "Authentication for terraform"
    command gcloud auth application-default login
fi
echo "Authentication: Check"

echo ""
echo "==============================="
echo "All configuration completed."
echo "==============================="
echo ""

echo "To deploy a new cluster or update one, "
echo "please run one of the following command: "
echo "==============================="
echo "* make create-cluster "
echo "* make update-cluster "
echo "==============================="
echo ""
