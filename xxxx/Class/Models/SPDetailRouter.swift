//
//  SPDetailRouter.swift
//  xxxx
//
//  Created by Bui Giang on 9/27/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import Foundation
import ObjectMapper

class SPDistance: Mappable {
    var Text:String = ""
    var Value:Int = 0

    init() {
        
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        Text <- map["text"]
        Value <- map["value"]

    }
    
}
class SPDuration: Mappable {
    var Text:String = ""
    var Value:Int = 0
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        Text <- map["text"]
        Value <- map["value"]
    }
}

class SPElement: Mappable {
    var duration:SPDuration = SPDuration()
    var distance:SPDistance = SPDistance()
    var status:String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        duration <- map["duration"]
        distance <- map["distance"]
        status <- map["status"]
    }
}

class SPRow: Mappable {
    var elements:[SPElement] = []
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        elements <- map["elements"]
    }
}

class SPDetailRouter: Mappable {
    var rows:[SPRow] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
     rows <- map["rows"]
    }
}
