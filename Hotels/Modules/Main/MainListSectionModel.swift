//
//  MainListSectionModel.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation
import RxDataSources

enum MainListSectionItem: IdentifiableType, Equatable {
  case hotel(HotelCardCellViewModel)
  
  typealias Identity = String
  
  var identity: Identity {
    switch self {
    case .hotel(let viewModel): return viewModel.identity
    }
  }
  
  static func == (lhs: MainListSectionItem, rhs: MainListSectionItem) -> Bool {
    return lhs.identity == rhs.identity
  }
  
}

enum MainListSectionModel: IdentifiableType {
  case hotelsSection(content: [MainListSectionItem], header: String)
  
  typealias Identity = String
  
  var identity: String {
    switch self {
    case let .hotelsSection(_, header): return header
    }
  }
}

extension MainListSectionModel: AnimatableSectionModelType {
  typealias Item = MainListSectionItem
  
  var items: [Item] {
    switch self {
    case let .hotelsSection(content, _): return content
    }
  }
  
  init(original: MainListSectionModel, items: [Item]) {
    switch original {
    case let .hotelsSection(_, header):
      self = .hotelsSection(content: items, header: header)
    }
  }
}
