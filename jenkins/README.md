## CI/CD

Describe the process of building and delivering applications using Jenkins.
The pipeline is started with a webhook initialized by git. Git repository specified by _github_ variable <br>

- Using the kubernetes cluster agents, an image is formed from the source code located in the apps folder using the Dockerfile and stored in the registry.
- Testing phase in progress
- At the deployment stage, the image is copied from the registry and deployed in the kubernetes cluster
- At the final stage, a notification of the results is generated using the telegram bot
