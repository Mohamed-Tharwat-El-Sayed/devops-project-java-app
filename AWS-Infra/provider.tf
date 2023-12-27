provider "aws" {
    region = var.region
    # shared_config_files = ["$HOME/.aws/config"]
    # shared_credentials_files = ["$HOME/.aws/credentials"]
    access_key = var.access_key
    secret_key = var.secret_key
  
}
