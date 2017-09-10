//
//  SPRecipentTableViewCell.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/7/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

class SPRecipentTableViewCell: UITableViewCell {
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var viewCicrle: UIView!
    @IBOutlet weak var lableNumberOfItem: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.parentView.layer.cornerRadius = 4
        self.viewCicrle.layer.cornerRadius = self.viewCicrle.layer.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configCell(index:Int) {
        self.lableNumberOfItem.text = "\(index)"
    }
}
