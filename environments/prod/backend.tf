terraform {
  backend "gcs" {
    bucket = "protexbc-tfstate"
    prefix = "environments/prod"
  }
}
