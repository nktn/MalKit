//
//  MalKit.swift
//  MalKit
//
//  Created by nktn on 2017/07/08.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation

//MalKit API Class

public class MalKit {
    
    public static let sharedInstance = MalKit()
    var user_id: String = ""
    var passwd: String = ""
    let baseURLString: String = "https://myanimelist.net/api/"
    var session: URLSession
    
        
    private init() {
        self.session = URLSession.shared
    }
    
    public func setUserData(user_id: String, passwd: String){
        MalKeychainService.reset()
        MalKeychainService.set(user_id, forKey: "user_id")
        MalKeychainService.set(passwd, forKey: "passwd")
        MalKeychainService.set("0", forKey: "is_checked")
    }
    
    public func verifyCredentials(completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void {
         self.performGetRequest(MalKitGlobalVar.MethodType.validatingLogin.rawValue, last: ".xml", params: nil, completionHandler: completionHandler)
    }
    
    
    public func searchAnime(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let params: [String : AnyObject] = ["q":query as AnyObject]
                    self.performGetRequest(MalKitGlobalVar.MethodType.searchAnime.rawValue, last: ".xml", params: params, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
                }
            })
    }
    
    public func searchManga(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let params: [String : AnyObject] = ["q":query as AnyObject]
                    self.performGetRequest(MalKitGlobalVar.MethodType.searchManga.rawValue, last: ".xml" , params: params, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
                }
            })
    }
    
    public func addAnime(_ id: Int, episode: Int? = nil, status: Int, score: Int? = nil, storage_type: Int? = nil, storage_value: Float? = nil, times_rewatched: Int? = nil, rewatch_value: Int? = nil, date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rewatching: Int? = nil, comments: String? = nil, tags: String? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void {
        self.checkIdPwd(completionHandler: { (data) in
            if data {
                let query = MalKitMakeQuery.makeAnimeQuerty(query: [episode, status, score, storage_type, storage_value, times_rewatched, rewatch_value, date_start, date_finish, priority, enable_discussion, enable_rewatching, comments, tags], type: MalKitGlobalVar.RequestType.Add.rawValue)
                self.performPostRequest(MalKitGlobalVar.MethodType.addAnime.rawValue, last: String(id)+".xml", params: query, completionHandler: completionHandler)
            }else{
                completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
            }
        })
    }

    public func updateAnime(_ id: Int, episode: Int? = nil, status: Int? = nil, score: Int? = nil, storage_type: Int? = nil, storage_value: Float? = nil, times_rewatched: Int? = nil, rewatch_value: Int? = nil, date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rewatching: Int? = nil, comments: String? = nil, tags: String? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitMakeQuery.makeAnimeQuerty(query: [episode, status, score, storage_type, storage_value, times_rewatched, rewatch_value, date_start, date_finish, priority, enable_discussion, enable_rewatching, comments, tags], type: MalKitGlobalVar.RequestType.Update.rawValue)
                    self.performPostRequest(MalKitGlobalVar.MethodType.updateAnime.rawValue, last: String(id)+".xml", params: query, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
                }
            })
    }
    
    public func deleteAnime(_ id: Int,  completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) ->
        Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    self.performPostRequest(MalKitGlobalVar.MethodType.deleteAnime.rawValue, last: String(id)+".xml", params: nil, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
                }
            })
    }
    
    
    public func addManga(_ id: Int, chapter: Int? = nil, volume: Int? = nil, status: Int, score: Int? = nil, times_reread: Int? = nil, reread_value: Int? = nil ,date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rereading: Int? = nil, comments: String? = nil, scan_group:String? = nil, tags: String? = nil, retail_volumes: Int? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void{
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitMakeQuery.makeMangaQuerty(query: [chapter, volume, status, score, times_reread, reread_value, date_start, date_finish, priority, enable_discussion, enable_rereading, comments, scan_group, tags, retail_volumes], type: MalKitGlobalVar.RequestType.Add.rawValue)
                    self.performPostRequest(MalKitGlobalVar.MethodType.addManga.rawValue, last: String(id)+".xml", params: query, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
                }
        })
    }
    
    public func updateManga(_ id: Int, chapter: Int? = nil, volume: Int? = nil, status: Int?, score: Int? = nil, times_reread: Int? = nil, reread_value: Int? = nil ,date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rereading: Int? = nil, comments: String? = nil, scan_group:String? = nil, tags: String? = nil, retail_volumes: Int? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitMakeQuery.makeMangaQuerty(query: [chapter, volume, status, score, times_reread, reread_value, date_start, date_finish, priority, enable_discussion, enable_rereading, comments, scan_group, tags, retail_volumes], type: MalKitGlobalVar.RequestType.Update.rawValue)
                    self.performPostRequest(MalKitGlobalVar.MethodType.updateManga.rawValue, last: String(id)+".xml", params: query, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
                }
        })
    }
    
    public func deleteManga(_ id: Int, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) ->
        Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    self.performPostRequest(MalKitGlobalVar.MethodType.deleteManga.rawValue, last: String(id)+".xml", params: nil, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.LoginError.loginFailed())
                }
            })
    }

    private func makeConfiguration() -> URLSessionConfiguration{
        let config = URLSessionConfiguration.default
        self.user_id = MalKeychainService.value(forKey: "user_id") ?? ""
        self.passwd = MalKeychainService.value(forKey: "passwd") ?? ""
        let userPasswordString =  self.user_id+":"+self.passwd
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        return config
    }
    
    //GET Only
    @discardableResult
    private func performGetRequest(_ first: String, last: String, params: [String: AnyObject]?, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var params = params
        var urlString = (self.baseURLString as NSString).appendingPathComponent(first+last)
        if params == nil {
            params = [:]
        }
        urlString += "?"
        var i = 0
        for (k, v) in params! {
            urlString += k.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            urlString += "="
            urlString += "\(v)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            if (i != params!.count - 1) {
                urlString += "&"
            }
            i += 1
        }
        let config = makeConfiguration()
        self.session = URLSession(configuration: config)
        let dataTask = self.session.dataTask(with: URL(string: urlString)!){ data, response, error in
            if error != nil {
                completionHandler(nil, response as? HTTPURLResponse, error)
                return
            }
            let res = response as? HTTPURLResponse
            if res?.statusCode != 200 {
                let errorWithUserInfo = MalKitGlobalVar.LocalError.LoginError.createError(userInfo: ["login_error" : String(data: data!, encoding: .utf8) as AnyObject])
                completionHandler(nil, response as? HTTPURLResponse, errorWithUserInfo as Error)
                return
            }
            
            completionHandler(data, response as? HTTPURLResponse, error)
        }
        dataTask.resume()
        return dataTask
    }
    
    //POST Only
    @discardableResult
    private func performPostRequest(_ first: String, last: String, params: String?, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let urlString = (self.baseURLString as NSString).appendingPathComponent(first+last)
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        if params != nil {
            let param = "data=<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + params!
            let xmlData = param.data(using: String.Encoding.utf8)
            request.httpBody = xmlData
        }
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        let config = makeConfiguration()
        self.session = URLSession(configuration: config)
        let dataTask = self.session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completionHandler(nil,  response as? HTTPURLResponse, error as Error?)
                return
            }
            
            if (first == MalKitGlobalVar.MethodType.updateAnime.rawValue) || (first == MalKitGlobalVar.MethodType.updateManga.rawValue) {
                if String(data: data!, encoding: .utf8) == "Updated" {
                    completionHandler(true, response as? HTTPURLResponse, error)
                    return
                }else{
                    completionHandler(false,  response as? HTTPURLResponse, error)
                    return
                }
            }else if (first == MalKitGlobalVar.MethodType.deleteAnime.rawValue) || (first == MalKitGlobalVar.MethodType.deleteManga.rawValue) {
                if String(data: data!, encoding: .utf8) == "Deleted" {
                    completionHandler(true, response as? HTTPURLResponse, error)
                    return
                }else{
                    completionHandler(false,  response as? HTTPURLResponse, error)
                    return
                }
            }else{
                //add
                if String(data: data!, encoding: .utf8) == "Created" {
                    completionHandler(true, response as? HTTPURLResponse, error)
                    return
                }else{
                    completionHandler(false,  response as? HTTPURLResponse, error)
                    return
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    //UserCheck
    private func checkIdPwd(completionHandler: @escaping (Bool) -> Void) -> Void{
        if MalKeychainService.value(forKey: "is_checked") == "0" {
            self.verifyCredentials { (data, response, error) in
                if (error != nil) {
                    completionHandler(false)
                }else if (response?.statusCode == 204){
                    completionHandler(false)
                }else{
                    MalKeychainService.removeValue(forKey: "is_checked")
                    MalKeychainService.set("1", forKey: "is_checked")
                    completionHandler(true)
                }
            }
        }else{
            completionHandler(true)
        }
    }
}
