//
//  TableViewController.swift
//  Day6
//
//  Created by JETS Mobile Lab8 on 08/05/2023.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    
    var moviesList : Array<Item> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData {(result) in
            DispatchQueue.main.async { [self] in
                moviesList = (result?.items)!
                print(String((result?.items!.count)!))
                print(moviesList[0].image ?? " not title ")
                tableView.reloadData()
            }
        }

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = moviesList[indexPath.row].title
        
        KF.url(URL(string: moviesList[indexPath.row].image!))
        .placeholder(UIImage(named: "err.png"))
        .set(to: cell.imageView!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Movies"
    }
    
}
