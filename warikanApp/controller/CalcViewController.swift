//
//  CalcViewController.swift
//  warikanApp
//
//  Created by 鹿内翔平 on 2020/09/27.
//

import UIKit
import IQKeyboardManagerSwift


class CalcViewController: UIViewController{

    
    @IBOutlet weak var totalAmountTextfield: UITextField!
    @IBOutlet weak var totalMemberTextfield: UITextField!
    @IBOutlet weak var extraMemberTextfield: UITextField!
    @IBOutlet weak var extraAmountTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var averageLavel: UILabel!
    @IBOutlet weak var minimumValueSegment: UISegmentedControl!
    @IBOutlet weak var dateLabel: UILabel!
 
    var segmentNumber = 0
    var average = 0
    var textFieldTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalAmountTextfield.delegate = self
        totalMemberTextfield.delegate = self
        extraMemberTextfield.delegate = self
        extraAmountTextField.delegate = self
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale(identifier: "ja_JP"))
        dateLabel.text = formatter.string(from: Date())
        
        calcButton.layer.cornerRadius = 15.0
        calcButton.layer.shadowColor = UIColor.black.cgColor
        calcButton.layer.shadowOpacity = 0.4
        calcButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        backButton.layer.cornerRadius = 15.0
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOpacity = 0.4
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        clearButton.layer.cornerRadius = 15.0
        clearButton.layer.shadowColor = UIColor.black.cgColor
        clearButton.layer.shadowOpacity = 0.4
        clearButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        backButton.layer.cornerRadius = 15.0
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOpacity = 0.4
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        self.addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.done, target: self, action: #selector(CalcViewController.doneButtonAction(_:)))
        

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        
        doneToolbar.sizeToFit()

        self.totalAmountTextfield.inputAccessoryView = doneToolbar
        self.totalMemberTextfield.inputAccessoryView = doneToolbar
        self.extraMemberTextfield.inputAccessoryView = doneToolbar
        self.extraAmountTextField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(_ sender: UIButton) {

        switch textFieldTag {
        case 1:
            totalMemberTextfield.becomeFirstResponder()
        case 2:
            extraMemberTextfield.becomeFirstResponder()
        case 3:
            extraAmountTextField.becomeFirstResponder()
        case 4:
            extraAmountTextField.endEditing(true)
        default:
            break
        }
    }
    
    @IBAction func calcResButtonPressed(_ sender: UIButton) {
        
        switch minimumValueSegment.selectedSegmentIndex {
        case 0:
            segmentNumber = 0
        case 1:
            segmentNumber = 1
        case 2:
            segmentNumber = 2
        default:
            return
        }
       
        if totalAmountTextfield.text! == "" || totalMemberTextfield.text! == "" || extraMemberTextfield.text! == "" || extraAmountTextField.text! == "" {
            makeAlert(text: "空欄があります")
        }else{
            if Int(totalMemberTextfield.text!)! < Int(extraMemberTextfield.text!)!{
                makeAlert(text: "多く支払う人が参加人数を超えています。")
            }else{
                
                if Int(minimumValueSegment.titleForSegment(at: minimumValueSegment.selectedSegmentIndex)!)! > Int(totalAmountTextfield.text!)! {
                    makeAlert(text: "合計金額が最小単位より少ないです。")
                }else{
                    if Int(totalAmountTextfield.text!)! < Int(extraAmountTextField.text!)! {
                        makeAlert(text: "合計金額よりも多く支払おうとしています")
                    }else{
                        if Int(totalMemberTextfield.text!)! <= Int(extraMemberTextfield.text!)! {
                            makeAlert(text: "多く支払う人は参加人数より少なくしてください")
                        }else{
                            if Int(totalAmountTextfield.text!)! < (Int(extraAmountTextField.text!)!)*Int(extraMemberTextfield.text!)!{
                                makeAlert(text: "合計金額よりも多く支払おうとしています")
                            }else{
                                
                                var calc = CalcModel(totalAmount: Int(totalAmountTextfield.text!)!, totalMember: Int(totalMemberTextfield.text!)!, extraMember: Int(extraMemberTextfield.text!)!, extraAmount: Int(extraAmountTextField.text!)!, minimumValue: segmentNumber)
                                let result = calc.calculate()
                                let SB = UIStoryboard(name: "CalcResult", bundle: nil)
                                let VC = SB.instantiateViewController(withIdentifier: "calcResult") as! CalcResultViewController
                                VC.totalMember = calc.totalMember
                                VC.totalAmount = calc.totalAmount
                                VC.highMember = calc.extraMember
                                VC.highAmount = result.0
                                VC.lowAmount = result.1
                                VC.lowMember = (calc.totalMember - calc.extraMember)
                                VC.extraAmount = result.2
                                VC.dateString = dateLabel.text
                                VC.modalPresentationStyle = .fullScreen
                                self.navigationController?.pushViewController(VC, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func buckButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        for textfield in textFields {
            textfield.text! = ""
            averageLavel.text = "円のところ"
        }
    }
    
    func makeAlert(text:String) {
        
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK:- TextFieldDelegate
extension CalcViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        for textField in textFields {
            let intText = Int(textField.text!)
            if let amount = intText{
                if amount == 0 {
                    textField.text = ""
                }else{
                    textField.text = String(amount)
                }
            }
        }
   
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textFields[0].text! != "" && textFields[1].text! != "" {
            average = Int(textFields[0].text!)! / Int(textFields[1].text!)!
            averageLavel.text = "\(String(average))円のところ"
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFieldTag = textField.tag
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
        return true
    }
    
}
