[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](http://img.shields.io/cocoapods/v/MalKit.svg?style=flat)](http://cocoadocs.org/docsets/MalKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/MalKit.svg?style=flat)](http://cocoadocs.org/docsets/MalKit/)
[![Pod License](http://img.shields.io/cocoapods/l/MalKit.svg?style=flat)](https://github.com/nktn/MalKit/blob/master/LICENSE)
![Swift version](https://img.shields.io/badge/swift-4.0-orange.svg)
# MalKit
====

## Description
Swift API Client for MyAnimeList(official API)

https://myanimelist.net/modules.php?go=api

## Requirement
Xcode9.0〜(Swift4)

## Usage

### Initialize 
```Swift

import MalKit
let malkit = MalKit()
```

### Setup(MyAnimeList account for request API)
```Swift

malkit.setUserData(userId: "xxxxxx", passwd: "yyyyyy")
```

### Search Sample
```Swift

malkit.searchAnime("naruto", completionHandler: { (items, status, err) in
    //result is Data(XML). You need to parse XML.
    //status is HTTPURLResponse
    //your process
})
```

```Swift

malkit.searchManga("naruto", completionHandler: { (items, status, err) in
    //result is Data(XML). You need to parse XML.
    //status is HTTPURLResponse
    //your process
})
```

## Add or Update anime/manga on your list. For additional Anime parameters, please refer [here](https://myanimelist.net/modules.php?go=api#animevalues). For Manga, please refer [here](https://myanimelist.net/modules.php?go=api#mangavalues).


### add Sample
```Swift

malkit.addAnime(20, params:["status": 1], completionHandler: { (result, status, err) in
     //20 is anime_id
     //result is Bool
     //status is HTTPURLResponse
     //your process
})
```

```Swift

malkit.addManga(20, params:["status": 1], completionHandler: { (result, status, err) in
     //20 is manga_id
     //result is Bool
     //status is HTTPURLResponse
     //your process
})
```

### update Sample
```Swift

malkit.updateAnime(20, params:["status": 0, "comments": "test"], completionHandler: { (result, status, err) in
     //20 is anime_id
     //result is Bool
     //status is HTTPURLResponse
     //your process
})
```

```Swift

malkit.updateManga(20, params:["status": 0, "comments": "test"], completionHandler: { (result, status, err) in
     //20 is manga_id
     //result is Bool
     //status is HTTPURLResponse
     //your process
})
```


### delete Sample
```Swift

malkit.deleteAnime(20, completionHandler: { (result, status, err) in
      //20 is anime_id
      //result is Bool
      //status is HTTPURLResponse
      //your process
})
```

```Swift

malkit.deleteManga(20, completionHandler: { (result, status, err) in
      //20 is manga_id
      //result is Bool
      //status is HTTPURLResponse
     //your process
})
```

### Verify Credentials Sample
```Swift

malkit.verifyCredentials(completionHandler: { (result, status, err) in
     //Check for MalKit().setUserData
     //result is Data(XML). You need to parse XML.
     //status is HTTPURLResponse
     //your process
})
```

### Get User Anime or Manga List Data(This is not API)
```Swift

malkit.userAnimeList { (result, http_status, err) in
     //Check for MalKit().setUserData
     //result is Data(XML). You need to parse XML.
     //status is HTTPURLResponse
     //your process
})
```

```Swift

malkit.userMangaList { (result, http_status, err) in
     //Check for MalKit().setUserData
     //result is Data(XML). You need to parse XML.
     //status is HTTPURLResponse
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
