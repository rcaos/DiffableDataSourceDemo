//
//  DemoItem.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import Foundation

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
