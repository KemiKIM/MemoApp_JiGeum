//
//  MemoContextCell.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/10/14.
//

import UIKit

class MemoContextCell: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    
    // MARK: [변수 선언]
    let label = UILabel()
    
    
    
    // MARK: [Override]
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        // self.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)
        self.backgroundColor = .black
        
        addView()
        layout()
    }
    
    required init?(coder: NSCoder) {
          fatalError("")
      }
    
    
    
    
    
    // MARK: [Add View]
    func addView() {
        self.addSubview(label)
    }
    
    
    
    // MARK: [Layout]
    func layout() {
        layoutLabel()
    }
    
    
    func layoutLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        
    }
}
