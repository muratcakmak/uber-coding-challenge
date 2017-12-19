//
//  EpisodeListViewController.swift
//  UberCodingChallenge
//
//  Created by muratcakmak on 19.12.2017.
//  Copyright © 2017 Murat Cakmak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EpisodeListViewController: UITableViewController {

  var items: [EpisodeListItem]

  required init?(coder aDecoder: NSCoder) {
    items = [EpisodeListItem]()
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    downloadEpisodeList()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}


extension EpisodeListViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeItem", for: indexPath)
    return cell
  }
}


extension EpisodeListViewController {
  func downloadEpisodeList() {
    Alamofire.request(
      "https://api.tvmaze.com/singlesearch/shows?q=silicon-valley&embed=episodes",
      encoding: JSONEncoding.default
      )
      .responseJSON { response in
        guard response.result.isSuccess else {
          print("Error while fetching tags: \(String(describing: response.result.error))")
          return
        }
        guard let responseData = response.data else {
          return
        }
        do {
            let json = try JSON(data: responseData)
            let episodes = json["_embedded"]["episodes"]

            print(episodes.description)
        } catch {
            print("Error occured while requesting data")
        }
    }
  }
}
