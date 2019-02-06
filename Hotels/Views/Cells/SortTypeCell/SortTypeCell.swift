//
//  SortTypeCell.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit
import MaterialComponents

class SortTypeCell: UITableViewCell {
  
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var sortTitleLabel: UILabel!
  @IBOutlet weak var selectedIndicatorView: UIView!
  
  private var inkTouchController: MDCInkTouchController?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    inkTouchController = MDCInkTouchController(view: cardView)
    inkTouchController?.addInkView()
  }
  
//  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//    <#code#>
//  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    selectedIndicatorView?.isHidden = !selected
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    selectedBackgroundView?.circleCorner = true
  }
  
}
