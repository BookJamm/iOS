//
//  LikeActivityTableViewController.swift
//  Bookjam
//
//  Created by 장준모 on 2023/09/07.
//

import UIKit

class LikeActivityTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(LikeActivityTableViewCell.self, forCellReuseIdentifier: LikeActivityTableViewCell().cellID)
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikeActivityTableViewCell().cellID, for: indexPath) as! LikeActivityTableViewCell

        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

}
