//
//  SPProductTableViewCell.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

class SPProductTableViewCell: SPBaseTableViewCell {

    @IBOutlet weak var nameProduct: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblInventory: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgAvartaProduct: UIImageView!
    
    let date = Date()
    var formatDate = DateFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        formatDate.dateFormat = DATA.DATEFORMAT
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func ConfigCell(product:SPProduct) {
        print("product id = \(product.id)")
        nameProduct.text = product.name
        lblTotal.text = "\(product.totalProduct)"
        lblInventory.text = "\(product.inventory)"
        lblPrice.text = "\(product.price)"
        lblStartDate.text = self.formatDate.string(from: product.startDate)
        print("thay image  \(product.name) urlImage = \(product.imageUrl)")
        if let urlImage = URL(string: product.imageUrl) {
            imgAvartaProduct.image = self.displayImageFromAsset(imageUrl: urlImage)
        } else {
            print("khong tim thay image  \(product.name) urlImage = \(product.imageUrl)")
        }

    }
    
}
