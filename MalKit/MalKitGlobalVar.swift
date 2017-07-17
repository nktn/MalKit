//
//  MalKitGlobalVar.swift
//  MalKit
//
//  Created by nktn on 2017/07/14.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation

class MalKitGlobalVar{
    enum MethodType: String{
        case validatingLogin = "/account/verify_credentials"
        case searchAnime = "anime/search"
        case searchManga = "manga/search"
        case addAnime = "animelist/add/"
        case addManga = "mangalist/add/"
        case updateAnime = "animelist/update/"
        case updateManga = "mangalist/update/"
        case deleteAnime = "animelist/delete/"
        case deleteManga = "mangalist/delete/"
    }
    
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
