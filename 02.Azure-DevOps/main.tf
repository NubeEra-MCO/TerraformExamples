terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 1.0"
    }
  }
}
provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/mco-nubeera"
  personal_access_token = "PAT"
}

resource "azuredevops_project" "sample_project" {
  name       = "DemoProject"
  visibility = "private"
}
