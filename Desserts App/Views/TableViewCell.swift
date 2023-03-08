//
//  TableViewCell.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var dessertImageView: UIImageView!
    @IBOutlet weak var dessertLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //rounds off the corners for the image view in each cell
        dessertImageView.layer.cornerRadius = dessertImageView.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //adds padding to cell content view
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
