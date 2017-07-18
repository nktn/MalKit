//
//  MalKitGlobalVar.swift
//  MalKit
//
//  Created by nktn on 2017/07/14.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation

class MalKitGlobalVar{
    
    static let baseUrl = "https://myanimelist.net/api/"
    static let userId = "myanimelist_user_id"
    static let passwd = "myanimelist_passwd"
    static let isChecked = "is_checked"
    static let validatingLogin = "/account/verify_credentials"
    static let searchAnime = "anime/search"
    static let searchManga = "manga/search"
    static let addAnime = "animelist/add/"
    static let addManga = "mangalist/add/"
    static let updateAnime = "animelist/update/"
    static let updateManga = "mangalist/update/"
    static let deleteAnime = "animelist/delete/"
    static let deleteManga = "mangalist/delete/"
    
    enum LocalError: Int {
        case BASIC = 0
        case NoUserData = 1
        func createError(userInfo: [String : AnyObject]? = nil) -> Error {
            return NSError(domain: "malkit", code: self.rawValue, userInfo: userInfo)
        }
        func loginFailed() -> Error {
            return NSError(domain: "malkit", code: self.rawValue, userInfo: ["error":"login failed"])
        }
    }
    
    enum RequestType: Int {
        case Add = 0
        case Update = 1
    }
}
