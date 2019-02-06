//
//  APIService.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation
import Moya

enum APIService {
  case getHotels
  case getHotel(id: UInt)
}

extension APIService: TargetType {
  var headers: [String : String]? { return nil }

  var baseURL: URL {
    return URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/")!
  }

  var path: String {
    switch self {
    case .getHotels: return "0777.json"
    case .getHotel(let id): return "\(id).json"
    }
  }

  var method: Moya.Method {
    return .get
  }

  var parameters: [String: Any] { return [:] }

  var task: Task { return .requestPlain }
  
  var sampleData: Data { return Data() }
}
