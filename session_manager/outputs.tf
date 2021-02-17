output "ssm_document_description" {
  value       = aws_ssm_document.default.description
  description = "The description of the document."
}

output "ssm_document_schema_version" {
  value       = aws_ssm_document.default.schema_version
  description = "The schema version of the document."
}

output "ssm_document_default_version" {
  value       = aws_ssm_document.default.default_version
  description = "The default version of the document."
}

output "ssm_document_hash" {
  value       = aws_ssm_document.default.hash
  description = "The sha1 or sha256 of the document content."
}

output "ssm_document_hash_type" {
  value       = aws_ssm_document.default.hash_type
  description = "The hashing algorithm used when hashing the content."
}

output "ssm_document_latest_version" {
  value       = aws_ssm_document.default.latest_version
  description = "The latest version of the document."
}

output "ssm_document_owner" {
  value       = aws_ssm_document.default.owner
  description = "The AWS user account of the person who created the document."
}

output "ssm_document_status" {
  value       = aws_ssm_document.default.status
  description = "The current status of the document."
}

output "ssm_document_parameter" {
  value       = aws_ssm_document.default.parameter
  description = "The parameters that are available to this document."
}

output "ssm_document_platform_types" {
  value       = aws_ssm_document.default.platform_types
  description = "A list of OS platforms compatible with this SSM document."
}

output "iam_instance_profile_id" {
  value       = aws_iam_instance_profile.default.id
  description = "The instance profile's ID."
}

output "iam_instance_profile_arn" {
  value       = aws_iam_instance_profile.default.arn
  description = "The ARN assigned by AWS to the instance profile."
}

output "iam_instance_profile_create_date" {
  value       = aws_iam_instance_profile.default.create_date
  description = "The creation timestamp of the instance profile."
}

output "iam_instance_profile_name" {
  value       = aws_iam_instance_profile.default.name
  description = "The instance profile's name."
}

output "iam_instance_profile_path" {
  value       = aws_iam_instance_profile.default.path
  description = "The path of the instance profile in IAM."
}

output "iam_instance_profile_role" {
  value       = aws_iam_instance_profile.default.role
  description = "The role assigned to the instance profile."
}

output "iam_instance_profile_unique_id" {
  value       = aws_iam_instance_profile.default.unique_id
  description = "The unique ID assigned by AWS."
}

output "iam_role_arn" {
  value       = aws_iam_role.default.arn
  description = "The Amazon Resource Name (ARN) specifying the IAM Role."
}

output "iam_role_create_date" {
  value       = aws_iam_role.default.create_date
  description = "The creation date of the IAM Role."
}

output "iam_role_unique_id" {
  value       = aws_iam_role.default.unique_id
  description = "The stable and unique string identifying the IAM Role."
}

output "iam_role_name" {
  value       = aws_iam_role.default.name
  description = "The name of the IAM Role."
}

output "iam_role_description" {
  value       = aws_iam_role.default.description
  description = "The description of the IAM Role."
}

output "iam_policy_id" {
  value       = aws_iam_policy.default.id
  description = "The IAM Policy's ID."
}

output "iam_policy_arn" {
  value       = aws_iam_policy.default.arn
  description = "The ARN assigned by AWS to this IAM Policy."
}

output "iam_policy_description" {
  value       = aws_iam_policy.default.description
  description = "The description of the IAM Policy."
}

output "iam_policy_name" {
  value       = aws_iam_policy.default.name
  description = "The name of the IAM Policy."
}

output "iam_policy_path" {
  value       = aws_iam_policy.default.path
  description = "The path of the IAM Policy."
}

output "iam_policy_document" {
  value       = aws_iam_policy.default.policy
  description = "The policy document of the IAM Policy."
}
