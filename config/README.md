# Config File Options

## OPTIONS

- SWAP_BIN_SIZE - is the size of how big the file will be in MB
- SWAPPINESS - self explanatory, has to be betweeen 0 - 100. Larger vaules may boost battery life, more apps on background BUT apps will become a bit slower to respond and may destroy your storage device
- SWAP_FILE_PRIOR - usefull if you ROM comes with a swap file, higher values will prioritize the the new swap file.

## Naming schemes

### var_<SWAP_BIN_SIZE>-<SWAPPINESS>-<SWAP_FILE_PRIOR or AUTO>

For Example, a 4096 SWAP_BIN_SIZE, 80% SWAPPINESS and SWAP_FILE_PRIOR as 1 would be called var_4096_80_1.sh

make sure to add the name to the build.sh at the root for pipelines