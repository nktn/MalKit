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

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    _ = MalKit.sharedInstance.setUserData(user_id: "xxxxxx", passwd: "yyyyyy")
    return true
```
*You can setup other ViewController. 

### Search Sample(anime)
```Swift

_ = MalKit.sharedInstance.searchAnime("naruto", completionHandler: { (items, res, err) in
    //result is Data(XML)
    //your process
})
```

### add Sample(anime)
```Swift

_ = MalKit.sharedInstance.addAnime("20",query: "<entry><status>6</status></entry>", completionHandler: { (result, res, err) in
     //result is Bool
     //your process
})
```

### update Sample(anime)
```Swift
_ = MalKit.sharedInstance.updateAnime("20",query: "<entry><status>4</status></entry>", completionHandler: { (result, res, err) in
     //result is Bool
     //your process
})
```

### delte Sample(anime)
```Swift
_ = MalKit.sharedInstance.deleteAnime("20", completionHandler: { (result, res, err) in
      //result is Bool
     //your process
})
```

### Verify Credentials Sample
```Swift
_ = MalKit.sharedInstance.verifyCredentials(completionHandler: { (result, res, err) in
     //result is Data(XML)
    //your process
})
```

## Install
### write Podfile
```
pod 'MalKit'
pod install
```
## Licence
MIT

## Author

[nktn](https://github.com/nktn)
