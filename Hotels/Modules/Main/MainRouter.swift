//
//  MainRouter.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation
import Moya
import CoreLocation

class MainRouter {
  
  weak var view: MainViewController?
  private weak var activityViewController: ActivityViewController?
  
  class func initMainController(_ viewController: MainViewController) {
    let apiService = MoyaProvider<APIService>()
    let router = MainRouter()
    let viewModel = MainViewModel(apiService: apiService, router: router)
    
    viewController.viewModel = viewModel
    router.view = viewController
  }
  
  func showActivityView() {
    let activityViewController = ActivityViewController()
    self.activityViewController = activityViewController
    view?.add(activityViewController)
  }
  
  func hideActivityView() {
    activityViewController?.remove()
  }
  
  func showMapView(with latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, address: String) {
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let mapPin = MapPin(title: title, address: address, coordinate: coordinate)
    
    let mapViewController = R.storyboard.main.mapViewController()
    let mapViewModel = MapViewModel(mapPin: mapPin)
    
    mapViewController?.viewModel = mapViewModel
    
    if let mapViewController = mapViewController {
      view?.navigationController?.pushViewController(mapViewController, animated: true)
    }
  }
}
