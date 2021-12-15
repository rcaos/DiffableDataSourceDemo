//
//  LabelHeaderCell.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import UIKit

final class LabelHeaderCell: UICollectionReusableView {

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize,weight: .bold)
    label.adjustsFontForContentSizeCategory = true
    label.textColor = .label
    label.textAlignment = .left
    label.numberOfLines = 1
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .secondarySystemBackground
    addSubview(titleLabel)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor)
    ])
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
