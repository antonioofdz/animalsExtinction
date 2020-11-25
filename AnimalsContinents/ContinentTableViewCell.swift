//
//  ContinentTableViewCell.swift
//  AnimalsContinents
//
//  Created by Bruno on 14/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class ContinentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ext: UILabel!
    @IBOutlet weak var clima: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var continentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
