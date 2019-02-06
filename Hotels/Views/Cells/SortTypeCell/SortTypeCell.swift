//
//  SortTypeCell.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit

class SortTypeCell: UITableViewCell {

  @IBOutlet weak var cardView: DesignableView!
  @IBOutlet weak var sortTitleLabel: UILabel!
  @IBOutlet weak var checkmarkView: DesignableView!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    checkmarkView.circleCorner = true
  }

}
