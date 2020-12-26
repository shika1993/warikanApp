//
//  CalcListViewController.swift
//  warikanApp
//
//  Created by 鹿内翔平 on 2020/09/27.
//

import UIKit
import RealmSwift

class CalcListViewController: UIViewController{

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var calcListTableView: UITableView!
    
    var resultArray = [CalcResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        let results = realm.objects(CalcResult.self)
        
        for i in results{
            resultArray.append(i)
        }
        
        calcListTableView.delegate = self
        
        calcListTableView.dataSource = self
        
        calcListTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        backButton.layer.cornerRadius = 15.0
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOpacity = 0.4
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }

    
    @objc func sendToLine(_ sender: UIButton) {
        let urlscheme: String = "https://line.me/R/msg/text"
        let message = "こんにちは!\n傾斜割り勘くんアプリです\n\(resultArray[sender.tag].dateString)に\(String(resultArray[sender.tag].totalMember))人でお食事会をしました。\nお会計は\(String(resultArray[sender.tag].totalMember))人で合計\(String(resultArray[sender.tag].totalAmount))円でした。\n\(String(resultArray[sender.tag].extraMember))人が\(String(resultArray[sender.tag].extraValue))円\n\(String(resultArray[sender.tag].lowMember))人が\(String(resultArray[sender.tag].lowValue))円支払い\nお釣りは\(String(resultArray[sender.tag].extraCharge))円でした"
        let urlstring = urlscheme + "/?" + message
        
        guard let  encodedURL = urlstring.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return
        }
        
        guard let url = URL(string: encodedURL) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }else {
            // LINEアプリが無い場合
            let alertController = UIAlertController(title: "エラー",
                                                    message: "LINEがインストールされていません",
                                                    preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alertController,animated: true,completion: nil)
        }
    }
    
    
    @IBAction func buckButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- tableviewdelegate & datasource
extension CalcListViewController: UITableViewDelegate,UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.selectionStyle = .none
        
        cell.dateLabel.text = resultArray[indexPath.row].dateString
        cell.memberLabel.text = "\(String(resultArray[indexPath.row].totalMember))人"
        cell.totalAmountlabel.text = "\(String(resultArray[indexPath.row].totalAmount))円"
        cell.extraAmountLabel.text = "\(String(resultArray[indexPath.row].extraValue))円"
        cell.lowAmountLabel.text = "\(String(resultArray[indexPath.row].lowValue))円"
        cell.extraMemberLabel.text = "\(String(resultArray[indexPath.row].extraMember))人"
        cell.lowMemberLabel.text = "\(String(resultArray[indexPath.row].lowMember))人"
        
        cell.sendToLineButton.tag = indexPath.row
        
        cell.sendToLineButton.addTarget(self, action: #selector(self.sendToLine(_:)), for: .touchUpInside)
        
        cell.layer.cornerRadius = 20.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    

}
