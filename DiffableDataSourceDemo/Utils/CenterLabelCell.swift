//
//  CenterLabelCell.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import UIKit

final class CenterLabelCell: UICollectionViewCell {
  
  lazy private var label: UILabel = {
    let view = UILabel()
    view.backgroundColor = .clear
    view.textAlignment = .center
    view.textColor = .white
    view.font = .boldSystemFont(ofSize: 18)
    self.contentView.addSubview(view)
    return view
  }()
  
  var text: String? {
    get {
      return label.text
    }
    set {
      label.text = newValue
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    label.frame = contentView.bounds
  }
}
