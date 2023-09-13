//
//  UIViewController+.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/10/14.
//

import UIKit

extension UIViewController {
    
    // MARK: [Normal Alert]
    func alert(title: String = "알림", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: [Toast Message]
    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100,
                                               y: self.view.frame.size.height - 100,
                                               width: 200,
                                               height: 40))
        
        toastLabel.backgroundColor = .black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.5,
                       delay: 0.05, options: .curveEaseOut,
                       animations: {toastLabel.alpha = 0.0}) { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
}
