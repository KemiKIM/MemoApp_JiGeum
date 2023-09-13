//
//  StartViewController.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/09/22.
//

import UIKit

class StartViewController: UIViewController {
    let dataManager = CoreDataManager.shared
    var editTarget: MemoData?
       
    
    // MARK: [변수 선언] [0]: Top
    private lazy var titleView = UIView()
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        let cafe24Ssurround = UIFont(name: "Cafe24Ssurround", size: 25)
        
        title.font = cafe24Ssurround
        title.text = "지금"
        title.textColor = .white
        
        return title
    }()
    
    
    
    
    
    // MARK: [변수 선언] [1]: Middle
    lazy var textView: UITextView = {
        let textView = UITextView()
        let ridi = UIFont(name: "Cafe24SsurroundAir", size: 23)
        
        textView.contentInsetAdjustmentBehavior = .automatic
        
        textView.font = ridi
        textView.textColor = .white
        
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 3
        textView.layer.borderColor = UIColor.white.cgColor
        
        return textView
    }()
    

    
    
    // MARK: [변수 선언] [2]: Bottom
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(rightButton)
        
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    

    
    private lazy var leftButton: UIButton = {
        let left = UIButton(type: .system)
        let leftArrowImg = UIImage(named: "custom-arrow-left")
        
        left.setImage(leftArrowImg, for: .normal)
        left.imageView?.contentMode = .scaleAspectFit
        
        left.tintColor = .white
        
        left.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        
        return left
    }()
    
    
    private lazy var rightButton: UIButton = {
        let right = UIButton(type: .system)
        let rightArrowImg = UIImage(named: "custom-arrow-right")
        
        right.setImage(rightArrowImg, for: .normal)
        right.imageView?.contentMode = .scaleAspectFit
        
        right.tintColor = .white
        
        right.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        return right
    }()
    
    
    
    
    
    
    
    // MARK: [Override]
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editMethod()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.textView.textColor = .white
        self.textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    
    
    
    
    
    // MARK: [Action]
    private func editMethod() {
        if let memo = editTarget {
            
            guard let text = memo.memoText else { return }
            textView.text = text
            
        }
    }

    
    
    
    
    @objc private func leftButtonTapped() {

        let vc = MainViewController()
        vc.mainVCDelegate = self
        
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    
    
    @objc private func rightButtonTapped() {
        let vc = MainViewController()
        
        if let memo = editTarget {

            memo.memoText = textView.text
            dataManager.updateData(newData: memo) {
                print("update success")
                
            }
            
            self.leftButtonTapped()

        } else {

            guard let memo = textView.text, memo.count > 0 else {
                alert(message: "메모를 입력하세요.")
                return
            }
            
            let memoText = textView.text
            
            dataManager.saveData(memoText: memoText) {
                print("save")
            }

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        vc.mainVCDelegate = self
    }
    
    
    

    
    
// MARK: [Class End]
                
}

// MARK: [Class End]








// MARK: [ (S) Protocol ]
extension StartViewController: moveToStart {
    func firstSetting() {
        self.textView.text.removeAll()
    }
}








// MARK: [Layout] + [Back.Col]
extension StartViewController {
    func layout() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)

        layoutTitleView()
        layoutTitleLabel()
        //
        layoutTextView()
        layoutStackView()
    }
    
    
    private func layoutTitleView() {
        self.view.addSubview(self.titleView)
        
        self.titleView.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)
        
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.titleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.titleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.titleView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
    private func layoutTitleLabel() {
        self.titleView.addSubview(self.titleLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.titleView.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor)
        ])
    }
    
   
    
    
    private func layoutTextView() {
        self.view.addSubview(self.textView)

        self.textView.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)

        self.textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10),
            self.textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            self.textView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
        
    }
    
    
    
    private func layoutStackView() {
        self.view.addSubview(self.stackView)

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 5),
            self.stackView.leadingAnchor.constraint(equalTo: self.textView.leadingAnchor, constant: 30),
            self.stackView.trailingAnchor.constraint(equalTo: self.textView.trailingAnchor, constant: -30),
            self.stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
