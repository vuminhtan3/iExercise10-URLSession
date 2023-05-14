//
//  PhotosViewController.swift
//  iExercise10-URLSession
//
//  Created by Minh Tan Vu on 14/05/2023.
//

import UIKit

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}

class PhotosViewController: UIViewController {

    @IBOutlet weak var photosTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        photosTextView.text = ""
        photosTextView.isEditable = false
        
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        loadData(urlString)
        
    }

    func loadData(_ urlString: String) {
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        
        let url = URL(string: urlString)!
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                fatalError("Error data")
            }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                
                for photo in photos {
                    DispatchQueue.main.async {
                        self.photosTextView.text += "Album ID: \(photo.albumId)\n"
                        self.photosTextView.text += "ID: \(photo.id)\n"
                        self.photosTextView.text += "Title: \(photo.title!)\n"
                        let url = photo.url
                        self.photosTextView.text += "URL: \(photo.url!)\n"
                        self.photosTextView.text += "Thumbnail URL: \(photo.thumbnailUrl!)\n"
                        self.photosTextView.text += "--------------\n"
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
