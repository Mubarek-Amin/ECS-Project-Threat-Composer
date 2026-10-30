include "root"{
    path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "../../../Terraform"
}
inputs = {
    image_tag = get_env("IMAGE_TAG","1")
}