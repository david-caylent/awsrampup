data "aws_caller_identity" "dev" {
  provider = aws.dev
}

data "aws_caller_identity" "testing" {
  provider = aws.testing
}

resource "aws_iam_role" "testing_role" {
  name = "david_testing_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.dev.account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "testing_policy" {
  role       = aws_iam_role.testing_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
