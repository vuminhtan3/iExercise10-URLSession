//
//  PostsViewController.swift
//  iExercise10-URLSession
//
//  Created by Minh Tan Vu on 14/05/2023.
//

import UIKit

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let body: String?
}

class PostsViewController: UIViewController {

    @IBOutlet weak var postsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTextView.text = ""
        postsTextView.isEditable = false
        
        let urlString = "https://jsonplaceholder.typicode.com/posts"
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
                let posts = try JSONDecoder().decode([Post].self, from: data)
                
                for post in posts {
                    DispatchQueue.main.async {
                        self.postsTextView.text += "User ID: \(post.userId)\n"
                        self.postsTextView.text += "ID: \(post.id)\n"
                        self.postsTextView.text += "Title: \(post.title!)\n"
                        self.postsTextView.text += "Post: \(post.body!)\n"
                        self.postsTextView.text += "-----------------\n"
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
