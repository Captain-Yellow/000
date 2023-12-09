import Foundation
import UIKit

class ViewController: UIViewController, AddViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var Members = [ConfigItem]()
    var addNewMember: AddViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellIdentity)
        
        addNewMember?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MemberViewController {
            destination.member = Members[tableView.indexPathForSelectedRow!.row]
            
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string:"https://hamrahplus23.bankmellat.ir/mcpn/config")
//        let url = URL(string:"https://tempapi.proj.me/api/6DTCYSgot")
        
        URLSession.shared.dataTask(with: url!) { data, response , error in
            
            if let data = data, error == nil {
                do {
                    let res = try JSONDecoder().decode([String].self, from: data)
                    
                    for jsonString in res {
                        // Convert each string back into Data
                        print("\n\n \(jsonString.count)\n\n")
                        if let jsonData = jsonString.data(using: .utf8) {
                            // Attempt to decode ConfigCardPaymentDTO
                            if let configCardPaymentDTO = try? JSONDecoder().decode(ConfigCardPaymentDTO.self, from: jsonData) {
                                print(configCardPaymentDTO.configItems)
                                self.Members.append(contentsOf: configCardPaymentDTO.configItems)
                            }
                            // Attempt to decode BankListDTO
                            else if let bankListDTO = try? JSONDecoder().decode(BankListDTO.self, from: jsonData) {
                                print(bankListDTO)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print(String(describing: error))
                }
            }
            else {
                print("error in data task")
            }
        }.resume()
    }
    
    @objc func addButtonTapped() {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func didAddedMemebrToDB(_: AddViewController) {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellIdentity, for: indexPath) as! CustomTableViewCell
        let member = Members[indexPath.row]
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        cell.textLabel?.text = member.a.capitalized
        cell.detailTextLabel?.text = "Detail"
        
        let errorImage = UIImageView(image: UIImage(systemName: "multiply.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal))
        if member.i {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryView = errorImage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: self)
        let editVC = EditViewController(memebr: Members[tableView.indexPathForSelectedRow!.row].a)
        navigationController?.pushViewController(editVC, animated: true)
    }
}
