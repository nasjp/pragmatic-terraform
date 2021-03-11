# Pragmatic Terraform on AWS

```fish
eval (assume-role pragmatic-terraform)
```

## AWS Systems Manager

```sh
# create
aws ssm put-parameter --name 'plain_name' --value 'plain value' --type String
# get
aws ssm get-parameter --output text --name 'plain_name' --query Parameter.Value
# update
aws ssm put-parameter --name 'plain_name' --value 'modified value' --type String --overwrite

# 'encryption create
aws ssm put-parameter --name 'encryption_name' --value 'encryption value' --type SecureString
# decryption get
aws ssm get-parameter --output text --name 'encryption_name' --query Parameter.Value --with-decryption
```

## Amazon Elastic Container Registry

```fish
eval (aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email)
set AWS_ECR_URL (aws ecr describe-repositories --repository-names example --output text --query "repositories[0].repositoryUri")
docker build -t "$AWS_ECR_URL":latest .
docker push "$AWS_ECR_URL":latest
set AWS_ECR_URL
```

## GitHub Token

1. Access <https://github.com/settings/tokens>
2. Personal access tokens
3. Generate new token
4. Check `repo` and `admin:repo_hook`
5. Execute `set GITHUB_TOKEN xxxxxxxx` (on `fish`)

## Session Manager Plugin

```sh
aws ssm start-session --target i-XXXXXXXXXXXXXXXXX
```

## Amazon Athena

### Create table

<https://docs.aws.amazon.com/ja_jp/athena/latest/ug/application-load-balancer-logs.html>

## Note

RDS、ElastiCacheは低スペックな安いインスタンスタイプを指定しているので、applyが遅い

## References

- [実践Terraform　AWSにおけるシステム設計とベストプラクティス](https://www.amazon.co.jp/dp/4844378139/ref=cm_sw_em_r_mt_dp_G0QW8N22XPY6QN9XBS1Z)
  - [Pragmatic Terraform on AWS サンプルコード](https://github.com/tmknom/example-pragmatic-terraform-on-aws)
- [無料ドメイン(.tk)とRoute53を利用して0円でHTTPS環境を設定してみた](https://dev.classmethod.jp/articles/mesoko-r53-cdn/)

