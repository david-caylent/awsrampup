data "aws_caller_identity" "dev" {
  provider = aws.caylent-dev
}

data "aws_caller_identity" "testing" {
  provider = aws.caylent-testing
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
        "AWS": "arn:aws:iam::${data.aws_caller_identity.dev}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF

}
