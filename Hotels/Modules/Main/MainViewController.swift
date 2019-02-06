//
//  MainViewController.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import RxSwiftExt
import NSObject_Rx
import RxDataSources

class MainViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var viewModel: MainViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    MainRouter.initMainController(self)
    setupBindings()
    setupDataSource()
  }
  
  private func setupBindings() {
    rx.viewWillAppear.mapTo(Void()).asSignal(onErrorJustReturn: Void()).emit(to: viewModel.viewWillAppear).disposed(by: rx.disposeBag)
  }
  
  private func setupDataSource() {
    let datasource = RxTableViewSectionedAnimatedDataSource<MainListSectionModel>(configureCell: { dataSource, tableView, indexPath, model in
      var cell: UITableViewCell?
      switch model {
      case let .hotel(cellViewModel):
        let hotelCardCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.hotelCardCell, for: indexPath)
        hotelCardCell?.viewModel = cellViewModel
        cell = hotelCardCell
      }
      return cell ?? UITableViewCell()
    })
    
    viewModel.sections.drive(tableView.rx.items(dataSource: datasource)).disposed(by: rx.disposeBag)
    
    tableView.rx.itemSelected.asSignal().debug().emit(to: viewModel.indexPathSelected).disposed(by: rx.disposeBag)
  }
  
}

extension MainViewController: UITableViewDelegate {
  
}


