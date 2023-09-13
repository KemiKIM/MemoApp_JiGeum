//
//  DetailSettingViewController.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/10/21.
//

import UIKit


// MARK: [ (D) Protocol ]
protocol moveToDetail {
    func deleteMethod()
    func editMethod()
    func buttonFalse()
}

class SettingDetailViewController: UIViewController {
    var settingDetailVCDelegate: moveToDetail?

    // MARK: [변수 선언] [0]: Frame
    private lazy var settingView = UIView()
    
    
    
    // MARK: [변수 선언] [1]: Right Bottom
    private lazy var rightBottomButton: UIButton = {
        let rBottom = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "timelapse", withConfiguration: imageConfig)
        
        rBottom.setImage(image, for: .normal)
        
        rBottom.tintColor = .white
        rBottom.alpha = 1

        rBottom.addTarget(self, action: #selector(dismissTapped(sender:)), for: .touchUpInside)
        
        return rBottom
    }()
    
    
    
    // MARK: [변수 선언] [1]: Right
    private lazy var editButton: UIButton = {
        let edit = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "pencil", withConfiguration: imageConfig)
        
        edit.setImage(image, for: .normal)
        
        edit.tintColor = .white
        edit.alpha = 1

        edit.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        return edit
    }()

    
    
    private lazy var deleteButton: UIButton = {
        let delete = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "trash.circle", withConfiguration: imageConfig)
        
        delete.setImage(image, for: .normal)
        
        delete.tintColor = .systemPink
        delete.alpha = 1
        
        delete.addTarget(self, action: #selector(deleteButtonTapped(sender: )), for: .touchUpInside)

        return delete
    }()
    
    

    
    
    // MARK: [Override]
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
        settingDetailVCDelegate?.buttonFalse()
    }

    
    
    
    // MARK: [Action]
    @objc private func dismissTapped(sender: UIButton) {
        
        animateView(sender)
        self.dismiss(animated: true)
        settingDetailVCDelegate?.buttonFalse()

    }
    
    
    fileprivate func animateView(_ viewToAnimate: UIView) {

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        
    }

    @objc private func editButtonTapped() {
        
        self.dismiss(animated: true)
        settingDetailVCDelegate?.editMethod()

    }
    
   
    @objc private func deleteButtonTapped(sender: UIButton) {
        
        customAlert(alertText: "메모를 삭제하시겠어요?", cancelButtonText: "취소", confirmButtonText: "확인")
     
    }
    
    
        
    
    

// MARK: [Class End]
        
}

// MARK: [Class End]





// MARK: [ (S) Protocol ]
extension SettingDetailViewController: AlertDelegate {
    func action() {
        self.dismiss(animated: true) {
            self.settingDetailVCDelegate?.deleteMethod()
        }
    }
    
    func exit() {
        self.dismiss(animated: true)
    }
}









// MARK: [Layout] + [Back.Col]
extension SettingDetailViewController {
    
    
    private func layout() {
        layoutSettingView()
        //
        layoutEtcButton()
        //
        layoutEditButton()
        layoutDeleteButton()
    }
    
    
    
    private func layoutSettingView() {
        self.view.addSubview(self.settingView)
        
        self.settingView.backgroundColor = .systemGray2
        self.settingView.alpha = 0.3
        
        self.settingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.settingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.settingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.settingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.settingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    
    private func layoutEtcButton() {
        self.view.addSubview(self.rightBottomButton)
        
        self.rightBottomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.rightBottomButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.rightBottomButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    
    private func layoutEditButton() {
        self.view.addSubview(self.editButton)
        
        self.editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.editButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.editButton.bottomAnchor.constraint(equalTo: self.rightBottomButton.topAnchor, constant: -20)
        ])
        
    }
 
    
    
    
    private func layoutDeleteButton() {
        self.view.addSubview(self.deleteButton)
    
        self.deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.deleteButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.deleteButton.bottomAnchor.constraint(equalTo: self.editButton.topAnchor, constant: -20)
        ])
        
    }
    
    
}
