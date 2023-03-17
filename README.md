<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#whatisthis">What is this</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#clonerepo">Clone the repository</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
  </ol>
</details>


<!-- WHAT IS THIS -->
## WHAT IS THIS

I have found very inefficient working from R terminals when developing code needed for some projects and working with big data that prevent your from using R local sessions. Luckily I found this github resource:

[rocker-org](https://github.com/rocker-org/rocker)

So, I started using some of their base images to wrap up code I needed for my projects on docker containers that exposed connections to Rstudio servers on ports X

This is a step by step guide on how to wrap up your dependencies needed for projects on a Dockerfile exposing Rstudio. Then, you are ready to do port binding and ssh tunneling so that you can access Rstudio server on your local machine



<!-- GETTING STARTED -->
## Getting Started

First you need to make sure that you have the gitHub CLI set to be able to clone this repository.
Then add your credentials and configure your ssh key

### Prerequisites

Do some git set up. Register on git, get ssh key and add it to your github account

  ```sh
  sudo apt install git
  ```
  ```
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
  ```

  ```sh
  # Create ssh key for your email
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

  # Ensure th ssh-agen runs and add key to the agent
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  ```

Then, follow this guideline:

[ssh-connect-github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
  
### Clone the repository

Now, you are ready to clone this repository and start building the image exposing Rstudio server on 8787 port
1. Clone the repo


```sh
git clone https://github.com/AMCalejandro/rstudiodocker.git
```


<!-- USAGE EXAMPLES -->
## Usage

1. Modify the Dockerfile.  

Add any extra script you might want under R_WORKENV_CONFIG/ to create your docker image. 
Make sure that you add the installation in the Dockerfile file

2. Build the image on your cluster.  

Make sure you are on located the repository you just cloned

```sh
docker build -t <yourdockerimagename> .
```

3. Run the container.  

Run the container on dettach mode and bind the port on the container in Rstudio to the port you want in your HPC
GOTCHA: Make sure the port is free...

Note we are using the default Rstudio server port that it is within the docker container based on the Dockerfile baseimage to an 8090 HPC port

```sh
docker run -d \
-e ROOT=True \
-e PASSWORD="password" \
-p 8090:8787 \
<yourdockerimagename>
```

4. Open a new terminal on your localhost and do ssh tunneling

Once you have the docker container running in dettach mode on your HPC, you can go to a terminla on your local computer and do ssh tunneling
8090 on the left is your local port. On the right you have the ip (localhost) and port (8090) to which we are ssh tunneling

```sh
ssh <yourusername>@<yourclusterip> -NL 8090:localhost:8090
```
