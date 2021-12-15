//
//  FeedItem.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 15/12/21.
//

import Foundation

// MARK: Domain
struct FeedItem {
  let pk: Int
  let user: User
  let comments: [Comment]

  init(pk: Int, user: User, comments: [Comment]) {
    self.pk = pk
    self.user = user
    self.comments = comments
  }
}

struct User: Hashable {
  let pk: Int
  let name: String
  let handle: String

  init(pk: Int, name: String, handle: String) {
    self.pk = pk
    self.name = name
    self.handle = handle
  }
}


// MARK: - Needed to CollectionView
struct Comment: Hashable {
  let comment: String
}

enum SectionFeed: Hashable {
  case user(model: User)
}
