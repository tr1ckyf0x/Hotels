//
//  SortType.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation

enum SortType: CaseIterable {
  case byDistance
  case byFreeRooms
  
  var title: String {
    switch self {
    case .byDistance: return "By distance"
    case .byFreeRooms: return "By free rooms"
    }
  }
}
