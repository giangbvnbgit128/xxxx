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
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumberPhone: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    @IBOutlet weak var lblResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.parentView.layer.cornerRadius = 4
        self.viewCicrle.layer.cornerRadius = self.viewCicrle.layer.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func clickMaps(_ sender: Any) {
    }
    @IBAction func ClickAccept(_ sender: Any) {
    }
    @IBAction func clickCall(_ sender: Any) {
    }
    func configCell(index:Int, product:SPProduct, order:SPOrderModel,address: SPAddress) {
        self.lableNumberOfItem.text = "\(index)"
        self.lblName.text = order.nameGuest
        self.lblProduct.text = order.phoneNumber
        self.lblProduct.text = product.name
        self.lblAddress.text = address.nameAddress
    }
}
