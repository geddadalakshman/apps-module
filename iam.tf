###IAM Policy creation
resource "aws_iam_policy" "ssm-policy" {
  name        = "${var.env}-${var.component}-ssm"
  path        = "/"
  description = "${var.env}-${var.component}-ssm"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        //        "Resource" : [
        //          "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.${var.component}.*",
        //          "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.docdb.*",
        //          "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.elasticache.*"
        //          /// How to limit this permissions, which are unwanted for all components
        //        ]
        Resource : [for k in local.parameters : "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.${k}.*"]
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": [
          "ssm:DescribeParameters",
          "ssm:ListAssociations"
        ],
        "Resource": "*"
      }
    ]
  })
}

#IAM role
resource "aws_iam_role" "main" {
  name = "${var.env}-${var.component}-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

#IAM instance profile
resource "aws_iam_instance_profile" "main" {
  name = "${var.env}-${var.component}-profile"
  role = aws_iam_role.main.name
}

#IAM role_policy attachment
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.ssm-policy.arn
}
