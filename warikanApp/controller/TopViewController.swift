//
//  TopViewController.swift
//  warikanApp
//
//  Created by 鹿内翔平 on 2020/09/27.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var calcHistButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        calcButton.layer.cornerRadius = 15.0
        calcButton.layer.shadowColor = UIColor.black.cgColor
        calcButton.layer.shadowOpacity = 0.4
        calcButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        calcHistButton.layer.cornerRadius = 15.0
        calcHistButton.layer.shadowColor = UIColor.black.cgColor
        calcHistButton.layer.shadowOpacity = 0.4
        calcHistButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        

    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        let SB = UIStoryboard(name: "Calc", bundle: nil)
        let VC = SB.instantiateViewController(withIdentifier: "calc") as! CalcViewController
        VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(VC, animated: true)
        //self.present(VC, animated: true, completion: nil)
    }
    
    
    @IBAction func calcListButtonPressed(_ sender: UIButton) {
        let SB = UIStoryboard(name: "CalcList", bundle: nil)
        let VC = SB.instantiateViewController(withIdentifier: "calcList") as! CalcListViewController
        VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
