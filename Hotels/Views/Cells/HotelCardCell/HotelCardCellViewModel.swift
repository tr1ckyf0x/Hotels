//
//  HotelCardCellViewModel.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class HotelCardCellViewModel {
  
  private let hotel: BehaviorRelay<Hotel>
  
  let hotelImageUrl: Driver<URL?>
  let hotelTitle: Driver<String>
  let hotelDistance: Driver<String>
  let availableSuits: Driver<String>
  let address: Driver<String>
  let rating: Driver<Double>
  
  init(hotel: Hotel) {
    self.hotel = BehaviorRelay(value: hotel)
    let hotelDriver = self.hotel.asDriver()
    hotelImageUrl = hotelDriver.map { $0.imageUrl }
    hotelTitle = hotelDriver.map { $0.name }
    hotelDistance = hotelDriver.map { "\($0.distance) miles" }
    availableSuits = hotelDriver.map { "Available suits: \($0.availableRooms.joined(separator: " "))" }
    address = hotelDriver.map { $0.address }
    rating = hotelDriver.map { $0.stars }
  }
  
}

extension HotelCardCellViewModel: IdentifiableType {
  typealias Identity = String
  var identity: Identity { return "\(hotel.value.id)" }
}
