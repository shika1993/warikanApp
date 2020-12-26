//
//  CalcResult.swift
//  warikanApp
//
//  Created by 鹿内翔平 on 2020/11/08.
//

import Foundation
import RealmSwift

class CalcResult: Object {
    
    @objc dynamic var dateString = String()
    @objc dynamic var totalMember = Int()
    @objc dynamic var totalAmount = Int()
    @objc dynamic var extraValue = Int()
    @objc dynamic var extraMember = Int()
    @objc dynamic var lowValue = Int()
    @objc dynamic var lowMember = Int()
    @objc dynamic var extraCharge = Int()
    
}
