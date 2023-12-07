import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var Members = [ConfigItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let member = Members[indexPath.row]
        
        cell.textLabel?.text = member.a.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MemberViewController {
            destination.member = Members[tableView.indexPathForSelectedRow!.row]
            
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string:"https://hamrahplus23.bankmellat.ir/mcpn/config")
        
        
        URLSession.shared.dataTask(with: url!) { data,
            response , error in
            
            if data != nil {
                do {
                    let res = try JSONDecoder().decode([ConfigItem].self, from: data!)
                       
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                    
                   
                }
                catch {
                    print(String(describing: error))
                }
            }
        }.resume()
    }
}

