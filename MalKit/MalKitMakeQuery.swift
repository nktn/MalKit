//
//  MalKitMakeQuery.swift
//  MalKit
//
//  Created by nktn on 2017/07/14.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation

class MalKitMakeQuery {
    //status
    static let minValueS: Int = 1
    static let maxValueS: Int = 6
    //enable_XXXXX
    static let minValueE: Int = 0
    static let maxValueE: Int = 1
    //Add and Update Anime Query
    class func makeAnimeQuerty(query: Array<Any?>, type: Int) -> String {
        var str = "<entry>"
        if query[0] != nil {
            str += "<episode>"
            str += String(query[0] as! Int)
            str += "</episode>"
        }
        if type == MalKitGlobalVar.RequestType.UPDATE.rawValue {
            if query[1] != nil {
                str += "<status>"
                str += String(min(max(query[1] as! Int, minValueS), maxValueS))
                str += "</status>"
            }
        } else {
            str += "<status>"
            str += String(min(max(query[1] as! Int, minValueS), maxValueS))
            str += "</status>"
        }
        if query[2] != nil {
            str += "<score>"
            str += String(query[2] as! Int)
            str += "</score>"
        }
        if query[3] != nil {
            str += "<storage_type>"
            str += String(query[3] as! Int)
            str += "</storage_type>"
        }
        if query[4] != nil {
            str += "<storage_value>"
            str += String(query[4] as! Float)
            str += "</storage_value>"
        }
        if query[5] != nil {
            str += "<times_rewatched>"
            str += String(query[5] as! Int)
            str += "</times_rewatched>"
        }
        if query[6] != nil {
            str += "<rewatch_value>"
            str += String(query[6] as! Int)
            str += "</rewatch_value>"
        }
        if query[7] != nil {
            str += "<date_start>"
            str += MalKitDateUtil.dateString(date: query[7] as! Date)
            str += "</date_start>"
        }
        if query[8] != nil {
            str += "<date_finish>"
            str += MalKitDateUtil.dateString(date: query[8] as! Date)
            str += "</date_finish>"
        }
        if query[9] != nil {
            str += "<priority>"
            str += String(query[9] as! Int)
            str += "</priority>"
        }
        if query[10] != nil {
            str += "<enable_discussion>"
            str += String(min(max(query[10] as! Int, minValueE), maxValueE))
            str += "</enable_discussion>"
        }
        if query[11] != nil {
            str += "<enable_rewatching>"
            str += String(min(max(query[11] as! Int, minValueE), maxValueE))
            str += "</enable_rewatching>"
        }
        if query[12] != nil {
            str += "<comments>"
            str += query[12] as! String
            str += "</comments>"
        }
        if query[13] != nil {
            str += "<tags>"
            str += query[13] as! String
            str += "</tags>"
        }
        str += "</entry>"
        return str
    }
    //Add and Update Manga Query
    class func makeMangaQuerty(query: Array<Any?>, type: Int) -> String {
        var str = "<entry>"
        if query[0] != nil{
            str += "<chapter>"
            str += String(query[0] as! Int)
            str += "</chapter>"
        }
        if query[1] != nil {
            str += "<volume>"
            str += String(query[1] as! Int)
            str += "</volume>"
        }
        if type == MalKitGlobalVar.RequestType.UPDATE.rawValue {
            if query[2] != nil {
                str += "<status>"
                str += String(min(max(query[2] as! Int, minValueS), maxValueS))
                str += "</status>"
            }
        }else{
            str += "<status>"
            str += String(min(max(query[2] as! Int, minValueS), maxValueS))
            str += "</status>"
        }
        if query[3] != nil {
            str += "<score>"
            str += String(query[3] as! Int)
            str += "</score>"
        }
        if query[4] != nil {
            str += "<times_reread>"
            str += String(query[4] as! Int)
            str += "</times_reread>"
        }
        if query[5] != nil {
            str += "<reread_value>"
            str += String(query[5] as! Int)
            str += "</reread_value>"
        }
        if query[6] != nil {
            str += "<date_start>"
            str += MalKitDateUtil.dateString(date: query[6] as! Date)
            str += "</date_start>"
        }
        if query[7] != nil {
            str += "<date_finish>"
            str += MalKitDateUtil.dateString(date: query[7] as! Date)
            str += "</date_finish>"
        }
        if query[8] != nil {
            str += "<priority>"
            str += String(query[8] as! Int)
            str += "</priority>"
        }
        if query[9] != nil {
            str += "<enable_discussion>"
            str += String(min(max(query[9] as! Int, minValueE), maxValueE))
            str += "</enable_discussion>"
        }
        if query[10] != nil {
            str += "<enable_rereading>"
            str += String(min(max(query[10] as! Int, minValueE), maxValueE))
            str += "</enable_rereading>"
        }
        if query[11] != nil {
            str += "<comments>"
            str += query[11] as! String
            str += "</comments>"
        }
        if query[12] != nil {
            str += "<scan_group>"
            str += query[12] as! String
            str += "</scan_group>"
        }
        if query[13] != nil {
            str += "<tags>"
            str += query[13] as! String
            str += "</tags>"
        }
        if query[14] != nil {
            str += "<retail_volumes>"
            str += String(query[14] as! Int)
            str += "</retail_volumes>"
        }
        str += "</entry>"
        return str
    }
}
