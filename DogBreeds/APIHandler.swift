//
//  Constants.swift
//  DogBreeds
//
//  Created by Group1 on 09/03/22.
//

import Foundation

class APIManager {
    
    let baseURL = "https://dog.ceo/api/breeds/"
    let randomImage = "image/random"
    let breedList = "list/all"
    
    static let shared = APIManager()
    
    // MARK: API Calls
    
    func fetchRandomImage(_ completion: @escaping(Data) -> Void)  {
        
        let url = URL(string: self.baseURL + self.randomImage)!
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let jsonData = data {
                
                let json  = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
                
        
                if let imageURL = json?["message"] as? String{
                    
                    let url = URL(string: imageURL)!

                        // Fetch Image Data
                        if let data = try? Data(contentsOf: url) {
                            // Create Image and Update Image View
                            completion(data)
                        }
            }
                    
                
            } else if let error = error {
                print("Request Failed \(error)")
            }
        }
        task.resume()
    }
    
}
