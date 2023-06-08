//
//  FavTableViewController.swift
//  Day6
//
//  Created by JETS-Mobile Lab2 on 11/05/2023.
//

import UIKit

class FavTableViewController: UITableViewController {
    
    var coreDataFav = CoreDataFav.sharedMovieDB
    var favMovies = Array<Item>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        favMovies = coreDataFav.fetchAll()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favMovies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        
        cell.textLabel?.text = favMovies[indexPath.row].title
        var img = URL(string: favMovies[indexPath.row].image!)
        cell.imageView?.kf.setImage(with: img)
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select")
        let details = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        details.currentMovie = favMovies[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
    }
}
