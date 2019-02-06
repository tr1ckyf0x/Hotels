//
//  StarRatingView.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit

@IBDesignable
class StarRatingView: UIView {
  
  @IBOutlet var contentView: UIView!
  
  @IBOutlet weak var firstStar: UIImageView!
  @IBOutlet weak var secondStar: UIImageView!
  @IBOutlet weak var thirdStar: UIImageView!
  @IBOutlet weak var fourthStar: UIImageView!
  @IBOutlet weak var fifthStar: UIImageView!
  
  @IBOutlet weak var firstEmptyStar: UIImageView!
  @IBOutlet weak var secondEmptyStar: UIImageView!
  @IBOutlet weak var thirdEmptyStar: UIImageView!
  @IBOutlet weak var fourthEmptyStar: UIImageView!
  @IBOutlet weak var fifthEmptyStar: UIImageView!
  
  private var fullImageViews: [UIImageView] = []
  private var emptyImageViews: [UIImageView] = []
  
  @IBInspectable
  var rating: Double = 0 {
    didSet {
      if rating != oldValue {
        refresh()
      }
    }
  }
  
  @IBInspectable
  var color: UIColor = UIColor.gray {
    didSet {
      emptyImageViews.forEach { imageView in imageView.tintColor = color }
      fullImageViews.forEach { imageView in imageView.tintColor = color }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    xibSetUp()
    fullImageViews = [firstStar, secondStar, thirdStar, fourthStar, fifthStar]
    emptyImageViews = [firstEmptyStar, secondEmptyStar, thirdEmptyStar, fourthEmptyStar, fifthEmptyStar]
  }
  
  private func xibSetUp() {
    contentView = loadViewFromNib()
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
  }
  
  private func loadViewFromNib() -> UIView {
    return R.nib.starRatingView.instantiate(withOwner: self, options: nil)[0] as! UIView
  }
  
  private func refresh() {
    for i in 0 ..< fullImageViews.count {
      let imageView = fullImageViews[i]
      
      if rating >= Double(i+1) {
        imageView.layer.mask = nil
        imageView.isHidden = false
      } else if rating > Double(i) && rating < Double(i+1) {
        // Set mask layer for full image
        let maskLayer = CALayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(rating-Double(i))*imageView.frame.size.width, height: imageView.frame.size.height)
        maskLayer.backgroundColor = UIColor.black.cgColor
        imageView.layer.mask = maskLayer
        imageView.isHidden = false
      } else {
        imageView.layer.mask = nil;
        imageView.isHidden = true
      }
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    refresh()
  }
  
}
