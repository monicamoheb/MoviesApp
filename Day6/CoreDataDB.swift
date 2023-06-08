//
//  CoreDataDB.swift
//  Day6
//
//  Created by JETS-Mobile Lab2 on 10/05/2023.
//

import UIKit
import CoreData

class CoreDataDB {
    static let sharedMovieDB = CoreDataDB()
    
    var manager : NSManagedObjectContext!
    var movies : [NSManagedObject] = []
    
   private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    func insert (movieArray : [Item]){
        //2-
        
        for newMovie in movieArray{
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: manager)
            //3-
            let movie = NSManagedObject(entity: entity!, insertInto: manager)
            movie.setValue(newMovie.title, forKey: "title")
            movie.setValue(newMovie.image, forKey: "image")
            movie.setValue(newMovie.rank, forKey: "rank")
            
            //4-
            do{
                try manager.save()
                print("Saved!")
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAll()-> Array<Item>{
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Movie")
    
        do{
            movies = try manager.fetch(fetch)
        }catch let error{
            print(error.localizedDescription)
        }
        var movie = Item()
        var movieList = Array<Item>()
        for item in movies{
            
            movie.title = item.value(forKey: "title") as? String
            movie.image = item.value(forKey: "image") as? String
            movie.rank = item.value(forKey: "rank") as? String
            
            movieList.append(movie)
            movie = Item()
        }
        return movieList
    }
    
    func deleteMovie(newMovie:Item){
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        var movies = self.fetchAll()
        
        let predicate = NSPredicate(format: " title == %@", newMovie.title ?? "")
        fetch.predicate = predicate
        
        var fetchObject = [NSManagedObject]()
        do{
            fetchObject = try manager.fetch(fetch)

        }catch let error{
            print(error.localizedDescription)
        }
        manager.delete(fetchObject[0])
        do{
            try manager.save()
            print("Deleted!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func deleteAll (){
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Movie")
    
        do{
            movies = try manager.fetch(fetch)
        }catch let error{
            print(error.localizedDescription)
        }
        
        for item in movies{
            manager.delete(item)
        }
        do{
            try manager.save()
            print("Deleted all!")
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
}
