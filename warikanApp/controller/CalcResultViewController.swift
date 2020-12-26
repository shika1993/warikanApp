//
//  CalcResultViewController.swift
//  warikanApp
//
//  Created by 鹿内翔平 on 2020/09/27.
//

import UIKit
import RealmSwift

class CalcResultViewController: UIViewController {

    @IBOutlet weak var totalMemberLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var totalMember:Int?
    var totalAmount:Int?
    var highMember:Int?
    var highAmount:Int?
    var lowMember:Int?
    var lowAmount:Int?
    var extraAmount:Int?
    var dateString:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = dateString
        totalMemberLabel.text = "本日\(String(totalMember!))人でのお会計は"
        totalAmountLabel.text = "合計金額\(String(totalAmount!))円のうち"
        highLabel.text = "\(highMember!)人が\(String(highAmount!))円"
        lowLabel.text = "\(lowMember!)人が\(String(lowAmount!))円"
        extraLabel.text = "お釣りが\(String(extraAmount!))円発生します"
        
        saveButton.layer.cornerRadius = 15.0
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowOpacity = 0.4
        saveButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        backButton.layer.cornerRadius = 15.0
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOpacity = 0.4
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }
    
    @IBAction func buckButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let result = CalcResult()
        
        result.dateString = dateLabel.text!
        result.totalMember = totalMember!
        result.totalAmount = totalAmount!
        result.extraValue = highAmount!
        result.extraMember = highMember!
        result.lowValue = lowAmount!
        result.lowMember = lowMember!
        result.extraCharge = extraAmount!
        
        let realm = try! Realm()
        try! realm.write {
          realm.add(result)
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
