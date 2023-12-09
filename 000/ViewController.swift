import Foundation
import UIKit
import CoreData

class ViewController: UIViewController, AddViewControllerDelegate, EditViewControllerDelegate {    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var allMembers = [ConfigItem]()
//    var allMembersID = [String]()
    var loadedMembers = [Members]()
    var addNewMember = AddViewController()
//    var editMember = EditViewController()
//    var editMember: EditViewController!
    
    override func viewDidLoad() {
//        editMember = EditViewController()
        addNewMember.delegate = self
//        editMember.delegate = self
        super.viewDidLoad()
        loadData()
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellIdentity)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? MemberViewController {
//            destination.member = allMembers[tableView.indexPathForSelectedRow!.row]
//            
//        }
//    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string:"https://hamrahplus23.bankmellat.ir/mcpn/config")
//        let url = URL(string:"https://tempapi.proj.me/api/6DTCYSgot")
        
        URLSession.shared.dataTask(with: url!) { data, response , error in
            
            if let data = data, error == nil {
                do {
                    let res = try JSONDecoder().decode([String].self, from: data)
                    
                    for jsonString in res {
                        // Convert each string back into Data
                        if let jsonData = jsonString.data(using: .utf8) {
                            // Attempt to decode ConfigCardPaymentDTO
                            if let configCardPaymentDTO = try? JSONDecoder().decode(ConfigCardPaymentDTO.self, from: jsonData) {
//                                print(configCardPaymentDTO.configItems)
                                
                                self.allMembers.append(contentsOf: configCardPaymentDTO.configItems)
                            }
                            // Attempt to decode BankListDTO
                            else if let bankListDTO = try? JSONDecoder().decode(BankListDTO.self, from: jsonData) {
//                                print(bankListDTO)
                            }
                        }
                    }
                    
                    for (index, mem) in self.allMembers.enumerated() {
                        let filter = self.loadedMembers.filter { mem in
                            mem.member == self.allMembers[index].a
                        }
                        if filter.isEmpty {
                            let newMem = Members(context: self.context)
                            newMem.member = mem.a
                            newMem.accessory = mem.i
                            self.loadedMembers.append(newMem)
                            self.saveData(nil)
                        } else {
                            continue
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
//        print(allMembersID)
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func didAddedMemebrToDB(_: AddViewController) {
        print("added")
        loadData()
        self.tableView.reloadData()
    }
    
    func didEdited(_: EditViewController, editedText: String, index: Int) {
        print("im edited")
        DispatchQueue.main.async {
            print("im edited")
            self.loadedMembers[index].setValue(editedText, forKey: "member")
            self.saveData(nil)
            self.tableView.reloadData()
        }
    }
    
    private func loadData() {
        let members: NSFetchRequest<Members> = Members.fetchRequest()
        do {
            loadedMembers = try context.fetch(members)
        } catch {
            print("Error in Fetch and Load Data \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func saveData(_ membersId: [String]?) {
//        for mem in membersId {
//            let member = Members(context: context)
//            member.member = mem
//            loadedMembers.append(member)
//        }
        do {
            try context.save()
        } catch {
            print("Error in saving Data \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellIdentity, for: indexPath) as! CustomTableViewCell
//        let member = allMembers[indexPath.row]
        let member = loadedMembers[indexPath.row]
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        cell.textLabel?.text = member.member?.capitalized
        cell.detailTextLabel?.text = "Detail"
        cell.tag = indexPath.row
        
        let errorImage = UIImageView(image: UIImage(systemName: "multiply.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal))
        if member.accessory {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryView = errorImage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: self)
        let editVC = EditViewController(memebr: loadedMembers[tableView.indexPathForSelectedRow!.row].member, index: indexPath.row)
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            context.delete(loadedMembers[indexPath.row])
            loadedMembers.remove(at: indexPath.row)
//            Members.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData(nil)
            tableView.reloadData()
        }
    }
}
