# Script to setup my Ubuntu machines

To run the setup just execute the following line:
```bash
bash <(wget -qO- https://raw.githubusercontent.com/ischwarz23/.setup/master/install.sh)
```

The logs of the installation are written to the file 'setup.log' which is located in the directory, in which you executed the command obove.  
You can also follow the logs during installation using the `tail` command:
```bash
tail -f setup.log
```