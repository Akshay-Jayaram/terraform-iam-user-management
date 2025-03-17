# IAM User Management with Terraform

This Terraform project automates the creation and management of IAM users, roles, and role assignments based on a YAML configuration file. Users can define their team members and their respective roles in `user-roles.yaml`, apply Terraform, and automatically set up AWS IAM users with login credentials and role-based permissions.

## Features
- **Define IAM users and roles in a YAML file** (`user-roles.yaml`).
- **Automatically create IAM users** with login profiles.
- **Generate temporary passwords** for users, viewable via Terraform outputs.
- **Create IAM roles** and attach predefined AWS managed policies.
- **Assign users to assume specific roles** using IAM role policies.
- **Easily manage user access** with minimal manual intervention.

---

## Setup and Usage

#### 1️⃣ Clone the Repository
```sh
git clone https://github.com/your-username/terraform-iam-user-management.git
cd terraform-iam-user-management
```

#### 2️⃣ Define Users and Roles in `user-roles.yaml`
Edit the `user-roles.yaml` file to specify users and their roles:
```yaml
users:
  - username: max
    roles: [admin, developer]
  - username: salt
    roles: [readonly]
  - username: abd
    roles: [auditor]
```

#### 3️⃣ Configure AWS Credentials
Ensure your AWS CLI is configured properly:
```sh
aws configure
```
Provide:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name (e.g., `us-west-1`)

#### 4️⃣ Initialize and Apply Terraform
```sh
terraform init
terraform apply -auto-approve
```

#### 5️⃣ Retrieve IAM User Passwords
After deployment, Terraform outputs the IAM user passwords:
```sh
terraform output passwords
```
Users can use these credentials to log in to the AWS Console.

#### 6️⃣ Validate IAM Roles and User Access
- Go to the **AWS IAM Console**.
- Verify that users have been created.
- Check that roles exist and have correct policies attached.
- Ensure users can assume only their assigned roles.

---

## How It Works
### **User and Role Creation**
- The **`user-roles.yaml`** file defines users and their respective roles.
- Terraform reads this file and creates IAM users with login profiles.
- Users receive temporary passwords upon creation.

### **Role Management**
- The Terraform configuration defines IAM roles and assigns **AWS managed policies** to them.
- Users are assigned the ability to **assume specific roles** via IAM role policies.
- The `sts:AssumeRole` policy ensures that only designated users can assume the specified roles.

---

## Updating Users and Roles
1. Modify `user-roles.yaml` with new users or role changes.
2. Apply the changes:
```sh
terraform apply -auto-approve
```

---

## Destroying IAM Resources
If you need to remove all IAM users and roles:
```sh
terraform destroy -auto-approve
```
This will **permanently delete all IAM users, roles, and their credentials**.

---

## Summary
This Terraform project simplifies AWS IAM user and role management by automating user creation, login setup, policy attachments, and role assumptions using a YAML configuration. Easily scale user access without manual AWS Console operations!

