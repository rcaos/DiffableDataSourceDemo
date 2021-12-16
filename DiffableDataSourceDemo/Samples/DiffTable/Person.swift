//
//  Person.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import Foundation

struct Person: Hashable {
  let pk: Int
  let name: String

  init(pk: Int, name: String) {
    self.pk = pk
    self.name = name
  }
}
