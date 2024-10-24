# V2 Beta B
Added Support for Magisk OTA using JsonFile

# V2 Beta A

## WARNING THIS IS A BETA

## Removed
#### Volume keys to configure
This was a pain, for some it doesn't work

## Added
#### PreConfiged File
Each release file will have it's own config

#### More Configs
12 Different Combinations Added. You can add mode under config/

#### Fail Safe
No Idea on how well it'll work, but if the service file detects an incomplete start up of the last swapon, it will permenently disable itself.
To re-enable, it you have to re-install the module.

#### Log File 
is persistant now, but if you uninstall the module, it will get deleted

## Downloads

Here are the naming schemes for each config

`v<SWAP_BIN_SIZE>-<SWAPPINESS>-<SWAP_FILE_PRIOR or AUTO>`


- SWAP_BIN_SIZE - is the size of how big the file will be in MB
- SWAPPINESS - self explanatory, has to be betweeen 0 - 100. Larger vaules may boost battery life, more apps on background BUT apps will become a bit slower to respond and may destroy your storage device
- SWAP_FILE_PRIOR - usefull if you ROM comes with a swap file, higher values will prioritize the the new swap file.


For Example, a 4096 SWAP_BIN_SIZE, 80% SWAPPINESS and SWAP_FILE_PRIOR as 1 would be called var_4096_80_1.sh