//
//  DetailsViewController.swift
//  Day6
//
//  Created by JETS Mobile Lab8 on 08/05/2023.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    var currentMovie : Item = Item(id: "", rank: "", title: "", image: "", weekend: "", gross: "", weeks: "")
    
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var date2: UILabel!
    @IBOutlet weak var title2: UILabel!
    var coreData = CoreDataDB.sharedMovieDB
    var coreDataFav = CoreDataFav.sharedMovieDB
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentMovie.title ?? "no title")
        title2.text = currentMovie.title
        date2.text = currentMovie.rank
        
        KF.url(URL(string: currentMovie.image!))
            .placeholder(UIImage(named: "err.png"))
        .set(to: img2)
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        
        let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "ARE YOU SURE TO DELETE?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
            self?.coreData.deleteMovie(newMovie: self?.currentMovie ?? Item(id: "", rank: "", title: "", image: "", weekend: "", gross: "", weeks: ""))
            self?.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
        
       
    }
    
    @IBAction func addToFav(_ sender: UIButton) {
        print("faav")
        coreDataFav.insert(movieArray: [currentMovie])
        self.navigationController?.popViewController(animated: true)
    }
}
