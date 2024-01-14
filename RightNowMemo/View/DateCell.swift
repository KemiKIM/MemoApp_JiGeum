//
//  DateCell.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/10/14.
//

import UIKit

class DateCell: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    
    
    //MARK: [변수 선언]
    let label = UILabel()
    
    
    
    
    //MARK: [Override]
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)
        
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
    
    
    
    //MARK: [Layout]
    func layout() {
        layoutLabel()
    }
    
    
    func layoutLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
