import UIKit
import Alamofire

class PetTableViewController: UITableViewController {
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
           fetchBooksData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        return cell
    }
    
    private func fetchBooksData() {
        NetworkManager.shared.fetchBooks { fetchedBooks in
            DispatchQueue.main.async {
                self.books = fetchedBooks ?? []
                self.tableView.reloadData()
            }
        }
    }

}

