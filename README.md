# Workout-recorder - HashiCorp Nomad

The content of this project is part of the post on blog https://red-devops.pl/<br>
The repository contains HashiCorp Terraform code, thanks to which we can automatically create an infrastruture for the workoutrecorder apps.
This is the next step in which we add the HashiCorp Nomad cluster to our infrastructure.<br> 
Post provisioning of the Nomad is done using Ansible playbook in the repository:
https://github.com/red-devops/Nomad-cluster-ansible <br>

After executing the HashCorp Terraform code from the last step, folder <code>/Workout-recorder-nomad/100-app-infra/190-nomad-clients</code>, download the "nomad_client_public" output address and use in the Frontend App repository ( link: https://github.com/red-devops/workoutrecorder-frontend ) to release a new docker image version of the application.

## Workout-recorder - Application deployment
Application deployment is done using a repository https://github.com/red-devops/Nomad-Packs. To make the workoutrecorder app work you need to deploy the apps: workoutrecorder_backend, workoutrecorder_frontend and fabio from the github actions panel.<br>
Once all the applications are correctly running in the HashCorp Nomad cluster. The whole system will be ready and the frontend App will be served on the Nomad client public ip address on port 9999. On port 9998 it is possible to check fabio's mapping which uses Consul service discovery to redirect traffic to healthy apps.<br>

## Workout-recorder - Self hosted runner
In the implementation we use a self hosted runner was built automatically using this repository: <br>
https://github.com/red-devops/Packer-guide

## Workout-recorder - Old Version
An older version of the application running on docker compose:<br>
https://github.com/red-devops/Workout-recorder <br>
