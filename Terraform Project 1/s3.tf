resource "aws_s3_bucket" "jenkins_bucket" {
  bucket = "jenkins-bucket-34897s"
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_s3_bucket_acl" "jenkins_bucket_acl" {
  bucket = aws_s3_bucket.jenkins_bucket.id
  acl    = "private"
}
