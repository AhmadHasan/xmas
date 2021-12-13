## Application Structure
The following files are the basis for the deployment process:
   - Dockerfile: For creating a Docker container from the code of the application.

## Preparing the Image
### Local running on Docker

To build the docker image named xmas (-t for tag) directly, run the following command form the application directory where the Dockerfile resides: 
 
    docker build -t xmas .

Docker should have created an image for you. 
If you go to Docker dashboard, you should be able to see the new image.

Now you can run the image from Docker dashboard or from command line 
(where xmas is the name of the image):

    docker run -p 8080:8080 xmas

You can access the images command line by running:

    docker run -ti --entrypoint /bin/sh xmas/xmas

To view image information:
    docker ps

To remove your image locally:

    docker rmi xmas

### Upload your image to an Azure Container Registry
You have first to create a container registry on Azure. Then you have to log in
to the registry from your command prompt (More [here](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli)):

    az login
    az acr login --name XMasContainerRegistry


#### Create an alias of the image
Use docker tag to create an alias of the image with the fully qualified path to your registry. This example specifies the samples namespace to avoid clutter in the root of the registry.

    docker tag xmas xmascontainerregistry.azurecr.io/xmas

Whare xmas is the name you gave to your local image and the rest is the tag.


Now you can push you image to the container registry:

    docker push xmascontainerregistry.azurecr.io/xmas

When this is done, you should be able to see your image on Azure portal under your container registry.
You can also list existing images using CLI:

    az acr repository list --name XmasContainerRegistry

To remove the tags from your image:

And to remove the image from the container registry:

    az acr repository delete --name XMasContainerRegistry --image xmas

## Creating Azure Kubernetes Service
Before you create an Azure Kubernetes Service, you need a service principal for accessing it.
You can create the service principal with Azure CLI:
    az ad sp create-for-rbac --name XMasAKSClusterServicePrincipal
The output of the command should look like:

    {
        "appId": "c683d32e-e3c1-4157-b341-78f720655319",
        "displayName": "XMasAKSClusterServicePrincipal",
        "name": "c683d32e-e3c1-4157-b341-78f720655319",
        "password": "lVwk3~QeJUG4DVo-ctPy-dl2Sr~mDR0QbV",
        "tenant": "801baf61-cd8b-472d-879f-a96ce718a34d"
    }


Now you can create a Kubernetes service on Azure Portal and assign this principal to it.

## Deploy you application

Now you have an image of the application ready for running on Azure container registry. 
The next step is to deploy this image on the Kubernetes service. Get tha name of your container registry again:

    az acr list --resource-group RGXmasLab --query "[].{acrLoginServer:loginServer}"

We have to tell kubernetes where to pull the application image from. We have to specify the container registry as source.
Edit your deployment file by adjusting the container configuration:

    containers:
    - name: azure-vote-front
      image: mcr.microsoft.com/azuredocs/azure-vote-front:v1