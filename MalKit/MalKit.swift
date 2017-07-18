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
    
    //Singleton
    public static let sharedInstance = MalKit()
    
    var userId: String = ""
    var passwd: String = ""
    let baseUrlString: String = MalKitGlobalVar.baseUrl
    var session: URLSession = URLSession.shared
    
    private init() {}
    
    //Set MyAnimeListUser_id and passwd
    public func setUserData(user_id: String, passwd: String) -> Bool{
        if user_id != "" && passwd != "" {
            MalKitKeychainService.reset()
            MalKitKeychainService.set(user_id, forKey: MalKitGlobalVar.userId)
            MalKitKeychainService.set(passwd, forKey: MalKitGlobalVar.passwd)
            MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
            return true
        }else{
            return false
        }
    }
    
    //Verify Credentials API
    public func verifyCredentials(completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void {
         self.performGetRequest(MalKitGlobalVar.validatingLogin, params: nil, completionHandler: completionHandler)
    }
    
    //Anime Search
    public func searchAnime(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let params: [String : AnyObject] = ["q":query as AnyObject]
                    self.performGetRequest(MalKitGlobalVar.searchAnime, params: params, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    
    //Manga Search
    public func searchManga(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let params: [String : AnyObject] = ["q":query as AnyObject]
                    self.performGetRequest(MalKitGlobalVar.searchManga, params: params, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    
    //Add Anime API
    public func addAnime(_ id: Int, episode: Int? = nil, status: Int, score: Int? = nil, storage_type: Int? = nil, storage_value: Float? = nil, times_rewatched: Int? = nil, rewatch_value: Int? = nil, date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rewatching: Int? = nil, comments: String? = nil, tags: String? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void {
        self.checkIdPwd(completionHandler: { (data) in
            if data {
                let query = MalKitMakeQuery.makeAnimeQuerty(query: [episode, status, score, storage_type, storage_value, times_rewatched, rewatch_value, date_start, date_finish, priority, enable_discussion, enable_rewatching, comments, tags], type: MalKitGlobalVar.RequestType.Add.rawValue)
                self.performPostRequest(MalKitGlobalVar.addAnime, id: String(id), params: query, completionHandler: completionHandler)
            }else{
                completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
            }
        })
    }

    //Update Anime API
    public func updateAnime(_ id: Int, episode: Int? = nil, status: Int? = nil, score: Int? = nil, storage_type: Int? = nil, storage_value: Float? = nil, times_rewatched: Int? = nil, rewatch_value: Int? = nil, date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rewatching: Int? = nil, comments: String? = nil, tags: String? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitMakeQuery.makeAnimeQuerty(query: [episode, status, score, storage_type, storage_value, times_rewatched, rewatch_value, date_start, date_finish, priority, enable_discussion, enable_rewatching, comments, tags], type: MalKitGlobalVar.RequestType.Update.rawValue)
                    self.performPostRequest(MalKitGlobalVar.updateAnime, id: String(id), params: query, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    
    //Delete Anime API
    public func deleteAnime(_ id: Int,  completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) ->
        Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    self.performPostRequest(MalKitGlobalVar.deleteAnime, id: String(id), params: nil, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    
    //Add Manga
    public func addManga(_ id: Int, chapter: Int? = nil, volume: Int? = nil, status: Int, score: Int? = nil, times_reread: Int? = nil, reread_value: Int? = nil ,date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rereading: Int? = nil, comments: String? = nil, scan_group:String? = nil, tags: String? = nil, retail_volumes: Int? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void{
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitMakeQuery.makeMangaQuerty(query: [chapter, volume, status, score, times_reread, reread_value, date_start, date_finish, priority, enable_discussion, enable_rereading, comments, scan_group, tags, retail_volumes], type: MalKitGlobalVar.RequestType.Add.rawValue)
                    self.performPostRequest(MalKitGlobalVar.addManga, id: String(id), params: query, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
        })
    }
    
    //Update Manga
    public func updateManga(_ id: Int, chapter: Int? = nil, volume: Int? = nil, status: Int?, score: Int? = nil, times_reread: Int? = nil, reread_value: Int? = nil ,date_start: Date? = nil, date_finish: Date? = nil, priority: Int? = nil, enable_discussion: Int? = nil, enable_rereading: Int? = nil, comments: String? = nil, scan_group:String? = nil, tags: String? = nil, retail_volumes: Int? = nil, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitMakeQuery.makeMangaQuerty(query: [chapter, volume, status, score, times_reread, reread_value, date_start, date_finish, priority, enable_discussion, enable_rereading, comments, scan_group, tags, retail_volumes], type: MalKitGlobalVar.RequestType.Update.rawValue)
                    self.performPostRequest(MalKitGlobalVar.updateManga, id: String(id), params: query, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
        })
    }
    
    //Delete Manga
    public func deleteManga(_ id: Int, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) ->
        Void {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    self.performPostRequest(MalKitGlobalVar.deleteManga, id: String(id), params: nil, completionHandler: completionHandler)
                }else{
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }

    private func makeConfiguration() -> URLSessionConfiguration{
        let config = URLSessionConfiguration.default
        self.userId = MalKitKeychainService.value(forKey: MalKitGlobalVar.userId) ?? ""
        self.passwd = MalKitKeychainService.value(forKey: MalKitGlobalVar.passwd) ?? ""
        let userPasswordString =  self.userId+":"+self.passwd
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        return config
    }
    
    //GET Only
    @discardableResult
    private func performGetRequest(_ first: String, params: [String: AnyObject]?, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var params = params
        var urlString = (self.baseUrlString as NSString).appendingPathComponent(first+".xml")
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
                MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
                completionHandler(nil, response as? HTTPURLResponse, error)
                return
            }
            let res = response as? HTTPURLResponse
            if res?.statusCode == 204 {
                completionHandler(nil, response as? HTTPURLResponse, error)
                return
            }else if res?.statusCode != 200 {
                let errorWithUserInfo = MalKitGlobalVar.LocalError.BASIC.createError(userInfo: ["error" : String(data: data!, encoding: .utf8) as AnyObject])
                completionHandler(nil, response as? HTTPURLResponse, errorWithUserInfo as Error)
                return
            }
            completionHandler(data, response as? HTTPURLResponse, error)
            return
        }
        dataTask.resume()
        return dataTask
    }
    
    //POST Only
    @discardableResult
    private func performPostRequest(_ method_type: String, id: String, params: String?, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let urlString = (self.baseUrlString as NSString).appendingPathComponent(method_type+id+".xml")
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
                MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
                completionHandler(nil,  response as? HTTPURLResponse, error as Error?)
                return
            }
            if data != nil{
                if (method_type == MalKitGlobalVar.updateAnime) || (method_type == MalKitGlobalVar.updateManga) {
                    if String(data: data!, encoding: .utf8) == "Updated" {
                        completionHandler(true, response as? HTTPURLResponse, error)
                        return
                    }else{
                        completionHandler(false,  response as? HTTPURLResponse, error)
                        return
                    }
                }else if (method_type == MalKitGlobalVar.deleteAnime) || (method_type == MalKitGlobalVar.deleteManga) {
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
            }else{
                completionHandler(false,  response as? HTTPURLResponse, error)
                return
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    //UserCheck
    private func checkIdPwd(completionHandler: @escaping (Bool) -> Void) -> Void{
        if MalKitKeychainService.value(forKey: MalKitGlobalVar.isChecked) == "0" {
            self.verifyCredentials { (data, response, error) in
                if (error != nil) {
                    MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
                    completionHandler(false)
                }else if (response?.statusCode == 204){
                    MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
                    completionHandler(false)
                }else{
                    MalKitKeychainService.set("1", forKey: MalKitGlobalVar.isChecked)
                    completionHandler(true)
                }
            }
        }else{
            completionHandler(true)
        }
    }
}
