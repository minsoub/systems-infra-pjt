variable "repo_default_branch" {
    description = "The name of the default repository branch (default: master)"
    default = "master"
}

variable "environment" {
    description = "The environment being deployed (default: eks-dev)"
    default = "eks-dev"
}

variable "build_timeout" {
    description = "The time to wait for a CodeBuild to complete before timing out in minutes (default: 5)"
    default = "5"
}

variable "build_compute_type" {
  description = "The build instance type for CodeBuild (default: BUILD_GENERAL1_SMALL)"
  default     = "BUILD_GENERAL1_SMALL"
}

variable "build_image" {
  description = "The build image for CodeBuild to use (default: aws/codebuild/nodejs:6.3.1)"
  default     = "aws/codebuild/nodejs:6.3.1"
}