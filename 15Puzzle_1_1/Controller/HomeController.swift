//
//  HomeController.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 02/06/23.
//

import UIKit
import SnapKit
import AVFoundation
var avplayer = AVAudioPlayer()


let hg = UIScreen.main.bounds.height
let wd = UIScreen.main.bounds.width
let mg: CGFloat = 20
let backColor: UIColor = .rgbColor(r: 83, g: 65, b: 120)
let btnColor: UIColor = .rgbColor(r: 129, g: 196, b: 184)
let currentColor: UIColor = .rgbColor(r: 58, g: 41, b: 96)
var winnerPresentBool = false

class HomeController: UIViewController {
    
    lazy var stepNum = 0 {
        didSet {
            stepsLabelCount.text = "\(stepNum)";
        }
    }
    let winnerImage = UIImageView()
    let stepsLabelView = UIView()
    var stepsLabelinGame = UILabel()
    var stepsLabelCount = UILabel()
    var newGameBtn = UIButton()
    var winnerLabel = UILabel()
    var winnerNameTF = UITextField()
    let lineLB = UILabel()
    let winnerView = UIView(frame: CGRect(x: 0, y: 0, width: wd, height: hg))
    var stepsLb = UILabel()
    var saveBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = backColor
        
        newGameBtnDesign()
        stepsLabelDesign()
        createGameBtns()
        titleGameName()
        recordBtn()
    }
    
    func stepsLabelDesign() {
        stepsLabelView.frame = CGRect(x: 0.7 * wd - 2 * mg,
                                  y: 0.3 * hg,
                                  width: 0.3 * wd + mg,
                                  height: 0.09 * hg)
        stepsLabelView.backgroundColor = currentColor
        stepsLabelView.layer.cornerRadius = 0.04 * hg
        view.addSubview(stepsLabelView)
        
        stepsLabelinGame = .textPropertiesBackColor(.clear, .white, .center)
        stepsLabelinGame.text = "Muves"
        stepsLabelView.addSubview(stepsLabelinGame)
        
        stepsLabelinGame.snp.makeConstraints { make in
            make.centerX.equalTo(stepsLabelView.snp.centerX)
            make.top.equalTo(4)
            make.width.equalTo(0.3 * wd)
            make.height.equalTo(0.03 * hg)
        }
        
        stepsLabelCount = .textPropertiesBackColor(.clear, .white, .center)
        stepsLabelCount.text = "\(stepNum)"
        stepsLabelCount.font = .systemFont(ofSize: 0.04 * hg, weight: .bold)
        stepsLabelView.addSubview(stepsLabelCount)
        
        stepsLabelCount.snp.makeConstraints { make in
            make.centerX.equalTo(stepsLabelView.snp.centerX)
            make.top.equalTo(stepsLabelinGame.snp.bottom).offset(-2)
            make.bottom.equalTo(0)
            make.width.equalTo(0.3 * wd)
        }
    }
    
    func newGameBtnDesign() {
        
        newGameBtn = .borRadBackColor(true, 0.04 * hg, currentColor)
        newGameBtn.frame = CGRect(x: mg,
                                  y: 0.3 * hg,
                                  width: 0.32 * wd,
                                  height: 0.09 * hg)
        newGameBtn.setTitle("new game", for: .normal)
        newGameBtn.setTitleColor(.gray, for: .normal)
        newGameBtn.addTarget(self, action: #selector(newGameBtnClikc), for: .touchUpInside)
        newGameBtn.titleLabel?.font = .systemFont(ofSize: 0.025 * hg, weight: .bold)
        view.addSubview(newGameBtn)
    }
    
    @objc func newGameBtnClikc() {
        removeBtn_Restart()
    }
    
    func createGameBtns() {
        var tag = 1
        var arrNum = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        arrNum.shuffle()
        arrNum.append(16)
        for locationY in 0...3 {
            for locationX in 0...3 {
                var btn = UIButton(type: .system)
                btn = .borRadBackColor(true, 0.02*wd, btnColor)
                btn.frame = CGRect(x: mg + CGFloat(locationX)*((wd - mg) / 4),
                                   y: 0.44 * hg + CGFloat(locationY) * ((wd - mg) / 4),
                                   width: (wd - 5 * mg) / 4,
                                   height: (wd - 5 * mg) / 4)
                btn.setTitle("\(arrNum[tag-1])", for: .normal)
                btn.setTitleColor(.white, for: .normal)
                btn.titleLabel?.font = UIFont(name: "Futura", size: 0.06 * hg)
                btn.addTarget( self, action: #selector(gameBtnClick), for: .touchUpInside)
                btn.tag = arrNum[tag-1]
                if tag == 16 {
                    btn.backgroundColor = .clear
                    btn.setTitle(nil, for: .normal)
                }
                tag += 1
                btn.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                  UIView.animate(withDuration: 0.35, animations: {
                      btn.transform = CGAffineTransform.identity
                  })
                view.addSubview(btn)
            }
        }
    }
    
    @objc func gameBtnClick(_ sender: UIButton) {
        guard let emptyBtn = view.viewWithTag(16) as? UIButton else {return}
        let emptyBtnCenter = emptyBtn.center
        let senderCenter = sender.center
        let dX_dY : CGFloat = ((wd - mg) / 4)
        if sender.tag > 0 && sender.tag < 16 {
            if emptyBtnCenter.x == senderCenter.x && abs(emptyBtnCenter.y - senderCenter.y) == dX_dY ||
                emptyBtnCenter.y == senderCenter.y && abs(emptyBtnCenter.x - senderCenter.x) == dX_dY {
                stepNum += 1
                UIView.animate(withDuration: 0.25) {
                    sender.center = emptyBtnCenter
                    emptyBtn.center = senderCenter
                }
            }
        }
        clickButtonSound()
        iswinner()
    }
    
    private func recordBtn() {
        
        var recordBtn = UIButton(type: .system)
        recordBtn = .borRadBackColor(true, 0.02 * wd, .clear)
        recordBtn.setTitle("Results", for: .normal)
        recordBtn.frame = CGRect(x: 0.75 * wd - mg,
                                 y: 0.05 * hg,
                                 width: 0.25 * wd,
                                 height: 0.05 * hg)
        recordBtn.setTitleColor(.white, for: .normal)
        recordBtn.addTarget(self, action: #selector(recordBtnClick), for: .touchUpInside)
        view.addSubview(recordBtn)
        
    }
    @objc func recordBtnClick() {
        present(ResultsPage(), animated: true)
    }
    
    func clickButtonSound() {
        let sound = Bundle.main.path(forResource: "switchlight", ofType: "mp3")
        do {
            avplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            avplayer.play()
        } catch  {
            print("Error")
        }
    }
}

