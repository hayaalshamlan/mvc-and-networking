import UIKit
import SnapKit
import Kingfisher

class DetailPetController: UIViewController {
    
    var pet: Pet?
    
    private let idLabel = UILabel()
    private let nameLabelTitle = UILabel()
    private let nameLabel = UILabel()
    private let adoptedLabel = UILabel()
    private let imageView = UIImageView()
    private let ageLabel = UILabel()
    private let genderLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(idLabel)
        view.addSubview(nameLabelTitle)
        view.addSubview(nameLabel)
        view.addSubview(adoptedLabel)
        view.addSubview(imageView)
        view.addSubview(ageLabel)
        view.addSubview(genderLabel)
        
        
        view.backgroundColor = .lightGray
        title = " The pet details "
        
        setupViews()
        setupLayout()
        configureWithStudents()
    }
    
    private func setupViews(){
        idLabel.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabelTitle.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        adoptedLabel.font = .systemFont(ofSize: 20, weight: .medium)
        ageLabel.font = .systemFont(ofSize: 20, weight: .medium)
        genderLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
    }
    
    private func setupLayout(){
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(170)
        }
        nameLabelTitle.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabelTitle.snp.bottom).offset(20)
            make.leading.equalTo(nameLabelTitle.snp.leading)
        }
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        adoptedLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(adoptedLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func configureWithStudents(){
        idLabel.text = "🔢 Pet id: \(String(pet?.id ?? 0))"
        nameLabelTitle.text = "📝 Pet name:"
        nameLabel.text = " \(pet?.name ?? "Empty")"
        adoptedLabel.text = "🏠 Is it adopted:  \(String(pet?.adopted  ?? true))"
        ageLabel.text = "📅 Pet age:   \(String(pet?.age ?? 0))"
        genderLabel.text = "⚧ Pet gender:   \(pet?.gender ?? "Empty")"
        let url = URL(string: pet?.image ?? "")
        imageView.kf.setImage(with: url)
    }
}
