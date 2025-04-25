# IAM role for AWS SES
resource "aws_iam_role" "ses_access" {
  name = "ses-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${module.eks.oidc_provider}"
        }
        Condition = {
          StringEquals = {
            "${module.eks.oidc_provider}:aud" : "sts.amazonaws.com",
            "${module.eks.oidc_provider}:sub" : "system:serviceaccount:default:ses-access"
          }
        }
      }
    ]
  })
}

# IAM policy for AWS SES
resource "aws_iam_policy" "ses_access" {
  name = "ses-access-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ses:ListIdentities",
          "ses:GetSendQuota",
          "ses:GetSendStatistics"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "ses_access" {
  role       = aws_iam_role.ses_access.name
  policy_arn = aws_iam_policy.ses_access.arn
}


# Create service account for SES Access
resource "kubernetes_service_account" "ses_access" {
  metadata {
    name      = "ses-access"   
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.ses_access.arn
    }
  }
}