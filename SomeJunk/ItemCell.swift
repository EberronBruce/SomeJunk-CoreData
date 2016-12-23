//
//  ListCell.swift
//  SomeJunk
//
//  Created by Bruce Burgess on 12/18/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!

    func configurerCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
    }

}
