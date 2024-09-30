# Avalanche-Advanced-Module_1
# AVAX-PROOF-Advanced-Avalanche_MODULE 1
Avalanche Subnets MODULE_1
# #Build Your First Subnet
Installation

install the latest Avalanche-CLI binary is by running the install script:
```sh
curl -sSfL https://raw.githubusercontent.com/ava-labs/avalanche-cli/main/scripts/install.sh | sh -s
```
You can run all of the commands in this tutorial by calling ```~/bin/avalanche.```

You can also add the command to your system path by running

```
export PATH=~/bin:$PATH
```
If you add it to your path, you should be able to call the program anywhere with just ```avalanche```.
### Subnet 
 
Follow the below github repository's readme file in order to install avalanche CLI to your Ubuntu or Mac terminal:
 
 [https://docs.avax.network/tooling/cli-guides/install-avalanche-cli](https://github.com/ava-labs/avalanche-cli)

 Helping Resource: https://docs.avax.network/tooling/cli-create-deploy-subnets/create-subnet

In order to create a subnet, we run -

```
avalanche subnet create mySubnet
```

In order to deploy the created subnet, we run -

```
avalanche subnet deploy mySubnet
```

To connect your subnet to metamask, you will need to :

* Add network manually and enter Name, RPC URL, Token Symbol and Chain ID that you entered while creating the subnet.
* Import account with test tokens by entering the private key that you get from the terminal after you deploy the subnet.


  ## Authors
 
 Vicky Kumar
