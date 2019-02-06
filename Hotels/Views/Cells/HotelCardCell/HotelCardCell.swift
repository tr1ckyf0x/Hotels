//
//  HotelCardCell.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit
import Kingfisher
import RxKingfisher
import RxCell
import MaterialComponents

class HotelCardCell: UITableViewCell {
  
  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var hotelImageView: UIImageView!
  @IBOutlet weak var hotelTitleLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var availableSuitsLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var starRatingView: StarRatingView!
  
  private var inkTouchController: MDCInkTouchController?
  
  override func awakeFromNib() {
    hotelImageView.kf.indicatorType = .activity
    
    inkTouchController = MDCInkTouchController(view: cardView)
    inkTouchController?.addInkView()
  }
  
  var viewModel: HotelCardCellViewModel! {
    didSet {
      let cropProcessor = BorderCropImageProcessor(borderWidth: 5)
      viewModel.hotelImageUrl.drive(hotelImageView.kf.rx.image(placeholder: R.image.placeholder(), options: [
        .processor(cropProcessor),
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage
        ])).disposed(by: rx.reuseDisposeBag)
      
      viewModel.hotelTitle.drive(hotelTitleLabel.rx.text).disposed(by: rx.reuseDisposeBag)
      viewModel.hotelDistance.drive(distanceLabel.rx.text).disposed(by: rx.reuseDisposeBag)
      viewModel.availableSuits.drive(availableSuitsLabel.rx.text).disposed(by: rx.reuseDisposeBag)
      viewModel.address.drive(addressLabel.rx.text).disposed(by: rx.reuseDisposeBag)
      viewModel.rating.drive(onNext: { [weak starRatingView] value in starRatingView?.rating = value }).disposed(by: rx.disposeBag)
    }
  }
}
