//
//  CommentsViewController.swift
//  iExercise10-URLSession
//
//  Created by Minh Tan Vu on 14/05/2023.
//

import UIKit

struct Comment: Codable {
    let postId: Int
    let id: Int
    var name: String?
    var email: String?
    var body: String?
}

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTextView.text = ""
        commentsTextView.isEditable = false
        
        let urlString = "https://jsonplaceholder.typicode.com/comments"

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
                let comments = try JSONDecoder().decode([Comment].self, from: data)
                
                for comment in comments {
                    DispatchQueue.main.async {
                        self.commentsTextView.text += "Post ID: \(comment.postId)\n"
                        self.commentsTextView.text += "ID: \(comment.id)\n"
                        self.commentsTextView.text += "Name: \(comment.name!)\n"
                        self.commentsTextView.text += "Email: \(comment.email!)\n"
                        self.commentsTextView.text += "Comment: \(comment.body!)\n"
                        self.commentsTextView.text += "----------------\n"
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
