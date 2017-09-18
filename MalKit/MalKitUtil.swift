//
//  MalKitUtil.swift
//  MalKit
//
//  Created by nktn on 2017/08/14.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation

class MalKitUtil {
    var minValueS: Int
    var maxValueS: Int
    var minValueE: Int
    var maxValueE: Int
    init(){
        //1/reading, 2/completed, 3/onhold, 4/dropped, 6/plantoread
        minValueS = 1
        maxValueS = 6
        //int. 1=enable, 0=disable
        minValueE = 0
        maxValueE = 1
    }
    //MARK: - dateparamseter from https://myanimelist.net/modules.php?go=api
    private func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMddyyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    //MARK: - Add and Update Anime Query
    func makeAnimeQuerty(params: Dictionary<String, Any>, type: Int) -> String? {
        let query :Array<Any?> = parseAnimeParam(params:params)
        var str = "<entry>"
        if query[0] as? Int != nil {
            str += "<episode>"
            str += String(query[0] as! Int)
            str += "</episode>"
        }
        if type == MalKitGlobalVar.requestUpdate {
            if query[1] as? Int != nil {
                str += "<status>"
                str += String(min(max(query[1] as! Int, minValueS), maxValueS))
                str += "</status>"
            }
        } else {
            if query[1] as? Int != nil {
                str += "<status>"
                str += String(min(max(query[1] as! Int, minValueS), maxValueS))
                str += "</status>"
            }
        }
        if query[2] as? Int != nil {
            str += "<score>"
            str += String(query[2] as! Int)
            str += "</score>"
        }
        if query[3] as? Int != nil {
            str += "<storage_type>"
            str += String(query[3] as! Int)
            str += "</storage_type>"
        }
        if query[4] as? Float != nil {
            str += "<storage_value>"
            str += String(query[4] as! Float)
            str += "</storage_value>"
        }
        if query[5] as? Int != nil {
            str += "<times_rewatched>"
            str += String(query[5] as! Int)
            str += "</times_rewatched>"
        }
        if query[6] as? Int != nil {
            str += "<rewatch_value>"
            str += String(query[6] as! Int)
            str += "</rewatch_value>"
        }
        if query[7] as? Date != nil{
            str += "<date_start>"
            str += self.dateString(date: query[7] as! Date)
            str += "</date_start>"
        } else if query[7] as? String == "" {
            str += "<date_start>"
            str += "</date_start>"
        }
        if query[8] as? Date != nil{
            str += "<date_finish>"
            str += self.dateString(date: query[8] as! Date)
            str += "</date_finish>"
        }  else if query[8] as? String == "" {
            str += "<date_finish>"
            str += "</date_finish>"
        }

        if query[9] as? Int != nil {
            str += "<priority>"
            str += String(query[9] as! Int)
            str += "</priority>"
        }
        if query[10] as? Int != nil {
            str += "<enable_discussion>"
            str += String(min(max(query[10] as! Int, minValueE), maxValueE))
            str += "</enable_discussion>"
        }
        if query[11] as? Int != nil {
            str += "<enable_rewatching>"
            str += String(min(max(query[11] as! Int, minValueE), maxValueE))
            str += "</enable_rewatching>"
        }
        if query[12] as? String != nil {
            str += "<comments>"
            str += query[12] as! String
            str += "</comments>"
        }
        if query[13] as? String != nil {
            str += "<tags>"
            str += query[13] as! String
            str += "</tags>"
        }
        str += "</entry>"
        return str
    }
    //MARK: - Add and Update Manga Query
    func makeMangaQuerty(params: Dictionary<String, Any>, type: Int) -> String? {
        let query :Array<Any?> = parseMangaParam(params:params)
        //let query_check = query.flatMap{$0}
        //if query_check.count == 0{
        //    return nil
        //}
        var str = "<entry>"
        if query[0] as? Int != nil {
            str += "<chapter>"
            str += String(query[0] as! Int)
            str += "</chapter>"
        }
        if query[1] as? Int != nil {
            str += "<volume>"
            str += String(query[1] as! Int)
            str += "</volume>"
        }
        if type == MalKitGlobalVar.requestUpdate {
            if query[2] as? Int != nil {
                str += "<status>"
                str += String(min(max(query[2] as! Int, minValueS), maxValueS))
                str += "</status>"
            }
        }else{
            if query[2] as? Int != nil {
                str += "<status>"
                str += String(min(max(query[2] as! Int, minValueS), maxValueS))
                str += "</status>"
            }
        }
        if query[3] as? Int != nil {
            str += "<score>"
            str += String(query[3] as! Int)
            str += "</score>"
        }
        if query[4] as? Int != nil {
            str += "<times_reread>"
            str += String(query[4] as! Int)
            str += "</times_reread>"
        }
        if query[5] as? Int != nil {
            str += "<reread_value>"
            str += String(query[5] as! Int)
            str += "</reread_value>"
        }
        if query[6] as? Date != nil {
            str += "<date_start>"
            str += self.dateString(date: query[6] as! Date)
            str += "</date_start>"
        }else if query[6] as? String == ""{
            str += "<date_start>"
            str += "</date_start>"
        }
        if query[7] as? Date != nil {
            str += "<date_finish>"
            str += self.dateString(date: query[7] as! Date)
            str += "</date_finish>"
        }else if query[7] as? String == "" {
            str += "<date_finish>"
            str += "</date_finish>"
        }
        if query[8] as? Int != nil {
            str += "<priority>"
            str += String(query[8] as! Int)
            str += "</priority>"
        }
        if query[9] as? Int != nil {
            str += "<enable_discussion>"
            str += String(min(max(query[9] as! Int, minValueE), maxValueE))
            str += "</enable_discussion>"
        }
        if query[10] as? Int != nil {
            str += "<enable_rereading>"
            str += String(min(max(query[10] as! Int, minValueE), maxValueE))
            str += "</enable_rereading>"
        }
        if query[11] as? String != nil {
            str += "<comments>"
            str += query[11] as! String
            str += "</comments>"
        }
        if query[12] as? String != nil {
            str += "<scan_group>"
            str += query[12] as! String
            str += "</scan_group>"
        }
        if query[13] as? String != nil {
            str += "<tags>"
            str += query[13] as! String
            str += "</tags>"
        }
        if query[14] as? Int != nil {
            str += "<retail_volumes>"
            str += String(query[14] as! Int)
            str += "</retail_volumes>"
        }
        str += "</entry>"
        return str
    }
    //MARK: - parse anime param
    private func parseAnimeParam(params: Dictionary<String, Any>) -> Array<Any?>{
        let parsedParams = [params["episode"],params["status"],params["score"],params["storage_type"],params["storage_value"],params["times_rewatched"],
                           params["rewatch_value"],params["date_start"],params["date_finish"],
                           params["priority"],params["enable_discussion"],params["enable_rewatching"],
                           params["comments"],params["tags"]]
        return parsedParams
    }
    //MARK: -  parse manga param
    private func parseMangaParam(params: Dictionary<String, Any>) -> Array<Any?>{
        let parsedParams = [params["chapter"],params["volume"],params["status"],params["score"],params["times_reread"],params["reread_value"],
                           params["date_start"], params["date_finish"],params["priority"],
                           params["enable_discussion"],params["enable_rereading"],params["comments"],
                           params["scan_group"],params["tags"],params["retail_volumes"]]
        return parsedParams
    }
    //MARK: - debug log
    func debugLog(_ obj: Any?,
                  function: String = #function,
                  line: Int = #line) {
        #if DEBUG
            if let obj = obj {
                print("[Function:\(function) Line:\(line)] : \(obj)")
            } else {
                print("[Function:\(function) Line:\(line)]")
            }
        #endif
    }
}

