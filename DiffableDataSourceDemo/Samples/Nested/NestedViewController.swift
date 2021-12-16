//
//  NestedViewController.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import UIKit

class NestedViewController: UIViewController {

  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Nested View"
    view.addSubview(collectionView)
    setupCollection()
  }

  deinit {
    print("Deinit \(Self.self)")
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }

  private let reuseNestedIdentifier = "reuseTableIdentifier"
  private let reuseIdentifier = "reuseNestedTableIdentifier"

  private func setupCollection() {
    collectionView.register(LabelCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.register(NestedCollectionCell.self, forCellWithReuseIdentifier: reuseNestedIdentifier)
    collectionView.delegate = self
    setupDataSource()
    populatedItems()
  }

  typealias DataSource = UICollectionViewDiffableDataSource<Int, Nested>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Nested>

  private var dataSource: DataSource?

  private func setupDataSource() {
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] cv, index, model in
      self?.configureCell(collectionView: cv, index: index, item: model)
    })
  }

  private func configureCell(collectionView: UICollectionView, index: IndexPath, item: Nested) -> UICollectionViewCell? {
    switch item {
    case .title(let title):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: index) as? LabelCell else {
        fatalError()
      }
      cell.text = title
      return cell
    case .collection(let quantity):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseNestedIdentifier, for: index) as? NestedCollectionCell else {
        fatalError()
      }
      cell.configureCell(quantity: quantity)
      return cell
    }
  }

  private func populatedItems() {
    let snapshot = buildSnapshot()
    dataSource?.apply(snapshot)
  }
}

extension NestedViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = dataSource?.itemIdentifier(for: indexPath)?.heightSize() ?? 44
    return CGSize(width: collectionView.frame.width, height: height)
  }
}

extension NestedViewController {
  private func buildSnapshot() -> Snapshot {
    var snapshot = Snapshot()

    snapshot.appendSections([0])
    snapshot.appendItems([
      .title(title: "Ridiculus Elit Tellus Purus Aenean"),
      .title(title: "Condimentum Sollicitudin Adipiscing")
    ])
    snapshot.appendSections([1])
    snapshot.appendItems([
      .collection(quantity: 14)
    ])
    snapshot.appendSections([2])
    snapshot.appendItems([
      .title(title: "Ligula Ipsum Tristique Parturient Euismod"),
      .title(title: "Purus Dapibus Vulputate")
    ])
    snapshot.appendSections([3])
    snapshot.appendItems([
      .collection(quantity: 6)
    ])
    snapshot.appendSections([4])
    snapshot.appendItems([
      .title(title: "Tellus Nibh Ipsum Inceptos")
    ])
    snapshot.appendSections([5])
    snapshot.appendItems([
      .collection(quantity: 2)
    ])
    return snapshot
  }
}
