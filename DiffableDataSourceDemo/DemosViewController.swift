//
//  DemosViewController.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 12/12/21.
//

import UIKit

struct DemoItem {
  let name: String
  let controllerClass: UIViewController.Type
  let controllerIdentifier: String?

  init(name: String, controllerClass: UIViewController.Type, controllerIdentifier: String? = nil) {
    self.name = name
    self.controllerClass = controllerClass
    self.controllerIdentifier = controllerIdentifier
  }
}

class DemosViewController: UIViewController {

  let collectionView = UICollectionView(frame: .zero)

  let demos: [DemoItem] = [
    DemoItem(name: "Diff Algorithm",
             controllerClass: DiffTableViewController.self)
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Demos"
    view.addSubview(collectionView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
}

