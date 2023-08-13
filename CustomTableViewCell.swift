//
//  CustomTableViewCell.swift
//  gallerySample2
//
//  Created by 82205 on 2023/08/06.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var feed:Feed?
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
