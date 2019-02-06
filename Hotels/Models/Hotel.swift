//
//  Hotel.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation

struct Hotel: Decodable {
  let id: UInt
  let name: String
  let address: String
  let stars: Double
  let distance: Double
  let imageUrl: URL?
  let availableRooms: [String]
  let latitude: Double
  let longitude: Double
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case address
    case stars
    case distance
    case availableRooms = "suites_availability"
    case latitude = "lat"
    case longitude = "lon"
    case image
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(UInt.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    address = try values.decode(String.self, forKey: .address)
    stars = try values.decode(Double.self, forKey: .stars)
    distance = try values.decode(Double.self, forKey: .distance)
    if let imageName = try values.decodeIfPresent(String.self, forKey: .image) {
      imageUrl = URL(string: "https://github.com/iMofas/ios-android-test/raw/master/\(imageName)")
    } else { imageUrl = nil }
    availableRooms = try values.decode(String.self, forKey: .availableRooms).split(separator: ":").map { String($0) }
    latitude = try values.decode(Double.self, forKey: .latitude)
    longitude = try values.decode(Double.self, forKey: .longitude)
  }
  
}
