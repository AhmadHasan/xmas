Application Structure
    The following files are the basis for the deployment process:
    Dockerfile: For creating a Docker container from the code of the application.

Local running on Docker

To build the docker image directly, run the following command form the application directory where the Dockerfile resides: 
 
-> docker build -t xmas .

Docker should have created an image for you. 
If you go to Docker dashboard, you should be able to see the new image.

Now you can run the image from Docker dashboard or from command line 
(where xmas is the name of the image):

-> docker run -p 8080:8080 xmas

You can access the images command line by running:

-> docker run -ti --entrypoint /bin/sh xmas/xmas

To view image information:
-> docker ps

