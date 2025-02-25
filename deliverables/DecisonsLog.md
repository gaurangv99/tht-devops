# Explain decisions made during the implmentation of the test
I first ensured that the local setup worked properly to understand the code flow. Then, I verified that we achieved similar results when deploying to ECS on EC2 and Minikube. From my previous experience, the order in which services are deployed also matters in the case of service connect, so I made sure, by using a dependency block in Terraform, that the order processor gets deployed first.

# What is missing 
Minor issues were present, such as misconfigured outputs like module.ecs[0].alb_dns_name. Additionally, the data lookup for the availability zone was missing in the VPC module, and the monitoring namespace was also missing when I created the monitoring setup on Minikube. The documentation also lacked instructions on how to add a Prometheus data source in Grafana

# What could be improved 
Terraform modules can be further modularized by placing each AWS service in a separate GitHub repository, which is considered good practice. Additionally, Makefiles could be consolidated for better organization and maintainability. Security groups were also too open initially in the test and should be restricted for improved security. I also changed the AWS target group type to 'IP,' adhering to AWS best practices.

# What I would do if this was in a production environment and I had more time
I would implement a proper CI/CD setup. The CI stage should conclude with uploading the image to ECR, and the PR branch should generate a proper deployment plan and CD would be handled by tools like spinnaker.Additionally, I would write test cases for the application and introduce a build stage where the build would fail if the application tests do not pass. For Kubernetes Helm deployments, I would leverage ArgoCD for better management and automation.I would impove the entire observablity by using tools like datadog installing agent on a sidecar.
