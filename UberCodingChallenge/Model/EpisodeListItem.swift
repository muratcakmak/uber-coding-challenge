//
//  EpisodeListItem.swift
//  UberCodingChallenge
//
//  Created by muratcakmak on 19.12.2017.
//  Copyright © 2017 Murat Cakmak. All rights reserved.
//

import Foundation

struct EpisodeListItem {
  let id: Int
  let name: String 
  private let season: Int
  private let number: Int
  let episode: String
  let airdate: String
  let imageURL: URL

  init(id: Int, name:String, season: Int, number:Int, airdate:String, imageURL: URL) {
    self.id = id
    self.name = name
    self.season = season
    self.number = number
    self.airdate = airdate
    self.imageURL = imageURL
    self.episode = "S\(self.season)E\(self.number)"
  }
}
