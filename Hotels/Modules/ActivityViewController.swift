//
//  ActivityViewController.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit
import SnapKit

class ActivityViewController: UIViewController {
  
  private lazy var indicatorBackgroundView = UIView()
  private lazy var activityIndicator = UIActivityIndicatorView(style: .white)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    indicatorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    indicatorBackgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    
    view.addSubview(indicatorBackgroundView)
    indicatorBackgroundView.addSubview(activityIndicator)
    
    indicatorBackgroundView.snp.makeConstraints { make in
      make.width.height.equalTo(100)
      make.center.equalTo(self.view)
    }
    
    activityIndicator.snp.makeConstraints { make in
      make.center.equalTo(self.indicatorBackgroundView)
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    indicatorBackgroundView.layer.cornerRadius = 10
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    activityIndicator.startAnimating()
  }
}
