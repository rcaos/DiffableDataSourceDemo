//
//  SuplementaryViewsController.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import UIKit

class SuplementaryViewsController: UIViewController {

  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Suplementary Views"
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

  private func setupCollection() {
    collectionView.register(LabelHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier) // A
    collectionView.register(LabelCell.self, forCellWithReuseIdentifier: reuseIdentifier) // 1
    collectionView.delegate = self
    setupDataSource()
    populatedItems()
  }

  typealias DataSource = UICollectionViewDiffableDataSource<SectionFeed, Comment>
  typealias Snapshot = NSDiffableDataSourceSnapshot<SectionFeed, Comment>

  // 0: I need a Strong Reference to a UITableViewDiffableDataSource
  private var dataSource: DataSource?

  private let reuseIdentifier = "reuseTableIdentifier"
  private let reuseHeaderIdentifier = "reuseHeaderTableIdentifier"

  private func setupDataSource() {
    // Here the connection happens.
    // The Diffable with the global tableView 👇
    // 2
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] cv, index, model in
      self?.configureCell(collectionView: cv, index: index, item: model)
    })

    // B
    dataSource?.supplementaryViewProvider = { collectionView, kind, index in
      guard kind == UICollectionView.elementKindSectionHeader else {
        return nil
      }

      let view = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: self.reuseHeaderIdentifier,
        for: index) as? LabelHeaderCell

      let section = self.dataSource?.snapshot().sectionIdentifiers[index.section]

      switch section {
      case .user(let user):
        view?.titleLabel.text = user.name
      case .none:
        break
      }

      return view
    }
  }

  private func configureCell(collectionView: UICollectionView, index: IndexPath, item: Comment) -> UICollectionViewCell? {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: index) as? LabelCell else {
      fatalError()
    }
    cell.text = item.comment
    return cell
  }

  let feedItems = [
    FeedItem(pk: 1, user: User(pk: 100, name: "Jesse", handle: "jesse_squires"),
             comments: [ "You rock!", "Hmm you sure about that?"].map { .init(comment: $0) }) ,
    FeedItem(pk: 2, user: User(pk: 101, name: "Ryan", handle: "_ryannystrom"),
             comments: ["lgtm", "lol", "Let's try it!"].map { .init(comment: $0) } ),
    FeedItem(pk: 3, user: User(pk: 102, name: "Ann", handle: "abaum"),
             comments: ["Good luck!"].map { .init(comment: $0) }),
    FeedItem(pk: 4, user: User(pk: 103, name: "Phil", handle: "phil"),
             comments: ["yoooooooo", "What's the eta?", "Nothing", "Maybe", "Again", "Lose", "Fringe"].map { .init(comment: $0) })
  ]

  private func populatedItems() {
    var snapshot = Snapshot()

    feedItems.forEach {
      let section = SectionFeed.user(model: $0.user)
      snapshot.appendSections([section])
      snapshot.appendItems($0.comments, toSection: section)
    }

    // 3
    dataSource?.apply(snapshot)
  }
}

extension SuplementaryViewsController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 50)
  }

  // C
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 50)
  }
}
