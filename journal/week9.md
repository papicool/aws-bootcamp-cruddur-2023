# Week 9 — CI/CD with CodePipeline, CodeBuild and CodeDeploy

Create the following two scripts:

backend-flask/buildspec.yml, change the env variables to your owns
aws/policies/ecr-codebuild-backend-role.json 

Create a branch named prod, which will be used for AWS CodeBuild and CodePipeline later.

At AWS ECS, update desired tasks in the service to 1, if this was set to 0 before.


## AWS CodeBuild

Create a build project:

- name as `cruddur-backend-flask-bake-image`, enable build badge
- source:
  - choose source provider as GitHub, repository in my GitHub account, select the `cruddur` repo, set source version to `prod`
  - select rebuild every time a code change is pushed to this repository, select single build, select event type as `PULL_REQUEST_MERGED`
- environment:
  - select managed image, select operating system as Amazon Linux 2, select standard runtime, select the latest image (4.0), select environment type as Linux, tick privileged
  - create a new service role automatically named as `codebuild-cruddur-backend-flask-bake-image-service-role`
  - decrease timeout to 20 min, don't select any certificate nor VPC, select compute as 3 GB memory and 2 vCPUs
- use a buildspec file `backend-flask/buildspec.yml`
- no artifects
- select cloudwatch logs, set group name as `/cruddur/build/backend-flask`, stream name as `backend-flask`

For the newly created service role, attach a policy as shown in `aws/policies/ecr-codebuild-backend-role.json` in order to grant more permissions. Then click "Start build" (or triggered by a merge to the `prod` branch). If succeeded, you can check the build history for details.

## AWS CodePipeline

Create a pipeline:

- name as `cruddur-backend-fargate`, allow to create a new service role automatically named as `AWSCodePipelineServiceRole-us-east-1-cruddur-backend-fargate`, select default location and default managed key in advanced settings
- source stage from GitHub (Version 2), click "Connect to GitHub", set connection name as `cruddur`, install a new app, select the cruddur repo, in the end finish "Connect to GitHub" and back to the pipeline page
- select the cruddur repo and select branch `prod`, select "start the pipeline on source code change" and default output artifact format
- for build stage, select AWS CodeBuild as build provider, select your region, select the newly created project `cruddur-backend-flask-bake-image`
- for deploy stage, select ECS as deploy provide, choose `cruddur` cluster, `backend-flask` service

## Test Pipeline

Update `backend-flask/app.py` by changing the return in `health_check` function from `return {"success": True}, 200` to `return {"success": True, "ver": 1}, 200`.
