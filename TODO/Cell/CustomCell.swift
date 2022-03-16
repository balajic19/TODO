//
//  CustomCell.swift
//  TODO
//
//balajichandupatla1@gmail.com
//A00245077

//nutakki.shivaramakrishna99@gmail.com
//A00245380

//A00245384 - rohith.god1997@gmail.com
//A00245382 - Alekhyachowdary605@gmail.com

//kavyach23@gmail.com
//A00246628

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var toDoLbl: UILabel!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        toDoLbl.textColor = .black
        completeBtn.setImage(UIImage(systemName: "rectangle"), for: .normal)
        completeBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
