//
//  MainViewModel.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class MainViewModel {
  
  private let apiService: MoyaProvider<APIService>
  
  private let router: MainRouter?
  
  private let disposeBag = DisposeBag()
  
  private let sortType = BehaviorRelay<SortType?>(value: nil)
  
  let viewWillAppear = PublishRelay<Void>()
  
  let errorOccured = PublishRelay<Error>()
  
  private let isLoading = PublishRelay<Bool>()
  
  let indexPathSelected = PublishRelay<IndexPath>()
  
  let sortButtonTapped = PublishRelay<Void>()
  
  private let hotels = BehaviorRelay<[Hotel]>(value: [])
  
  let sections: Driver<[MainListSectionModel]>
  
  init(apiService: MoyaProvider<APIService>, router: MainRouter? = nil) {
    self.apiService = apiService
    self.router = router
    
    sections = hotels
      .asDriver()
      .debug()
      .map { hotels in
        let hotelItems = hotels
          .map { hotel in HotelCardCellViewModel(hotel: hotel) }
          .map { cellViewModel in MainListSectionItem.hotel(cellViewModel) }
        let hotelsSection = MainListSectionModel.hotelsSection(content: hotelItems, header: "Hotels")
        return [hotelsSection]
    }
    
    subscribeToEvents()
  }
  
  private func subscribeToEvents() {
    isLoading.subscribe(onNext: { [weak router] isLoading in
      if isLoading { router?.showActivityView() }
      else { router?.hideActivityView() }
    }).disposed(by: disposeBag)
    
    viewWillAppear
      .flatMapLatest { [weak self] _ -> Maybe<[Hotel]> in
        guard let obj = self else { return Maybe.empty() }
        return obj.getHotels()
      }
      .withLatestFrom(sortType) { hotels, sortType -> [Hotel] in
        guard let sortType = sortType else { return hotels }
        
        // В данном случае видов сортировок мало, потому был выбран такой метод.
        // При большем количестве сортировок можно было бы использовать стратегию и фабрику
        
        switch sortType {
        case .byDistance: return hotels.sorted(by: { lhs, rhs in lhs.distance < rhs.distance })
        case .byFreeRooms: return hotels.sorted(by: { lhs, rhs in lhs.availableRooms.count > rhs.availableRooms.count })
        }
      }
      .bind(to: hotels)
      .disposed(by: disposeBag)
    
    indexPathSelected.withLatestFrom(hotels) { indexPath, hotels in hotels[indexPath.row] }
      .subscribe(onNext: { [weak router] hotel in
        router?.showMapView(with: hotel.latitude, longitude: hotel.longitude, title: hotel.name, address: hotel.address)
      }).disposed(by: disposeBag)
    
    sortButtonTapped.withLatestFrom(sortType).subscribe(onNext: { [weak router] currentSortType in
      let changeSortTypeClosure: MainRouter.ChangeSortType = { [weak self] sortType in self?.sortType.accept(sortType) }
      router?.showSortSelectorView(changeSortClosure: changeSortTypeClosure, currentSortType: currentSortType)
    }).disposed(by: disposeBag)
    
  }
  
  private func getHotels() -> Maybe<[Hotel]> {
    return apiService.rx.request(.getHotels).map([HotelIDResponse].self)
      .asObservable()
      .flatMap { hotelIdResponses -> Observable<UInt> in
        let IDs = hotelIdResponses.map { response in response.id }
        return Observable.from(IDs)
      }
      .flatMap { [weak self] id -> Maybe<Hotel> in
        guard let obj = self else { return Maybe.empty() }
        return obj.apiService.rx.request(.getHotel(id: id)).map(Hotel.self).asMaybe()
      }
      .do(onError: { [weak errorOccured] error in
        errorOccured?.accept(error)
      })
      .asObservable()
      .catchErrorJustComplete()
      .toArray()
      .do(onSubscribe: { [weak isLoading] in isLoading?.accept(true) }, onDispose: { [weak isLoading] in isLoading?.accept(false) })
      .asMaybe()
  }
  
}
