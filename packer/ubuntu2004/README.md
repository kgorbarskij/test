## Packer Build Ubuntu for VMware vSphere

### Configuration files and settings for creating a Uubuntu 20.04 template for vSphere.

- Fill in the password field in the http/user-data file using sha512 hashing (On Linux: mkpasswd -m sha512crypt)
- In the ubuntu-2004.
  json define all the critical variables needed to connect to your infrastructure
- Requires ubuntu 20.04 image

### Run:

- packer build -var-file variables.json ubuntu-20.04.json
