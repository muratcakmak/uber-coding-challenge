//
//  EpisodeListViewController.swift
//  UberCodingChallenge
//
//  Created by muratcakmak on 19.12.2017.
//  Copyright © 2017 Murat Cakmak. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}


extension EpisodeListViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeItem", for: indexPath)
    return cell
  }
}
