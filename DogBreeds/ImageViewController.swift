//
//  ImageViewController.swift
//  DogBreeds
//
//  Created by Group1 on 09/03/22.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let data = imageData{
            self.imageView.image = UIImage(data: data)
        }
        
    }
    
    // MARK:- IBAction
    
    @IBAction func featchNewImage(_ sender: UIButton) {
        
        // Change button title to show call status
        
        sender.setTitle("Fetching..", for: .normal)
        
        APIManager.shared.fetchRandomImage { imageData in
           
                    // Add image from Data
                    DispatchQueue.main.async {
                        
                        self.imageView.image = UIImage(data: imageData)
                        
                        // Reset button title 
                        
                        sender.setTitle("Refresh", for: .normal)
                    }
                   
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
