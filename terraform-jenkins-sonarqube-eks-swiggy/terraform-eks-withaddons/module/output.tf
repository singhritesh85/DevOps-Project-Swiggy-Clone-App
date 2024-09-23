output "registry_id" {
  description = "Registry ID of repository"
  value = aws_ecr_repository.ecr.registry_id
}
output "repository_url" {
  description = "The URL of Repository"
  value = aws_ecr_repository.ecr.repository_url
}
