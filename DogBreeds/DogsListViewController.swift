//
//  DogsListViewController.swift
//  DogBreeds
//
//  Created by Group1 on 03/02/22.
//

import UIKit

class DogsListViewController: UITableViewController {

    fileprivate var breeds = [String : [String]]()
    
    fileprivate var breedNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.fetchDogBreeds()
    }

    // MARK: - API Call
    
    private func fetchDogBreeds(){
        
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let jsonData = data {
                
                let json  = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
                
                if let allData = json?["message"] as? [String : [String]]{
                    
                    self.processData(allData)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()

    }
    
    func fetchRandomImage(_ completion: @escaping(String) -> Void)  {
        
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let jsonData = data {
                
                let json  = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
                
        
                if let allData = json?["message"] as? String{
                    
                  completion(allData)
                }
                
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    // MARK:- Data Processing
    
    private func processData(_ data: [String : [String]]){
        
        self.breeds = data
        
        self.breedNames = data.keys.map{ $0 }.sorted()
        
        print(self.breedNames)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.breedNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        //cell.textLabel?.text = self.breedNames[indexPath.row]

        if let lblBreed = cell.viewWithTag(100) as? UILabel{
            lblBreed.text = "\(self.breedNames[indexPath.row]):"
        }
        
        if let lblSubBreed = cell.viewWithTag(101) as? UILabel{
            
            if let subBreeds = self.breeds[self.breedNames[indexPath.row]] {
                lblSubBreed.text = subBreeds.count > 0 ? subBreeds[0] : ""
            }
            
        }
        
        if let imageView = cell.viewWithTag(102) as? UIImageView{
            
            
                self.fetchRandomImage { imageURL in
                   
                        let url = URL(string: imageURL)!

                            // Fetch Image Data
                            if let data = try? Data(contentsOf: url) {
                                // Create Image and Update Image View
                                DispatchQueue.main.async {
                                    imageView.image = UIImage(data: data)
                                    
                                }
                            }
                }
        }
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
