//
//  TodosViewController.swift
//  iExercise10-URLSession
//
//  Created by Minh Tan Vu on 14/05/2023.
//

import UIKit

struct Todo: Codable {
    let userId: Int
    let id: Int
    var title: String?
    var completed: Bool?
}

class TodosViewController: UIViewController {

    @IBOutlet weak var todosTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        todosTextView.text = ""
        todosTextView.isEditable = false
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        loadData(urlString)
    }
    
    func loadData(_ urlString: String) {
        //Khởi tạo cấu hình cho URL:
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        
        //Khởi tạo URL
        let url = URL(string: urlString)!
        
        //Khởi tạo session
        let session = URLSession(configuration: sessionConfiguration)
        
        //Khởi tạo task
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                fatalError("Error data")
            }
            
            do {
                let todos = try JSONDecoder().decode([Todo].self, from: data)
                
                for todo in todos {
//                    let boldFont = UIFont.boldSystemFont(ofSize: 20)
//                    let bold: [NSAttributedString.Key: Any] = [.font: boldFont]
//                    let red: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
//                    let green: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.green]
                    DispatchQueue.main.async {
//                        let userIDText = NSMutableAttributedString(string: String(todo.userId),attributes: bold)
//                        let completedText = NSMutableAttributedString(string: "Completed\n", attributes: green)
//                        let incompletedText = NSMutableAttributedString(string: "Incompleted\n", attributes: red)
                        self.todosTextView.text += "User ID: \(todo.userId)\n"
                        self.todosTextView.text += "ID: \(todo.id)\n"
                        self.todosTextView.text += "Todo Title: \(todo.title!)\n"
                        if todo.completed ?? false {
                            self.todosTextView.text += "Completed"
                        } else {
                            self.todosTextView.text += "Incompleted"
                        }
                        self.todosTextView.text += "-----------------\n"
                    }
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
