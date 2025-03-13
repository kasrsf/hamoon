# Terraform Infrastructure

## Bootstrap Process

1. Create a terraform.tfvars file in the bootstrap directory:
   ```
   cp bootstrap/terraform.tfvars.example bootstrap/terraform.tfvars
   ```

2. Edit bootstrap/terraform.tfvars with your desired values:
   - Ensure S3 bucket name is globally unique
   - Update region if needed

3. Initialize and apply the bootstrap configuration:
   ```
   cd bootstrap
   terraform init
   terraform apply
   ```

4. After bootstrap resources are created, update the backend.tf with your values:
   ```
   # Edit /infrastructure/backend.tf if needed
   ```

5. Initialize your main infrastructure with the remote backend:
   ```
   cd ..
   terraform init
   ```

## Notes
- The bootstrap process only needs to be run once
- After bootstrap, all state will be stored in S3 with locking via DynamoDB
- Never delete the bootstrap S3 bucket or DynamoDB table