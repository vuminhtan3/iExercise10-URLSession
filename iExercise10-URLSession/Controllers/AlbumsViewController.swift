//
//  AlbumsViewController.swift
//  iExercise10-URLSession
//
//  Created by Minh Tan Vu on 14/05/2023.
//

import UIKit

struct Album: Codable {
    let userId: Int
    let id: Int
    var title: String?
}

class AlbumsViewController: UIViewController {

    @IBOutlet weak var albumsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsTextView.text = ""
        albumsTextView.isEditable = false
        
        let urlString = "https://jsonplaceholder.typicode.com/albums"
        loadData(urlString)
    }
    
    func loadData(_ urlString: String) {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        
        let url = URL(string: urlString)!
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let data = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                fatalError("Error data")
            }
            do {
                let albums = try JSONDecoder().decode([Album].self, from: data)
                
                for album in albums {
                    DispatchQueue.main.async {
                        self.albumsTextView.text += "User ID: \(album.userId)\n"
                        self.albumsTextView.text += "ID: \(album.id)\n"
                        self.albumsTextView.text += "Title: \(album.title!)\n"
                        self.albumsTextView.text += "-----------------\n"
                    }
                }
            } catch {
                print(error)
            }
        }
        data.resume()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
