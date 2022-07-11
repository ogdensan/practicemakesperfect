data "aws_caller_identity" "this" {}

resource "aws_iam_role" "this" {
  name = "deploy_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:user/*"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "this" {
  name        = "deploy_policy"
  path        = "/"
  description = "policy to allow users to assume a certain role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.this.arn
      },
    ]
  })
}

resource "aws_iam_group" "this" {
  name = "deploy-group"
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_user" "this" {
  name = "deploy-user"
}

resource "aws_iam_group_membership" "this" {
  name = "deploy-group-membership"

  users = [
    aws_iam_user.this.name
  ]

  group = aws_iam_group.this.name
}
