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
    DemoItem(name: "Diff Algorithm", viewType: .diffTable),
    DemoItem(name: "Supplementary Views", viewType: .supplementaryViews),
    DemoItem(name: "Nested", viewType: .nested)
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
    tableView.delegate = self

    setupDataSource()
    populatedItems()
  }

  typealias DataSource = UITableViewDiffableDataSource<Section, DemoItem>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DemoItem>

  // 0: I need a Strong Reference to a UITableViewDiffableDataSource
  private var dataSource: DataSource?

  private let reuseIdentifier = "reuseTableIdentifier"

  private func setupDataSource() {
    // Here the connection happens.
    // The Diffable with the global tableView 👇
    // 2
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tv, index, item) -> UITableViewCell? in
      let cell = tv.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: index)
      cell.textLabel?.text = item.name
      cell.accessoryType = .disclosureIndicator
      cell.selectionStyle = .none
      return cell
    })
  }

  private func populatedItems() {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(demos)

    // 3
    dataSource?.apply(snapshot)
  }
}

// MARK: - UITableViewDelegate
extension DemosViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let dataSource = dataSource else {
      return
    }

    // Way #1
//    let snapshot = dataSource.snapshot()
//    let section = snapshot.itemIdentifiers(inSection: .main)
//    let item = section[indexPath.row]
//    print("Has selected: [\(item)]")

    // Way #2
    if let item = dataSource.itemIdentifier(for: indexPath) {
      print("B: SelectedItem=[\(item)]")
      navigationController?.pushViewController(item.viewType.getInstance(), animated: true)
    }
  }
}
