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
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play,
                                                        target: self,
                                                        action: #selector(DiffTableViewController.onDiff))
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    setupTable()
  }

  @objc func onDiff() {
    let from = people
    let to = usingOldPeople ? newPeople : oldPeople
    usingOldPeople = !usingOldPeople
    people = to

    populatedItems(with: people)

    //let result = ListDiffPaths(fromSection: 0, toSection: 0, oldArray: from, newArray: to, option: .equality).forBatchUpdates()

//    tableView.beginUpdates()
//    tableView.deleteRows(at: result.deletes, with: .fade)
//    tableView.insertRows(at: result.inserts, with: .fade)
//    result.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
//    tableView.endUpdates()
  }

  // MARK: UITableViewDataSource

//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return people.count
//  }
//
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    cell.textLabel?.text = people[indexPath.row].name
//    return cell
//  }
  private func setupTable() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier) // 1
    setupDataSource() // 2
    populatedItems(with: oldPeople) // 3
  }

  typealias DataSource = UITableViewDiffableDataSource<Section, Person>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Person>

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
    snapshot.appendSections([.main])
    snapshot.appendItems(model)
    dataSource?.apply(snapshot)
  }

}
