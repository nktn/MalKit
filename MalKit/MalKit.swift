//
//  MalKit.swift
//  MalKit
//
//  Created by cuberoot on 2017/07/08.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation

//MalKit API Class
public class MalKit {
    let user_id: String
    let passwd: String
    let baseURLString: String
    var session: URLSession
    
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
        case TooManyLogin = 0
        func createError(userInfo: [String : AnyObject]? = nil) -> NSError {
            return NSError(domain: "malkit", code: self.rawValue, userInfo: userInfo)
        }
    }
    
    public init(user_id: String, passwd: String, baseURL:String = "https://myanimelist.net/api/") {
        self.user_id = user_id
        self.passwd = passwd
        self.baseURLString = baseURL
        self.session = URLSession.shared
    }
    
    public func verifyCredentials(_: Any, completionHandler: @escaping (Data?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask {
        return performGetRequest(MethodType.validatingLogin.rawValue, last_half: ".xml", params: nil, completionHandler: completionHandler)
    }
    
    public func searchAnime(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask {
        let params: [String : AnyObject] = ["q":query as AnyObject]
        return performGetRequest(MethodType.searchAnime.rawValue, last_half: ".xml", params: params, completionHandler: completionHandler)
    }
    
    public func searchManga(_ query: String, completionHandler: @escaping (Data?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask {
        let params: [String : AnyObject] = ["q":query as AnyObject]
        return performGetRequest(MethodType.searchManga.rawValue, last_half: ".xml" , params: params, completionHandler: completionHandler)
    }
    
    public func addAnime(_ id: String, query: String, completionHandler: @escaping (Bool?, HTTPURLResponse?, NSError?) -> Void) ->
        URLSessionDataTask {
            return performPostRequest(MethodType.addAnime.rawValue, last_half: id+".xml", params: query, completionHandler: completionHandler)
    }
    
    public func updateAnime(_ id: String, query: String, completionHandler: @escaping (Bool?, HTTPURLResponse?, NSError?) -> Void) ->
        URLSessionDataTask {
            return performPostRequest(MethodType.updateAnime.rawValue, last_half: id+".xml", params: query, completionHandler: completionHandler)
    }
    
    public func deleteAnime(_ id: String,  completionHandler: @escaping (Bool?, HTTPURLResponse?, NSError?) -> Void) ->
        URLSessionDataTask {
            return performPostRequest(MethodType.deleteAnime.rawValue, last_half: id+".xml", params: nil, completionHandler: completionHandler)
    }

    
    public func addManga(_ id: String, query: String, completionHandler: @escaping (Bool?, HTTPURLResponse?, NSError?) -> Void) ->
        URLSessionDataTask {
            return performPostRequest(MethodType.addManga.rawValue, last_half: id+".xml", params: query, completionHandler: completionHandler)
    }
    
    public func updateManga(_ id: String, query: String, completionHandler: @escaping (Bool?, HTTPURLResponse?, NSError?) -> Void) ->
        URLSessionDataTask {
            return performPostRequest(MethodType.updateManga.rawValue, last_half: id+".xml", params: query, completionHandler: completionHandler)
    }
    
    public func deleteManga(_ id: String, completionHandler: @escaping (Bool?, HTTPURLResponse?, NSError?) -> Void) ->
        URLSessionDataTask {
            return performPostRequest(MethodType.deleteManga.rawValue, last_half: id+".xml", params: nil, completionHandler: completionHandler)
    }
    

    //GET Only
    private func performGetRequest(_ first_half: String, last_half: String, params: [String: AnyObject]?, completionHandler: @escaping (Data?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask {
        var params = params
        
        var urlString = (self.baseURLString as NSString).appendingPathComponent(first_half+last_half)
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
        let config = URLSessionConfiguration.default
        let userPasswordString =  self.user_id+":"+self.passwd
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        self.session = URLSession(configuration: config)
        let dataTask = self.session.dataTask(with: URL(string: urlString)!){ data, response, error in
            
            if error != nil {
                completionHandler(nil, response as? HTTPURLResponse, error as NSError?)
                return
            }
            
            let res = response as? HTTPURLResponse
            if res?.statusCode == 403 {
                let errorWithUserInfo = LocalError.TooManyLogin.createError(userInfo: ["login_error" : "too many" as AnyObject])
                completionHandler(nil, response as? HTTPURLResponse, errorWithUserInfo as NSError)
                return
            }
            
            completionHandler(data, response as? HTTPURLResponse, nil)
        }
        dataTask.resume()
        return dataTask
    }
    
    //POST Only
    private func performPostRequest(_ first_half: String, last_half: String, params: String?, completionHandler: @escaping (Bool?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask {

        let urlString = (self.baseURLString as NSString).appendingPathComponent(first_half+last_half)
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        if params != nil {
            let param = "data=<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + params!
            let xmlData = param.data(using: String.Encoding.utf8)
            request.httpBody = xmlData
        }
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        let config = URLSessionConfiguration.default
        let userPasswordString =  self.user_id+":"+self.passwd
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        self.session = URLSession(configuration: config)
        let dataTask = self.session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completionHandler(nil,  response as? HTTPURLResponse, error as NSError?)
                return
            }
            if (first_half == MethodType.updateAnime.rawValue) || (first_half == MethodType.updateManga.rawValue) {
                if String(data: data!, encoding: .utf8) == "Updated" {
                    completionHandler(true, response as? HTTPURLResponse, nil)
                    return
                }else{
                    completionHandler(nil,  response as? HTTPURLResponse, error as NSError?)
                    return
                }
            }else if (first_half == MethodType.deleteAnime.rawValue) || (first_half == MethodType.deleteManga.rawValue) {
                if String(data: data!, encoding: .utf8) == "Deleted" {
                    completionHandler(true, response as? HTTPURLResponse, nil)
                    return
                }else{
                    completionHandler(nil,  response as? HTTPURLResponse, error as NSError?)
                    return
                }
            }else{
                //add
                if String(data: data!, encoding: .utf8) == "Created" {
                    completionHandler(true, response as? HTTPURLResponse, nil)
                    return
                }else{
                    completionHandler(nil,  response as? HTTPURLResponse, error as NSError?)
                    return
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
}
