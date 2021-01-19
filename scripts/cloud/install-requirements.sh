# bin/bash
set -o errexit
set -o nounset
set -o pipefail

# "---------------------------------------------------------"
# "-                                                       -"
# "-  Installs all dependencies required by make           -"
# "-                                                       -"
# "---------------------------------------------------------"

# Check for system requirements silently and install missing if needed.
command sudo apt-get -qqq update

command make --version >/dev/null 2>&1 || {
  command sudo apt-get -qqq -y install gnupg
}

command curl --version >/dev/null 2>&1 || {
  command sudo apt-get -qqq -y install curl
}

command wget --version >/dev/null 2>&1 || {
  command sudo apt-get -qqq -y install wget
}

command gpg --version >/dev/null 2>&1 || {
  command sudo apt-get -qqq -y install gnupg
}

command git version >/dev/null 2>&1 || {
  command sudo apt-get -qqq -y install git
}

echo ""
echo "==============================="
echo "Check for required dependencies:"
echo "==============================="
echo ""

command go version >/dev/null 2>&1 || {
  echo "Download open Go-lang"
  command sudo apt-get -qqq update
  echo "Install Go-lang"
  command sudo apt-get -qqq -y install golang-go
  echo "Done"
  go version
}
echo "* Go-lang already installed"

command java -version >/dev/null 2>&1 || {
  # https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-20-04
  echo "Download open jdk"
  command sudo apt-get -qqq update
  echo "Install open jdk"
  command sudo apt-get -qqq -y install default-jdk
  echo "Done"
  command java -version
}
echo "* Java already installed"

command -v gcloud >/dev/null 2>&1 || {
  # https://cloud.google.com/sdk/docs/install#deb
  echo "Download GCloud"
  command echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  command curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "Install GCloud"
  command sudo apt-get -qqq update && sudo apt-get -qqq -y install google-cloud-sdk
}
echo "* GCloud already installed"

command -v kubectl >/dev/null 2>&1 || {
  # https://kubernetes.io/docs/tasks/tools/install-kubectl/
  echo "Download kubectl"
  command sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  echo "Install kubectl"
  command sudo chmod +x ./kubectl
  command sudo mv ./kubectl /usr/local/bin/kubectl
  echo "Done"
  kubectl version --client
}
echo "* Kubectl already installed"

command terraform -version >/dev/null 2>&1 || {
  # https://learn.hashicorp.com/tutorials/terraform/install-cli
  echo "Download terraform"
  command curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  command sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  command sudo apt-get -qqq -y update
  echo "Install terraform"
  command sudo apt-get -qqq -y install -y terraform
  echo "Done"
  terraform -version
}
echo "* Terraform already installed"

command bazel version >/dev/null 2>&1 || {
  # https://docs.bazel.build/versions/master/install-ubuntu.html
  echo "Download bazel"
  command curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel.gpg
  command sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
  command echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
  command sudo apt-get -qqq -y update
  echo "Install bazel"
  command sudo apt-get -qqq -y install -y bazel
  echo "Done"
  bazel -version
}
echo "* Bazel already installed"

command swift -version >/dev/null 2>&1 || {
  # https://swift.org/download/
  # https://richardhyde.net/2020/04/22/swift-on-ubuntu-server-18-04-lts.html
  command sudo apt-get -qqq update
  echo "Install Swift dependencies"
  command sudo apt-get -qqq -y install clang libpython2.7 libpython2.7-dev libtinfo5 libncurses5
  echo "Install Swift GPG keys"
  command  curl -fsSL https://swift.org/keys/all-keys.asc | gpg --import -
  command  curl -LO https://swift.org/builds/swift-5.3.2-release/ubuntu2004/swift-5.3.2-RELEASE/swift-5.3.2-RELEASE-ubuntu20.04.tar.gz.sig
  echo "Download Swift "
  curl -LO https://swift.org/builds/swift-5.3.2-release/ubuntu2004/swift-5.3.2-RELEASE/swift-5.3.2-RELEASE-ubuntu20.04.tar.gz
  echo "Verify Download!"
  command gpg --verify swift-5.3.2-RELEASE-ubuntu20.04.tar.gz.sig
  echo "Install Swift"
  command sudo tar -xzvf swift-5.3.2-RELEASE-ubuntu20.04.tar.gz --directory /usr/
  # remove download files
  command rm -f swift-5.3.2-RELEASE-ubuntu20.04.tar.*
  echo "Done"
  swift -version
}
echo "* Swift already installed"

echo ""
echo "==============================="
echo "All dependencies installed."
echo "==============================="
echo ""

echo "To configure gcloud if its not yet, "
echo "please run the following command: "
echo "==============================="
echo "* make configure-cloud "
echo "==============================="
echo ""
