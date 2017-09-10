//
//  SPProductTableViewCell.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

class SPProductTableViewCell: UITableViewCell {

    @IBOutlet weak var nameProduct: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblInventory: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgAvartaProduct: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func ConfigCell(product:SPProduct) {
        nameProduct.text = product.name
        lblTotal.text = "\(product.totalProduct)"
        lblInventory.text = "\(product.inventory)"
        lblPrice.text = "\(product.price)"
        imageView?.image = UIImage(named: product.imageUrl)
    }
    
}
