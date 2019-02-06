//
//  CornerCropImageProcessor.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation
import Kingfisher

public struct BorderCropImageProcessor: ImageProcessor {
  public let identifier: String
  
  let borderWidth: CGFloat
  
  public init(borderWidth: CGFloat = 0) {
    self.borderWidth = borderWidth
    self.identifier = "com.tr1ckyf0x.BorderCropImageProcessor(\(borderWidth))"
  }
  
  public func process(item: ImageProcessItem, options: KingfisherOptionsInfo) -> Image? {
    switch item {
    case .image(let image):
      
      let width = image.size.width
      let height = image.size.height
      
      return image.kf.scaled(to: options.scaleFactor)
        .kf.crop(to: CGSize(width: width - borderWidth * 2, height: height - borderWidth * 2), anchorOn: CGPoint(x: 0.5, y: 0.5))
      
    case .data(_):
      return (DefaultImageProcessor.default >> self).process(item: item, options: options)
    }
  }
}
