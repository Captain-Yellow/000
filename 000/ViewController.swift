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
            
            if data != nil, error == nil {
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8))
                print("\n\n")
                do {
                    let res = try JSONDecoder().decode([String].self, from: data)
                    print("response \(res)")
                    print("response \(res.count)")
                    
                    for jsonString in res {
                            // Convert each string back into Data
                        print("\n\n \(jsonString.count)\n\n")
                            if let jsonData = jsonString.data(using: .utf8) {
                                // Attempt to decode ConfigCardPaymentDTO
                                if let configCardPaymentDTO = try? JSONDecoder().decode(ConfigCardPaymentDTO.self, from: jsonData) {
                                    // Successfully decoded ConfigCardPaymentDTO
                                    print(configCardPaymentDTO.configItems)
                                    self.Members.append(contentsOf: configCardPaymentDTO.configItems)
                                    print("\n\n \(configCardPaymentDTO.configItems[0].e) \n\n")
                                }
                                // Attempt to decode BankListDTO
                                else if let bankListDTO = try? JSONDecoder().decode(BankListDTO.self, from: jsonData) {
                                    // Successfully decoded BankListDTO
                                    print(bankListDTO)
                                }
                            }
                        }
//                    self.Members =
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print(String(describing: error))
                    print("\n\nError\n\n")
                    print(error.localizedDescription)
                }
            }
            else {
                print("error in if")
                print(error)
                print("\n\n")
                print(data)
            }
        }.resume()
    }
}

