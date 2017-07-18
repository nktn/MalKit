//
//  MalKitDateUtil.swift
//  MalKit
//
//  Created by nktn on 2017/07/14.
//  Copyright © 2017年 nktn. All rights reserved.
//

import Foundation

class MalKitDateUtil{
    //date parameter from https://myanimelist.net/modules.php?go=api
    class func dateString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMddyyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}
