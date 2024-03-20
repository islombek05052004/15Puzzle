//
//  IntroPage.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 03/06/23.
//

import UIKit

class IntroPage: UIViewController {
    
    var fifteenLabel = UILabel()
    var puzzle = UILabel()
    let puzzleImage = UIImageView()
    var time:Timer? = nil
    var sec = 0
           
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgbColor(r: 83, g: 65, b: 120)
        
        fifteenLabel = .textPropertiesBackColor(.clear, .white, .center)
        fifteenLabel.text = "Fifteen"
        fifteenLabel.font = UIFont(name: "Party LET", size: 0.18*hg)
        view.addSubview(fifteenLabel)
        
        fifteenLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(0.22*hg)
            make.width.equalTo(wd)
            make.height.equalTo(0.2*hg)
        }
        
        puzzle = .textPropertiesBackColor(.clear, .white, .center)
        puzzle.text = "puzzle"
        puzzle.font = UIFont(name: "Party LET", size: 0.14*hg)
        view.addSubview(puzzle)
        
        puzzle.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(fifteenLabel.snp.bottom).offset(-20)
            make.width.equalTo(wd)
            make.height.equalTo(0.12*hg)
        }
        
        puzzleImage.clipsToBounds = true
        puzzleImage.layer.borderColor = UIColor(red: 58/255,
                                                green: 41/255,
                                                blue: 96/255,
                                                alpha: 1).cgColor
        puzzleImage.layer.borderWidth = 4
        puzzleImage.layer.cornerRadius = 6
        puzzleImage.image = UIImage(named: "puzzle")
        view.addSubview(puzzleImage)
        
        puzzleImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(puzzle.snp.bottom).offset(10)
            make.width.height.equalTo(0.5*wd)
        }
        
        enterAnimate()
        timeAnimateToNextPage()
        
    }
    
    func enterAnimate () {
        fifteenLabel.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        puzzle.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        puzzleImage.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        
        UIView.animate(withDuration: 0.5) {
            self.fifteenLabel.transform = CGAffineTransform.identity
            self.puzzle.transform = CGAffineTransform.identity
            self.puzzleImage.transform = CGAffineTransform.identity
        }
        
    }
    
    func timeAnimateToNextPage() {
        time = Timer.scheduledTimer(timeInterval: 1,
                                    target: self,
                                    selector: #selector(Timefunc),
                                    userInfo: nil,
                                    repeats: true)
    }
    @objc func Timefunc () {
        sec += 1
        if sec == 2 {
            navigationController?.pushViewController(HomeController(), animated: true)
            time?.invalidate()
        }
    }
}
