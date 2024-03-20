//
//  TableCellModel.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 07/06/23.
//

import UIKit

class TableCellModel: UITableViewCell {
    
    private var nameGamerLB: UILabel = .textPropertiesBackColor(.clear, .white, .left)
    private var stepLB: UILabel = .textPropertiesBackColor(.clear, .white, .right)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .cyan
        
        nameGamerLB.font = UIFont(name: "Futura", size: 0.06*wd)
        contentView.addSubview(nameGamerLB)
        
        nameGamerLB.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.height.equalTo(45)
            make.width.equalTo(0.6*wd)
        }
        
        stepLB.font = UIFont(name: "Futura", size: 0.06*wd)
        contentView.addSubview(stepLB)
        
        stepLB.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalTo(nameGamerLB.snp.centerY)
            make.height.equalTo(45)
            make.width.equalTo(0.3*wd)
        }
        
    }
    
    func initData(_ data: Record) {
        nameGamerLB.text = data.nameGamer
        stepLB.text = "\(data.steps)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
