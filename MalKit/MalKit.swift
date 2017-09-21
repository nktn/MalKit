//
//  MalKit.swift
//  MalKit
//
//  Created by nktn on 2017/07/08.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation


public class MalKit {
    private var userId: String?
    private var passwd: String?
    private let baseUrlString: String = MalKitGlobalVar.baseUrl
    private var session: URLSession = URLSession.shared
    public init() {}
    //MARK: - Set MyAnimeListUser_id and passwd
    public func setUserData(userId: String, passwd: String) {
        MalKitKeychainService.reset()
        MalKitKeychainService.set(userId, forKey: MalKitGlobalVar.userId)
        MalKitKeychainService.set(passwd, forKey: MalKitGlobalVar.passwd)
        MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
    }
    //MARK: - Verify Credentials API
    public func verifyCredentials(completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
         self.performGetRequest(MalKitGlobalVar.validatingLogin, params: nil, completionHandler: completionHandler)
    }
    //MARK: - Anime Search
    public func searchAnime(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let params: [String : AnyObject] = ["q": query as AnyObject]
                    self.performGetRequest(
                        MalKitGlobalVar.searchAnime, params: params,
                        completionHandler: completionHandler
                    )
                } else {
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    //MARK: - Manga Search
    public func searchManga(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let params: [String : AnyObject] = ["q": query as AnyObject]
                    self.performGetRequest(
                        MalKitGlobalVar.searchManga, params: params,
                        completionHandler: completionHandler
                    )
                } else {
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    //MARK: - Add Anime API
    public func addAnime(_ animeId: Int, params: Dictionary<String, Any>, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) {
        self.checkIdPwd(completionHandler: { (data) in
            if data {
                let query = MalKitUtil().makeAnimeQuerty(params: params, type: MalKitGlobalVar.requestAdd)
                self.performPostRequest(MalKitGlobalVar.addAnime, id: String(animeId), params: query, completionHandler: completionHandler)
            } else {
                completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
            }
        })
    }
    //MARK: - Update Anime API
    public func updateAnime(_ animeId: Int, params: Dictionary<String, Any>, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitUtil().makeAnimeQuerty(params: params, type: MalKitGlobalVar.requestUpdate)
                    self.performPostRequest(
                        MalKitGlobalVar.updateAnime, id: String(animeId), params: query,
                        completionHandler: completionHandler
                    )
                } else {
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    //MARK: - Delete Anime API
    public func deleteAnime(_ animeId: Int, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    self.performPostRequest(
                        MalKitGlobalVar.deleteAnime, id: String(animeId), params: nil,
                        completionHandler: completionHandler
                    )
                } else {
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    
    //MARK: - Add Manga
    public func addManga(_ mangaId: Int, params: Dictionary<String, Any>, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitUtil().makeMangaQuerty(params: params, type: MalKitGlobalVar.requestAdd)
                    self.performPostRequest(MalKitGlobalVar.addManga, id: String(mangaId), params: query, completionHandler: completionHandler)
                } else {
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
        })
    }
    //MARK: - Update Manga
    public func updateManga(_ mangaId: Int, params: Dictionary<String, Any>, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    let query = MalKitUtil().makeMangaQuerty(params: params, type: MalKitGlobalVar.requestUpdate)
                        self.performPostRequest(
                            MalKitGlobalVar.updateManga, id: String(mangaId), params: query,
                            completionHandler: completionHandler
                        )
                } else {
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
        })
    }
    //MARK: - Delete Manga
    public func deleteManga(_ mangaId: Int, completionHandler: @escaping (Bool?, HTTPURLResponse?, Error?) -> Void) {
            self.checkIdPwd(completionHandler: { (data) in
                if data {
                    self.performPostRequest(
                        MalKitGlobalVar.deleteManga, id: String(mangaId), params: nil,
                        completionHandler: completionHandler
                    )
                } else {
                    completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
                }
            })
    }
    //MARK: - User Anime
    public func userAnimeList(completionHandler:  @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        self.checkIdPwd(completionHandler: { (data) in
            if data {
                self.performUserRequest(MalKitGlobalVar.userAnime, completionHandler: completionHandler)
            }else{
                 completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
            }
        })
    }
    //MARK: - User Manga
    public func userMangaList(completionHandler:  @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        self.checkIdPwd(completionHandler: { (data) in
            if data {
                self.performUserRequest(MalKitGlobalVar.userManga, completionHandler: completionHandler)
            }else{
                completionHandler(nil, nil, MalKitGlobalVar.LocalError.BASIC.loginFailed())
            }
        })
    }
    //MARK: - make config
    private func makeConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        self.userId = MalKitKeychainService.value(forKey: MalKitGlobalVar.userId) ?? ""
        self.passwd = MalKitKeychainService.value(forKey: MalKitGlobalVar.passwd) ?? ""
        let userPasswordString =  self.userId!+":"+self.passwd!
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(
            options: Data.Base64EncodingOptions.init(rawValue: 0)
        )
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization": authString]
        return config
    }
    //MARK: - GET Only
    @discardableResult
    private func performGetRequest(_ method_type: String, params: [String: AnyObject]?,
                                   completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) ->
                                    Void) -> URLSessionDataTask {
        var params = params
        var urlString = (self.baseUrlString as NSString).appendingPathComponent(method_type+".xml")
        if params == nil {
            params = [:]
        }
        urlString += "?"
        var i = 0
        for (k, v) in params! {
            urlString += k.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            urlString += "="
            urlString += "\(v)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            if i != (params!.count - 1) {
                urlString += "&"
            }
            i += 1
        }
        let config = makeConfiguration()
        self.session = URLSession(configuration: config)
        let dataTask = self.session.dataTask(with: URL(string: urlString)!) { data, response, error in
            if error != nil {
                MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
                completionHandler(nil, response as? HTTPURLResponse, error)
                return
            }
            let res = response as? HTTPURLResponse
            if res?.statusCode == 204 {
                completionHandler(nil, response as? HTTPURLResponse, error)
                return
            } else if res?.statusCode != 200 {
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
    //MARK: - POST Only
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
                completionHandler(nil, response as? HTTPURLResponse, error as Error?)
                return
            }
            if data != nil {
                if (method_type == MalKitGlobalVar.updateAnime) || (method_type == MalKitGlobalVar.updateManga) {
                    if String(data: data!, encoding: .utf8) == "Updated" {
                        completionHandler(true, response as? HTTPURLResponse, error)
                        return
                    } else {
                        completionHandler(false,  response as? HTTPURLResponse, error)
                        return
                    }
                } else if (method_type == MalKitGlobalVar.deleteAnime) || (method_type == MalKitGlobalVar.deleteManga) {
                    if String(data: data!, encoding: .utf8) == "Deleted" {
                        completionHandler(true, response as? HTTPURLResponse, error)
                        return
                    } else {
                        completionHandler(false,  response as? HTTPURLResponse, error)
                        return
                    }
                } else {
                    //add
                    if String(data: data!, encoding: .utf8) == "Created" {
                        completionHandler(true, response as? HTTPURLResponse, error)
                        return
                    } else {
                        completionHandler(false,  response as? HTTPURLResponse, error)
                        return
                    }
                }
            } else {
                completionHandler(false, response as? HTTPURLResponse, error)
                return
            }
        }
        dataTask.resume()
        return dataTask
    }
    //MARK: - User Anime/Manga
    @discardableResult
    private func performUserRequest(_ url: String, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) ->
        Void) -> URLSessionDataTask {
        let urlString = url + self.userId!
        let config = makeConfiguration()
        self.session = URLSession(configuration: config)
        let dataTask = self.session.dataTask(with: URL(string: urlString)!) { data, response, error in
            if error != nil {
                completionHandler(nil, response as? HTTPURLResponse, error)
                return
            }
            let res = response as? HTTPURLResponse
                if res?.statusCode != 200 {
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
    //MARK: - UserCheck
    private func checkIdPwd(completionHandler: @escaping (Bool) -> Void) {
        if MalKitKeychainService.value(forKey: MalKitGlobalVar.isChecked) == "0" {
            self.verifyCredentials { (data, response, error) in
                if error != nil {
                    MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
                    completionHandler(false)
                } else if response?.statusCode == 204 {
                    MalKitKeychainService.set("0", forKey: MalKitGlobalVar.isChecked)
                    completionHandler(false)
                } else {
                    MalKitKeychainService.set("1", forKey: MalKitGlobalVar.isChecked)
                    completionHandler(true)
                }
            }
        } else {
            completionHandler(true)
        }
    }
}
