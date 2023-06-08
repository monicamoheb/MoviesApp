//
//  MovieCollectionViewController.swift
//  Day6
//
//  Created by JETS Mobile Lab8 on 08/05/2023.
//

import UIKit
import Kingfisher
import Reachability

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

    var moviesList : Array<Item> = []
    var coreData = CoreDataDB.sharedMovieDB
    override func viewDidLoad() {
        super.viewDidLoad()

        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            downloadData {(result) in
                DispatchQueue.main.async { [self] in
                    moviesList = (result?.items)!
                    coreData.deleteAll()
                    coreData.insert(movieArray: moviesList)
                    print(String((result?.items!.count)!))
                    print(moviesList[0].image ?? " not title ")
                    collectionView.reloadData()
                }
            }
        }
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        moviesList = coreData.fetchAll()
        collectionView.reloadData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return moviesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.title?.text = moviesList[indexPath.row].title
        
        KF.url(URL(string: moviesList[indexPath.row].image!))
        .placeholder(UIImage(named: "err.png"))
        .set(to: cell.img!)
     
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2-10), height: 200)
     }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select")
        let details = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        details.currentMovie = moviesList[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
       
    }
}
