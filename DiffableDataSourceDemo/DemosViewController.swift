//
//  DemosViewController.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 12/12/21.
//

import UIKit

struct DemoItem: Hashable {
  let name: String
  let identifier: String

  init(name: String, identifier: String) {
    self.name = name
    self.identifier = identifier
  }

//  func hash(into hasher: inout Hasher) {
//    hasher.combine(identifier)
//  }

  static func == (lhs: DemoItem, rhs: DemoItem) -> Bool {
    return lhs.name == rhs.name &&
      lhs.identifier == rhs.identifier
  }
}

enum Section {
  case main
}

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


    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

    setupDataSource()
    populatedItems()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  typealias DataSource = UITableViewDiffableDataSource<Section, DemoItem>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DemoItem>

  private var dataSource: DataSource!

  private let reuseIdentifier = "tableIdentifier"

  func setupDataSource() {
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tv, index, item) -> UITableViewCell? in
      let cell = tv.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: index)
      cell.textLabel?.text = item.name
      cell.accessoryType = .disclosureIndicator
      return cell
    })
  }

  func populatedItems() {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(demos)
    dataSource.apply(snapshot)
  }
}
