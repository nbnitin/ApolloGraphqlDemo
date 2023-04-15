//
//  ViewController.swift
//  ApolloExample
//
//  Created by Nitin Bhatia on 12/04/23.
//

import UIKit
import Apollo
import StarWarsAPI

//you can't create and use your own model, but what if we require to do so then you can create extension of graphql generated model and use it like below
struct ki {
    let c : String?
}

extension GetCharsQuery.Data.EpisodesById {
    
    
    
    
    func prints()->ki {
       return ki(c: id)
    }
    
}


class ViewController: UIViewController {
    
    var character : [GetCharsQuery.Data.EpisodesById?]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let cc = ApolloNetwork.shared.apollo
    
       
        ApolloNetwork.shared.apollo.fetch(query: GetCharsQuery() , cachePolicy: .fetchIgnoringCacheCompletely) {result in
            switch result {
            case .success(let graphQLResult):
                if let name = graphQLResult.data?.episodesByIds {
                    print(name) // Luke Skywalker
                    self.character = name
                    
                    print(self.character?[0]?.prints())
                    
                } else if let errors = graphQLResult.errors {
                    // GraphQL errors
                    print(errors)
                }
            case .failure(let error):
                // Network or response format errors
                print(error.localizedDescription)
            }
        }
        
       
    }


}

