//
//  NestedCollectionCell.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import UIKit

final class NestedCollectionCell: UICollectionViewCell {

  lazy var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return layout
  }()
  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = UIColor.systemBackground
    contentView.addSubview(collectionView)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = contentView.bounds
  }

  private let reuseIdentifierCell = "reuseTableIdentifier"
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>

  private var dataSource: DataSource?

  func setup() {
    collectionView.register(CenterLabelCell.self, forCellWithReuseIdentifier: reuseIdentifierCell)
    collectionView.delegate = self
    setupDataSource()
  }

  private func setupDataSource() {
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] cv, index, model in
      self?.configureCell(collectionView: cv, index: index, item: model)
    })
  }

  private func configureCell(collectionView: UICollectionView, index: IndexPath, item: Int) -> UICollectionViewCell? {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCell, for: index) as? CenterLabelCell else {
      fatalError()
    }
    cell.text = "\(item)"
    cell.backgroundColor = .systemRed
    return cell
  }

  // MARK: - Public
  public func configureCell(quantity: Int) {
    var snapshot = Snapshot()
    snapshot.appendSections([0])

    let items = (0...quantity).map { $0 }
    snapshot.appendItems(items)
    dataSource?.apply(snapshot)
  }
}

extension NestedCollectionCell: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: contentView.frame.height, height: contentView.frame.height)
  }
}
