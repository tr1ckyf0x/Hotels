//
//  SortViewController.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private let sortTypes = SortType.allCases
  
  var oldSortType: SortType?
  
  var changeSortTypeClosure: MainRouter.ChangeSortType?
  
  private var indexPathToBeSelected: IndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let indexPath = indexPathToBeSelected {
      tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
    }
  }
}

extension SortViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
      indexPathForSelectedRow == indexPath {
      tableView.deselectRow(at: indexPath, animated: false)
      changeSortTypeClosure?(nil)
      return nil
    }
    return indexPath
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    changeSortTypeClosure?(sortTypes[indexPath.row])
  }
}

extension SortViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int { return 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return sortTypes.count }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sortTypeCell, for: indexPath)
    let sortType = sortTypes[indexPath.row]
    if sortType == oldSortType { indexPathToBeSelected = indexPath }
    cell?.sortTitleLabel.text = sortType.title
    return cell ?? UITableViewCell()
  }
}
