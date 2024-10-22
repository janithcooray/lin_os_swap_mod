![linos jpg](https://github.com/janithcooray/lin_os_swap_mod/assets/50979590/55e98a40-9b04-4a72-8e1b-a59b394c7f10)

<div align="center">
  <h1>
    Android 7+ Swapfile Mod
  </h1>
</div>
This Magisk module enables or increases the SWAP memory by an additional 4GB or 8GB for Android 7.0 or above. It should also work with AOSP based ROMs, but it has only been tested on Lineage OS, ASOP and EVOX.

#

Tested Versions : Android 7 - 14


Android 15 Pending
#

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/janithcooray/lin_os_swap_mod/commits/main/)
[![GPL license](https://img.shields.io/badge/License-GPL-blue.svg)](https://github.com/janithcooray/lin_os_swap_mod/blob/main/LICENSE)


## Installation Steps
1. Download a Varient of this module from the latest release, choose the varient of your choice (more info below)
2. Flash the ZIP file in Magisk v24 or above


## Config Varients
We have organized the configurations using the following naming scheme, which you will find in all v2+ releases. Simply download your desired variant and flash it. Each variant has its configuration hardcoded. To change the configuration, uninstall the previous module and flash the new one.

The naming scheme is as follows:
`v<SWAP_BIN_SIZE>-<SWAPPINESS>-<SWAP_FILE_PRIOR or AUTO>`

- SWAP_BIN_SIZE - is the size of how big the file will be in MB
- SWAPPINESS -  A value between 0 and 100. Higher values may improve battery life and allow more background apps but can slow app responsiveness and potentially wear out your storage device.
- SWAP_FILE_PRIOR - Useful if your ROM includes a swap file. Higher values prioritize the new swap file.


For Example, a 4096 SWAP_BIN_SIZE, 80% SWAPPINESS and SWAP_FILE_PRIOR as 1 would be called var_4096_80_1.sh. you will find these installation zips under assests on the release section.


## No init.d Support Required
This module does not require init.d support for its operation.

## SWAP Creation Process
The creation process for the SWAP may take a minute or two to complete.

## Reboot
Once the installation is complete, reboot your device for the changes to take effect.

## Verify if SWAP is Enabled
To verify if the SWAP is enabled, follow these steps:
1. Download a terminal app
2. Switch to SU (Super User) mode
3. Type "htop" in the terminal app
4. If you see a value above 4GB, then the SWAP is successfully enabled

## Does Not touch ZRAM config
this module unlike others, does not touch the devices ZRAM config, rather runs along side.
if you run `cat /proc/swaps`, you will see 2.

## Best Results
For optimal results, open a few apps and keep them running for a few hours. The performance improvement is highly conditional.

The biggest difference i noticed in my case was battery life and less lag.

## Device Testing
This module has been tested on Lineage 20 with a device having 4GB RAM. With an additional 8GB SWAP, the device was capable of running more apps and it felt like having more than 4GB RAM. Additionally, improved battery performance was observed. The average memory usage dropped from 89% to 65% with over 30 apps in the recent apps list and using a bulky Gapps package with all the future flags set to true.

## Uninstallation
To uninstall the module, simply deactivate the module in Magisk and then reboot your device.

## Support
If you find this module useful, please consider starring the repository on GitHub:
[https://github.com/janithcooray/lin_os_swap_mod](https://github.com/janithcooray/lin_os_swap_mod)

## Contribution
Fork this repository, create a new branch (example - dev/feature-name) and commit your changes, test and verify if they are functional.
Once you confirm, please open a pull request from your forked branch to the source branch and assign @janithcooray to review. I'll be testing them manually before merging it.

## Issues
If you encounter any issues, please open an issue from GitHub at https://github.com/janithcooray/lin_os_swap_mod/issues/new i will try to patch them asap.

## Update
`2024-10-22` - Version `2.0` - Adding separate Prebuilt Configs on install + Bug fixes, Added Fail Safe option

`2023-10-15` - Version `1.3` - Increased Swappiness to fix usage issues

`2023-07-25` - Version `1.2` - Added Option to choose RAM Priority over ZRAM

`2023-07-22` - Version `1.1` - Updated SWAP Priority to auto and less then ZRAM
