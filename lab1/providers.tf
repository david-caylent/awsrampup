provider aws {
  alias   = "dev"
  version = "~> 2.42"
  profile = "caylent-dev"
  region  = "us-east-1"
}

provider aws {
  alias   = "testing"
  version = "~> 2.42"
  profile = "caylent-testing"
  region  = "us-east-1"
}
