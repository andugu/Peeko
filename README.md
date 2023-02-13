# Peeko: a little version of [Peek-a-Boo](https://github.com/ioscreatix/peekaboo) by [iOSCreatix](https://github.com/ioscreatix/), for jailed idevices.

iOS Tweak for non-jailbroken devices that brings 3D Touch support inside apps.

You can contact me through Reddit as [u/andugu](https://www.reddit.com/user/andugu) or in Twitter as [@anduguuu](https://twitter.com/anduguuu)

All the credits for the main source code goes to [iOSCreatix](https://github.com/ioscreatix/).

This tweak can be used with ++ tweaks too! Just use the .ipa created with ppsideloader in the process.

### Thanks to
* [iOSCreatix](https://github.com/ioscreatix/) for the main source code from Peek-a-Boo.
* [andugu](https://github.com/andugu) (me) for the needed modifications.
* [dado3212](https://github.com/dado3212) for the implementation of an alternative signing method.
* Giovanni Di Grezia, whose [code](http://www.xgiovio.com/blog-photos-videos-other/blog/resign-your-ios-ipa-frameworks-and-plugins-included/) served as the basis for the patchapp-2.sh revisions made by dado3212.
* [alexzielenski](https://github.com/alexzielenski) for optool.
* [BishopFox](https://github.com/BishopFox) for theos-jailed.

### Testes apps
* Instagram 8.2
`If you want to use Instagram++ with this, disable the "long hold to zoom image"`

How to install
============

### Requirements

* iOS device
* Apple Developer account or certificates
* XCode with iPhone SDK
* Decrypted ipa file of the app
* [optool](https://github.com/alexzielenski/optool/releases) (included on the project folder).
* [theos-jailed](https://codeload.github.com/BishopFox/theos-jailed/zip/master)
* [iOS App Signer](https://dantheman827.github.io/ios-app-signer/)

### DIY

* Uninstall the app from the iOS device.
* Extract or download an decrypted ipa file of the app.
* Place an symlink in the project folder named `theos` pointing to the theos-jailed folder you downloaded: `ln -s /path/to/theos-jailed/ theos`
* Open the file `Peeko.plist` and remplace `BundleIdentifierHere` with the bundle identifier of the app you want to modify.
* Open `tweak.xm` and edit the settings as you want.
* Run `make package`
* Run `./patchapp-2.sh info /path/to/your/file.ipa`
* Take the information from that and use XCode to create a Provisioning Profile.
* Here we have two different methods, choose the one that works for you!
* 1) Run `./patchapp-2.sh patch /path/to/app.ipa BUNDLE_ID` to inject the tweak into the .ipa (get the BUNDLE_ID from the info command).
* 2) Or run `./patchapp-1.sh patch /path/to/app.ipa /path/to/.mobileprovision`
* If you used the first method install the .mobileprovision to the device, and if you used the second one you should resign the ipa file with iOS App Signer.
* Install the ipa to the device.

Note: I recomend to resign again the .ipa with iOS App Signer allways before installing it.
