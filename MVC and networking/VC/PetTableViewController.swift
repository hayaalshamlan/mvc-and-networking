import UIKit
import Alamofire

class PetTableViewController: UITableViewController {
    
    var pets: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = " Select a pet "
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchPetData()
        setupNav()
        setupNavigationBar()
//        addPetTapped()
        
        
        let instructionsButton = UIBarButtonItem(title: "!", style: .plain, target: self, action: #selector(instructionsButtonTapped))
        navigationItem.leftBarButtonItem = instructionsButton
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }
    
    private func fetchPetData() {
        NetworkManager.shared.fetchPets { fetchedPet in
            DispatchQueue.main.async {
                self.pets = fetchedPet ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailPetController()
        let selectedPet = pets[indexPath.row]
        detailVC.pet = selectedPet
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    @objc private func instructionsButtonTapped(){
        let instructionsVC = InstructionsViewController()
        instructionsVC.modalPresentationStyle = .popover
        self.present(instructionsVC, animated: true, completion: nil)
    }
    
    func setupNav(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPetTapped))
    }
    
    @objc func addPetTapped(){
        let addPetVC = AddPetViewController()
        //        let addPetVC = UINavigationController(rootViewController: AddPetViewController())
        present(addPetVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  {
            let petToDelete = pets[indexPath.row]
            NetworkManager.shared.deletePet(petID: petToDelete.id) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        self?.pets.remove(at: indexPath.row)
                        
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        
                    }
                }
            }
        }
    }
}
