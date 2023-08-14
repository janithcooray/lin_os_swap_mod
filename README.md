# Android 7+ Swapfile Mod

This Magisk module enables or increases the SWAP memory by an additional 4GB or 8GB for Android 7.0 or above. It should also work with AOSP based ROMs, but it has only been tested on Lineage OS, ASOP and EVOX.

## Installation Steps
1. Download the ZIP file for this module
2. Flash the ZIP file in Magisk v24 or above
3. During the installation, it will ask you to press the volume key for an interactive install
4. As soon as it prompts to press the volume key, do so

## Choose SWAP Size
- If the volume key is detected, you can choose between a 4GB or 8GB SWAP size
- If the volume key is not detected, the module will use a 4GB SWAP size by default

## Choose SWAP Priority
- If the volume key is detected, you can choose between the Highest or auto SWAP Priority
- If the volume key is not detected, the module will use auto SWAP Priority by default

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
once you confirm, please open a pull request from your forked branch to the source branch and assign @janithcooray to review. ill be testing them manually before merging it.

## Issues
if you encounter any issues, please open an issue from github at https://github.com/janithcooray/lin_os_swap_mod/issues/new i will try to patch them asap.

## Update

`2023-07-25` - Version `1.2` - Added Option to choose RAM Priority over ZRAM

`2023-07-22` - Version `1.1` - Updated SWAP Priority to auto and less then ZRAM
