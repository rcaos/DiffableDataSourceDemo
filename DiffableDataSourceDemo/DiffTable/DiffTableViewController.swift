//
//  DiffTableViewController.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 12/12/21.
//

import UIKit

final class DiffTableViewController: UITableViewController {

  let oldPeople = [
    Person(pk: 1, name: "Kevin"),
    Person(pk: 2, name: "Mike"),
    Person(pk: 3, name: "Ann"),
    Person(pk: 4, name: "Jane"),
    Person(pk: 5, name: "Philip"),
    Person(pk: 6, name: "Mona"),
    Person(pk: 7, name: "Tami"),
    Person(pk: 8, name: "Jesse"),
    Person(pk: 9, name: "Jaed")
  ]
  let newPeople = [
    Person(pk: 2, name: "Mike"),
    Person(pk: 10, name: "Marne"),
    Person(pk: 5, name: "Philip"),
    Person(pk: 1, name: "Kevin"),
    Person(pk: 3, name: "Ryan"),
    Person(pk: 8, name: "Jesse"),
    Person(pk: 7, name: "Tami"),
    Person(pk: 4, name: "Jane"),
    Person(pk: 9, name: "Chen")
  ]

  lazy var people: [Person] = {
    return self.oldPeople
  }()
  var usingOldPeople = true

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupTable()
  }

  private func setupNavigation() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play,
                                                        target: self,
                                                        action: #selector(onDiff))
  }

  @objc func onDiff() {
    let to = usingOldPeople ? newPeople : oldPeople
    usingOldPeople = !usingOldPeople
    people = to

    populatedItems(with: people)
  }

  private func setupTable() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier) // 1
    setupDataSource() // 2
    populatedItems(with: oldPeople) // 3
  }

  typealias DataSource = UITableViewDiffableDataSource<Int, Person>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Person>

  private var dataSource: DataSource?

  private let reuseIdentifier = "cell"

  private func setupDataSource() {
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tv, index, item) -> UITableViewCell? in
      let cell = tv.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: index)
      cell.textLabel?.text = item.name
      cell.accessoryType = .disclosureIndicator
      return cell
    })
  }

  private func populatedItems(with model: [Person]) {
    var snapshot = Snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(model)
    dataSource?.apply(snapshot)
  }
}
