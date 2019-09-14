//
//  PSensorTableViewCell.swift
//  SensorAppPriya
//
//  Created by Suresh on 9/14/19.
//  Copyright © 2019 Priya. All rights reserved.
//

import UIKit
import CoreData

class PSensorTableViewCell: UITableViewCell {

    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
