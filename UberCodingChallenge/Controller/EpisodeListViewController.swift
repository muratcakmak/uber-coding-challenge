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
import SDWebImage


class EpisodeListViewController: UITableViewController {

  var items: [EpisodeListItem]

  required init?(coder aDecoder: NSCoder) {
    items = [EpisodeListItem]()
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    downloadEpisodeList()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

// Table view's delegate functions
extension EpisodeListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        // Access UI elements by tag. Defined on Interface Builder.
        let thumbnail = cell.viewWithTag(100) as! UIImageView
        thumbnail.sd_setImage(with: item.imageURL, placeholderImage: UIImage(named: "placeholder.png"))

        let name = cell.viewWithTag(101) as! UILabel
        name.text = item.name

        let airdate = cell.viewWithTag(102) as! UILabel
        airdate.text = "Air Date: \(item.airdate)"

        let episode = cell.viewWithTag(103) as! UILabel
        episode.text = "S\(item.season)E\(item.number)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



// Network requests
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
                self.parse(json: json)
                print(self.items.description)
            } catch {
                print("Error occured while requesting data")
            }
        }
    }
    
    private func parse(json: JSON) {
        // Access episodes array, fetch attributes, create an EpisodeListItem struct, put it into items array
        for episode in json["_embedded"]["episodes"].arrayValue {
            let id = episode["id"].intValue
            let name = episode["name"].stringValue
            let season = episode["season"].intValue
            let number = episode["number"].intValue
            let airdate = episode["airdate"].stringValue
            let medium = episode["image"]["medium"].stringValue
            let imageURL = URL(string: medium)!
            let item = EpisodeListItem(id: id, name: name, season: season, number: number, airdate: airdate, imageURL: imageURL)
            self.items.append(item)
        }
        // Sorts episodes by their ids
        self.items.sort { $0.id < $1.id }
        
        // Update cells
        tableView.reloadData()
    }
}
