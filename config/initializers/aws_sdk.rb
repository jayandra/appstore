# Skip SSL certificate verification in development environment
if Rails.env.development?
  require "aws-sdk-s3"

  # Configure AWS SDK to skip SSL certificate verification
  Aws.config.update({
    ssl_verify_peer: false,
    ssl_ca_bundle: false
  })
end
