
import UIKit
import SnapKit

class InstructionsViewController: UIViewController {
    
    let instruction = "📍 Here you can adopt a animal"
    let instruction2 = "🐾  You can find any kinds of animals"
    let instruction3 = "🏘 You can adopt anytime you want"

    
    
    let instructionFrame = UILabel()
    let instruction2Frame = UILabel()
    let instruction3Frame = UILabel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(instructionFrame)
        view.addSubview(instruction2Frame)
        view.addSubview(instruction3Frame)
       
        
        setupUi()
        setconstructor()
    }
    
    func setupUi(){
        instructionFrame.text = instruction
        instruction2Frame.text = instruction2
        instruction3Frame.text = instruction3
        
    }
    
    func setconstructor(){
        
        instructionFrame.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        instruction2Frame.snp.makeConstraints { make in
            make.top.equalTo(instructionFrame.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        instruction3Frame.snp.makeConstraints { make in
            make.top.equalTo(instruction2Frame.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
