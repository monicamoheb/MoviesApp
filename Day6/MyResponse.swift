//
//  MyResponse.swift
//  Day6
//
//  Created by JETS Mobile Lab8 on 08/05/2023.
//

import Foundation
class MyResponse: Decodable {
    var items: [Item]?
    var errorMessage: String?

    init(items: [Item]?, errorMessage: String?) {
        self.items = items
        self.errorMessage = errorMessage
    }
}


// MARK: - Item
class Item: Decodable {
    var id, rank, title: String?
    var image: String?
    var weekend, gross, weeks: String?

    init(id: String?, rank: String?, title: String?, image: String?, weekend: String?, gross: String?, weeks: String?) {
        self.id = id
        self.rank = rank
        self.title = title
        self.image = image
        self.weekend = weekend
        self.gross = gross
        self.weeks = weeks
    }
    init(){
        
    }
}

func downloadData(compilitionHandler: @escaping (MyResponse?) -> Void){
//    1- url
    let url = URL(string: "https://imdb-api.com/en/API/BoxOffice/k_3jb3naz8")
    guard let urlFinal = url else {
        return
    }
    
//     2- request
    let request = NSMutableURLRequest(url: urlFinal)
    
//    3- session take configuration
    let session = URLSession(configuration: .default)
    
//    4- create task that will execute end point of api
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        
        guard let data = data else {
            return
        }
        do{
            let result = try JSONDecoder().decode(MyResponse.self, from: data)
            compilitionHandler(result)
            print(result.items?[0].title ?? "no title")
        }catch let error {
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    
//    5- start task
    task.resume()
    
}

