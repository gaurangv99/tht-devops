# Explain decisions made during the implmentation of the test
I first ensured that the local setup worked well to understand the code flow. Then, I verified that we achieved similar results when deploying to ECS on EC2 and Minikube.

# What is missing 
Minor issues were present, such as some misconfigured outputs like module.ecs[0].alb_dns_name. Additionally, the data lookup for the availability zone was missing in the VPC module, and the monitoring namespace was also missing.
# What could be improved 
Terraform modules can be further modularized by having each AWS service as a separate GitHub repository, which can be a good practice. Additionally, Makefiles could be consolidated for better organization and maintainability. Security groups were also too open initially in the test and should be restricted for better security.

# What I would do if this was in a production environment and I had more time
I would implement a proper CI/CD setup. The CI stage should conclude with uploading the image to ECR, and the PR branch should generate a proper deployment plan. Additionally, I would write test cases for the application and introduce a build stage where the build would fail if the application tests do not pass. For Kubernetes Helm deployments, I would leverage ArgoCD for better management and automation.