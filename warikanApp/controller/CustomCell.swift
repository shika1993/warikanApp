//
//  CustomCell.swift
//  warikanApp
//
//  Created by 鹿内翔平 on 2020/09/27.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var totalAmountlabel: UILabel!
    @IBOutlet weak var extraAmountLabel: UILabel!
    @IBOutlet weak var extraMemberLabel: UILabel!
    @IBOutlet weak var lowAmountLabel: UILabel!
    @IBOutlet weak var lowMemberLabel: UILabel!
    @IBOutlet weak var sendToLineButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
