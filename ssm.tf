resource "aws_ssm_parameter" "db_username" {
  name        = "/db/username"
  value       = "root"
  type        = "String"
  description = "データベースの接続ユーザー名"
}

// Terraformではダミー値を設定して、あとでAWS CLIで更新する
// 下記をapply後に実行する
// 本来は別の場所にコード管理しておく
// aws ssm put-parameter --name '/db/password' --type SecureString --value 'ModifiedStrongPassword!'
resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "データベースのパスワード"

  lifecycle {
    ignore_changes = [value]
  }
}
