//
//  DemoItem.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import Foundation
import UIKit

struct DemoItem: Hashable {
  let name: String
  let viewType: ViewScenes

  init(name: String, viewType: ViewScenes) {
    self.name = name
    self.viewType = viewType
  }

//  func hash(into hasher: inout Hasher) {
//    hasher.combine(identifier)
//  }

  // ‼️ Because I uses native types
  // This method is not needed 👇

//  static func == (lhs: DemoItem, rhs: DemoItem) -> Bool {
//    return lhs.name == rhs.name &&
//      lhs.identifier == rhs.identifier
//  }
}

enum Section {
  case main
}

// MARK: - Available scenes
enum ViewScenes: String {
  case diffTable
  case supplementaryViews

  func getInstance() -> UIViewController {
    switch self {
    case .diffTable:
      return DiffTableViewController()
    case .supplementaryViews:
      return SuplementaryViewsController()
    }
  }
}
