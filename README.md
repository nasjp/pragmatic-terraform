# Pragmatic Terraform on AWS

```sh
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

## Note

RDS、ElastiCacheは低スペックな安いインスタンスタイプを指定しているので、applyが遅い

## References

- [実践Terraform　AWSにおけるシステム設計とベストプラクティス](https://www.amazon.co.jp/dp/4844378139/ref=cm_sw_em_r_mt_dp_G0QW8N22XPY6QN9XBS1Z)
  - [Pragmatic Terraform on AWS サンプルコード](https://github.com/tmknom/example-pragmatic-terraform-on-aws)
- [無料ドメイン(.tk)とRoute53を利用して0円でHTTPS環境を設定してみた](https://dev.classmethod.jp/articles/mesoko-r53-cdn/)

