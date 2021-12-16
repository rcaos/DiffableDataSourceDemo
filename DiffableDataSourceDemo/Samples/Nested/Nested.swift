//
//  Nested.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import UIKit

enum Nested: Hashable {
  case title(title: String)
  case collection(quantity: Int)

  func heightSize() -> CGFloat {
    switch self {
    case .title:
      return 44
    case .collection:
      return 100
    }
  }
}
