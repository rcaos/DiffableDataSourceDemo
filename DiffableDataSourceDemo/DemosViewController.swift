//
//  DemosViewController.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 12/12/21.
//

import UIKit

class DemosViewController: UIViewController {

  let tableView = UITableView(frame: .zero)

  let demos: [DemoItem] = [
    DemoItem(name: "Diff Algorithm",
             identifier: DiffTableViewController.self.description())
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Demos"
    view.addSubview(tableView)
    setupTable()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  private func setupTable() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier) // 1
    setupDataSource() // 2
    populatedItems() // 3
  }

  typealias DataSource = UITableViewDiffableDataSource<Section, DemoItem>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DemoItem>

  private var dataSource: DataSource?

  private let reuseIdentifier = "reuseTableIdentifier"

  private func setupDataSource() {
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tv, index, item) -> UITableViewCell? in
      let cell = tv.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: index)
      cell.textLabel?.text = item.name
      cell.accessoryType = .disclosureIndicator
      return cell
    })
  }

  private func populatedItems() {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(demos)
    dataSource?.apply(snapshot)
  }
}
