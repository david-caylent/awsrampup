data "aws_caller_identity" "dev" {
  provider = aws.dev
}

data "aws_caller_identity" "testing" {
  provider = aws.testing
}

resource "aws_iam_role" "testing_role" {
  provider = aws.testing
  name     = "david_testing_role"

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
  provider   = aws.testing
  role       = aws_iam_role.testing_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy" "testing_policy" {
  provider    = aws.dev
  name        = "david_testing_policy"
  path        = "/"
  description = "David testing policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": [
            "arn:aws:iam::${data.aws_caller_identity.testing.account_id}:role/${aws_iam_role.testing_role.name}"
        ]
    }
}
EOF
}
