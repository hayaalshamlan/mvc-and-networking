import UIKit
import Kingfisher
import Eureka

class AddPetViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitTapped))
        
        setupForm()
        
    }
    private func setupForm() {
        form +++ Section("Add New Pet")
        
        <<< TextRow() { row in
            row.title = "📝 Name"
            row.placeholder = " Enter pet name"
            row.tag = "name"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< IntRow() { row in
            row.title = "🔢  ID"
            row.placeholder = "Enter pet id"
            row.tag = "id"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< SwitchRow() { row in
            row.title = "🏠 Adopted"
            row.tag = "adopted"

        }
        <<< IntRow() { row in
            row.title = "📅 age"
            row.placeholder = " Enter the age"
            row.tag = "age"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< TextRow() { row in
            row.title = "⚧ gender"
            row.placeholder = " Enter pet gender"
            row.tag = "gender"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< URLRow() { row in
            row.title = "🔽 Image"
            row.placeholder = " enter the URL IMG"
            row.tag = "ImageURL"
            row.add(rule: RuleURL())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< ButtonRow(){ row in
            row.title = "Add pet"
            row.onCellSelection { cell, row in
                print("button cell tapped")
                self.submitTapped()
            }
        }
    }
    
    @objc func submitTapped() {
        let errors = form.validate()
        guard errors.isEmpty else {
            presentAlertWithTitle(title: "🆘", message: "One of the text field in empty.")
            return
        }
        
        let idRow: IntRow? = form.rowBy(tag: "id")
        let nameRow: TextRow? = form.rowBy(tag: "name")
        let adoptedRow: SwitchRow? = form.rowBy(tag: "adopted")
        let imageUrlRow: URLRow? = form.rowBy(tag: "ImageURL")
        let ageRow: IntRow? = form.rowBy(tag: "age")
        let genderRow: TextRow? = form.rowBy(tag: "gender")
        
        let id = idRow?.value ?? 0
        let name = nameRow?.value ?? ""
        let adopted = adoptedRow?.value ?? false
        let imageUrl = imageUrlRow?.value?.absoluteString ?? ""
        let age = ageRow?.value ?? 0
        let gender = genderRow?.value ?? ""
        
        print(adopted)
        let pet = Pet(id: 0, name: name, adopted: adopted , image: imageUrl, age: Int(age), gender: gender)
        
        NetworkManager.shared.addPet(pet: pet) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                }
            }
        }
    }
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
