variable "instance_type" {
  description = "Tipo de instância EC2"
  default     = "t2.micro"
}

variable "db_name" {
  description = "Nome do banco de dados"
  default     = "meu_banco"
}

variable "db_username" {
  description = "Nome de usuário do banco de dados"
  default     = "meu_usuario"
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}
