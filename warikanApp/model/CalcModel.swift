//
//  CalcModel.swift
//  warikanApp
//
//  Created by 鹿内翔平 on 2020/09/29.
//

import Foundation

struct CalcModel {
    
    var totalAmount:Int
    var totalMember:Int
    var extraMember:Int
    var extraAmount:Int
    var minimumValue:Int
    var highValue = 0
    var lowValue = 0
    
    init(totalAmount:Int, totalMember:Int, extraMember:Int, extraAmount:Int, minimumValue:Int) {
        
        self.totalAmount = totalAmount
        self.totalMember = totalMember
        self.extraMember = extraMember
        self.extraAmount = extraAmount
        self.minimumValue = minimumValue
    }
    
    mutating func calculate() -> (Int, Int, Int){
        
        //let average = totalAmount / totalMember
        let minimumMember = totalMember - extraMember
        if minimumValue == 0{
            print(Int(ceil(Double(extraAmount)/1000)*1000))
            self.highValue = Int(ceil(Double(extraAmount)/1000)*1000)
        }else if minimumValue == 1{
            print(Int(ceil(Double(extraAmount)/500)*500))
            self.highValue = Int(ceil(Double(extraAmount)/500)*500)
        }else{
            print(Int(ceil(Double(extraAmount)/100)*100))
            self.highValue = Int(ceil(Double(extraAmount)/100)*100)
        }
        let totalhighValue = highValue * extraMember
        let totalLowValue = totalAmount - totalhighValue
        
        if minimumValue == 0{
            self.lowValue = Int(ceil(Double(totalLowValue/minimumMember)/1000)*1000)
        }else if minimumValue == 1{
            self.lowValue = Int(ceil(Double(totalLowValue/minimumMember)/500)*500)
        }else{
            self.lowValue = Int(ceil(Double(totalLowValue/minimumMember)/100)*100)
        }
        
        let extraMoney = (((highValue*extraMember)+(lowValue * minimumMember)) - totalAmount)
        print(extraMoney)
        
        return (highValue, lowValue, extraMoney)
    }
}
