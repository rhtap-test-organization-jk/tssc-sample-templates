# Trusted Application Pipeline Software Template

This application, ${{ parameters.name }}, was created from a Trusted Application Pipeline Software Template.

The software templates create a new source and gitops deployment repositories with a sample source. 

## Repositories

The source code for your application can be found in [${{ values.srcRepoURL }} ](${{ values.srcRepoURL }} ).
 
The gitops repository, which contains the kubernetes manifests for the application can be found
[${{ values.repoURL }} ](${{ values.repoURL }} ) 

## Application namespaces 

The default application  will be found in the following namespaces. Applications can be deployed into unique namespaces or multiple software templates all generated into the same group namespaces.  

|  Namespace   |  Description   |  
| -------- | -------- |  

| ${{ parameters.name }}-development | The default application during development. Every build will be deployed to this namespace for testing. |

| ${{ parameters.name }}-stage | The staging namespace for this application. Promotion from development to stage is manual via an update to the [gitops repository](${{ values.repoURL }} ) in the components/${{ parameters.name }}/overlays/prod directory | 

| ${{ parameters.name }}-prod | The production namespace for this application. Promotion from stage to production is manual via an update to the [gitops repository](${{ values.repoURL }} ) in the components/${{ parameters.name }}/overlays/prod directory | 