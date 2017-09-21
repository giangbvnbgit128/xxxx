//
//  SPBaseModelRealm.swift
//  xxxx
//
//  Created by Bui Giang on 9/21/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import RealmSwift
import Realm

class SPBaseModelRealm: Object {
    dynamic var id:Int = 0
    func incrementID(modelName:Object.Type) -> Int {
        let realm = try! Realm()
        return (realm.objects(modelName).max(ofProperty: "id") as Int? ?? 0) + 1
    }

}
