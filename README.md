# fall25-bioinformatics-project
The purpose of this project is to replicate the findings in the paper, Using equivalence class counts for fast and accurate testing of differential transcript usage (Cmero et al.)

The paper is available here: https://pmc.ncbi.nlm.nih.gov/articles/PMC6524746

By Liam Squires and Tristan Cornwell


# Steps to replicate
To get the python dependencies, run:
    pip install -r requirements.txt

# Install R
https://www.r-project.org/
I used the following to download it on ubuntu
```
    # update indices
    sudo apt update -qq
    # install two helper packages we need
    sudo apt install --no-install-recommends software-properties-common dirmngr
    # add the signing key (by Michael Rutter) for these repos
    # To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
    # Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
    # add the repo from CRAN -- lsb_release adjusts to 'noble' or 'jammy' or ... as needed
    sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
    # install R itself
    sudo apt install --no-install-recommends r-base
```

jupyter kernelspec list
R
install.packages('IRkernel')
IRkernel::installspec(user = TRUE)