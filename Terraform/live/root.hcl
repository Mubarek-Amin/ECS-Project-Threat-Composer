remote_state{
    backend = "s3"
    generate = {path = "backend.tf", if_exists = "overwrite"}
    config = {
        bucket = "s3-ecs-tc"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "us-east-1"
        use_lockfile = true
        skip_bucket_versioning = true
        skip_bucket_ssencryption = true
        skip_bucket_root_access = true
        skip_bucket_enforced_tls = true
    }
}
generate "provider"{
    path = "provider.tf"
    if_exists = "overwrite"
    contents = <<-EOF
      provider "aws"{
        region = "us-east-1"
      }
    EOF
}
