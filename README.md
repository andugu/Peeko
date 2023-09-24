# Peeko
Peeko is a little version of [Peek-a-Boo](https://github.com/ioscreatix/peekaboo) by [iOSCreatix](https://github.com/ioscreatix/), but for jailed iOS devices.
It is able to bring 3D Touch support inside sideloaded apps for unsupported devices.

This tweak can be used with ++ tweaks too! Just use the .ipa created with ppsideloader in the process.

## Testes apps
* Instagram 8.2
`If you want to use Instagram++ with this, disable the "long hold to zoom image"`

## Installation Guide
### Requirements
- iOS device
- Apple Developer account or certificates
- XCode with iPhone SDK
- Decrypted ipa file of the app
- [optool](https://github.com/alexzielenski/optool/releases) (included in the project folder)
- [theos-jailed](https://codeload.github.com/BishopFox/theos-jailed/zip/master)
- [iOS App Signer](https://dantheman827.github.io/ios-app-signer/)

### Installation Steps
1. Uninstall the app from your iOS device.
2. Extract or download a decrypted ipa file of the app.
3. Create a symlink in the project folder named `theos` that points to the theos-jailed folder you downloaded:
   ```
   ln -s /path/to/theos-jailed/ theos
   ```
4. Open the file `Peeko.plist` and replace `BundleIdentifierHere` with the bundle identifier of the app you want to modify.
5. Open `tweak.xm` and customize the settings to your preference.
6. Run `make package`.
7. Run `./patchapp-2.sh info /path/to/your/file.ipa` and use XCode to create a Provisioning Profile based on the information obtained.
8. Choose one of the following methods:
   - Run `./patchapp-2.sh patch /path/to/app.ipa BUNDLE_ID` to inject the tweak into the .ipa (get the BUNDLE_ID from the info command).
   - Alternatively, run `./patchapp-1.sh patch /path/to/app.ipa /path/to/.mobileprovision`.
9. If you used the first method, install the .mobileprovision to the device. If you used the second method, resign the ipa file with iOS App Signer.
10. Install the ipa to your iOS device.
**Note:** It is recommended to resign the .ipa with iOS App Signer before every installation.

## Acknowledgments
- **iOSCreatix:** All credits for the main source code go to [iOSCreatix](https://github.com/ioscreatix/).
- **andugu (me):** For the necessary modifications to bring Peeko to Non-Jailbroken devices.
- **dado3212:** For implementing an alternative signing method.
- **Giovanni Di Grezia:** Whose [code](http://www.xgiovio.com/blog-photos-videos-other/blog/resign-your-ios-ipa-frameworks-and-plugins-included/) served as the foundation for the `patchapp-2.sh` revisions.
- **alexzielenski:** For `optool`.
- **BishopFox:** For `theos-jailed`.
