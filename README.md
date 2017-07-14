[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](http://img.shields.io/cocoapods/v/MalKit.svg?style=flat)](http://cocoadocs.org/docsets/MalKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/MalKit.svg?style=flat)](http://cocoadocs.org/docsets/MalKit/)
[![Pod License](http://img.shields.io/cocoapods/l/MalKit.svg?style=flat)](https://github.com/nktn/MalKit/blob/master/LICENSE)
![Swift version](https://img.shields.io/badge/swift-3.0-orange.svg)
# MalKit
====

## Description
Swift API Client for MyAnimeList(official API)

## Requirement
Xcode8.3.X(Swift3)

## Usage
### Setup(MyAnimeList account for request API)
```Swift

// AppDelegate.swift
import MalKit

MalKit.sharedInstance.setUserData(user_id: "xxxxxx", passwd: "yyyyyy")
```
*You can setup other ViewController.

### Search Sample(anime)
```Swift

MalKit.sharedInstance.searchAnime("naruto", completionHandler: { (items, res, err) in
    //result is Data(XML). You need to parse XML.
    //your process
})
```

### add Sample(anime)
```Swift

MalKit.sharedInstance.addAnime(20, status: 2, completionHandler: { (result, res, err) in
     //result is Bool
     //your process
})
```

### update Sample(anime)
```Swift
MalKit.sharedInstance.updateAnime(20, status: 0, comments:"test", completionHandler: { (result, res, err) in
     //result is Bool
     //your process
})
```

### delete Sample(anime)
```Swift
MalKit.sharedInstance.deleteAnime(20, completionHandler: { (result, res, err) in
      //result is Bool
     //your process
})
```

### Verify Credentials Sample
```Swift
MalKit.sharedInstance.verifyCredentials(completionHandler: { (result, res, err) in
     //result is Data(XML). You need to parse XML.
    //your process
})
```

## Install
### [Carthage](https://github.com/Carthage/Carthage)

#### Cartfile
```
github "nktn/MalKit"
```
`carthage update`

### [CocoaPods](https://github.com/cocoapods/cocoapods)

#### Podfile
```
pod 'MalKit'
```
`pod install`

## Licence
MIT

## Author

[nktn](https://github.com/nktn)
