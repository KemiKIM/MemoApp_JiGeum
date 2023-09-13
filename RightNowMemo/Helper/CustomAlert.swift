//
//  CustomAlert.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/12/05.
//

import UIKit


// MARK: [ (D) Protocol]
protocol AlertDelegate {
    func action()
    func exit()
}



// MARK: [ (D) Protocol Extension]
extension AlertDelegate where Self: UIViewController {
    func customAlert(
        
        alertText: String,
        cancelButtonText: String? = "",
        confirmButtonText: String
    
    ) {
        
        let vc = CustomAlert()
        vc.delegate = self
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.alertText = alertText
        vc.cancelButtonText = cancelButtonText ?? ""
        vc.confirmButtonText = confirmButtonText
        
        self.present(vc, animated: true)
    }
}





// MARK: [Enum]
enum AlertType {
    case confirm
    case cancel
}


class CustomAlert: UIViewController {
    var delegate: AlertDelegate?
    
    var alertType = [AlertType]()
    
    
    var alertText = ""
    var cancelButtonText = ""
    var confirmButtonText = ""
    
    
    
    
    // MARK: [변수 선언] [0]: Frame
    lazy var backView: UIView = {
        let back = UIView()
        
        back.alpha = 0.5
        
        return back
    }()
    
    
    
    
    // MARK: [변수 선언] [1]: Front
    lazy var mainView: UIView = {
        let main = UIView(frame: .zero)
        
        main.alpha = 1
        main.layer.cornerRadius = 8
        main.clipsToBounds = true
      
        
        return main
    }()
    
    
    
    lazy var infoLabel: UILabel = {
       let info = UILabel()
        
        info.text = alertText
        info.textColor = .black
        info.textAlignment = .center
        info.font = .boldSystemFont(ofSize: 20)
        
        
        return info
    }()
    
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.cancelButton)
        stackView.addArrangedSubview(self.confirmButton)
        
        stackView.distribution = .fillEqually
        
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 8
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        stackView.layer.masksToBounds = true
        
        return stackView
    }()
    
    lazy var cancelButton: UIButton = {
        let cancel = UIButton()
        
        cancel.setTitle(cancelButtonText, for: .normal)
        cancel.setTitleColor(UIColor.black, for: .normal)
        
        cancel.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        return cancel
    }()
    
    lazy var confirmButton: UIButton = {
        let confirm = UIButton()
        
        confirm.setTitle(confirmButtonText, for: .normal)
        confirm.setTitleColor(UIColor.white, for: .normal)
        
        confirm.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        return confirm
    }()
    
    
    
    
    
    // MARK: [Override]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    
    
    
    
    
    
    
    // MARK: [Action]
    @objc func confirmButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.action()
        }
    }
    
    @objc func cancelButtonTapped() {
        self.delegate?.exit()
    }

    
    
    
    
    
    
    
// MARK: [Class End]
    
}

// MARK: [Class End]










// MARK: [Layout] +[BackColor]
extension CustomAlert {
    private func layout() {
        layoutBackView()
        layoutMainView()
        layoutInfoLabel()
        layoutStackView()
    }
    
    
    private func layoutBackView() {
        self.view.addSubview(self.backView)
        
        self.backView.backgroundColor = .clear
        
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func layoutMainView() {
        self.view.addSubview(self.mainView)
        
        self.mainView.backgroundColor = .systemGray4
        
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func layoutInfoLabel() {
        self.mainView.addSubview(self.infoLabel)
        
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.infoLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.infoLabel.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -65),
            self.infoLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func layoutStackView() {
        self.mainView.addSubview(self.stackView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // MARK: [Button Background]
        self.cancelButton.backgroundColor = UIColor.gray
        self.confirmButton.backgroundColor = .darkGray
        
    }
    
}

