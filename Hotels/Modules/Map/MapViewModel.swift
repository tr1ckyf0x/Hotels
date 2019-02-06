//
//  MapViewModel.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MapViewModel {
  
  let annotation: BehaviorRelay<MapPin>
  
  init(mapPin: MapPin) {
    annotation = BehaviorRelay<MapPin>(value: mapPin)
  }
  
}
