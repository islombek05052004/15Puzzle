//
//  Extentions.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 02/06/23.
//

import UIKit
import AVFoundation

extension HomeController {
    
    func iswinner() {
        
        var currentTag = 1
        var locationTrueBtns = 0
        for locationY in 0...3 {
            for locationX in 0...3 {
                let currentBtn = view.viewWithTag(currentTag) as! UIButton
                if currentBtn.center == CGPoint(x: mg + CGFloat(locationX) * ((wd - mg) / 4) + (wd - 5 *                                      mg) / 8,
                                                y: 0.44 * hg + CGFloat(locationY) * ((wd - mg) / 4) + (wd - 5 * mg) / 8){
                    changeColorTrueBtn(currentBtn, true)
                    locationTrueBtns += 1
                } else {
                    changeColorTrueBtn(currentBtn, false)
                }
                currentTag += 1
            }
        }
        if locationTrueBtns == 16 {
            winnerPresentView()
            winnerSoundEffects()
        }
    }
    
    func changeColorTrueBtn(_ senderBtn: UIButton, _ trueBtn: Bool) {
        if trueBtn == true && senderBtn.tag != 16 {
            UIView.animate(withDuration: 0.2) {
                senderBtn.backgroundColor = .orange
            }
        }
        if senderBtn.backgroundColor != btnColor && trueBtn == false, senderBtn.tag != 16 {
            UIView.animate(withDuration: 0.2) {
                senderBtn.backgroundColor = btnColor
            }
        }
    }
    
    func removeBtn_Restart () {
        for tag in 1...16 {
            guard let removeBtn = view.viewWithTag(tag) as? UIButton else { return }
            removeBtn.removeFromSuperview()
        }
        createGameBtns()
        stepNum = 0
    }
    
    func titleGameName() {
        let gameNameView = UIView()
        gameNameView.backgroundColor = .clear
        gameNameView.frame = CGRect(x: 0,
                                    y: 0.1 * hg,
                                    width: wd,
                                    height: 0.12 * hg)
        view.addSubview(gameNameView)
        
        let waterImage = UIImageView()
        waterImage.image = UIImage(named: "flood")?.withRenderingMode(.alwaysTemplate)
        waterImage.tintColor = currentColor
        waterImage.frame = CGRect(x: 0,
                                  y: 0,
                                  width: wd,
                                  height: 0.12 * hg)
        gameNameView.addSubview(waterImage)
        
        var titleGame = UILabel()
        titleGame = .textPropertiesBackColor(.clear, .white, .center)
        titleGame.text = "15 Puzzle"
        titleGame.font = UIFont(name: "Futura", size: 60)
        titleGame.frame = CGRect(x: 0, y: 0.1*hg, width: wd, height: 0.12*hg)
        view.addSubview(titleGame)
        
    }
    
    func winnerPresentView() {

        winnerView.backgroundColor = currentColor
        winnerView.layer.cornerRadius = 0.05 * wd
        view.addSubview(winnerView)
        
        winnerImage.image = UIImage(named: "award")
        winnerImage.backgroundColor = .clear
        winnerView.addSubview(winnerImage)
        
        winnerImage.snp.makeConstraints { make in
            make.centerX.equalTo(winnerView.snp.centerX)
            make.top.equalTo(winnerView.snp.top).offset(0.25*hg)
            make.width.height.equalTo(0.55*wd)
        }
        
        winnerLabel = .textPropertiesBackColor(.clear, .white, .center)
        winnerLabel.text = "Winner"
        winnerLabel.font = UIFont(name: "Futura", size: 0.13*wd)
        winnerView.addSubview(winnerLabel)
        
        winnerLabel.snp.makeConstraints { make in
            make.top.equalTo(0.2*wd)
            make.width.equalTo(wd)
            make.height.equalTo(0.08*hg)
            make.bottom.equalTo(winnerImage.snp.top)
        }
        
        winnerNameTF = .placeHBorderSTextandBackC(.none, .white, .clear)
        winnerNameTF.attributedPlaceholder = NSAttributedString(
            string: "Winner's name...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        winnerNameTF.font = UIFont(name: "Futura", size: 0.05*wd)
        winnerNameTF.autocorrectionType = .no
        winnerView.addSubview(winnerNameTF)
        
        winnerNameTF.snp.makeConstraints { make in
            make.left.equalTo(0.1*wd)
            make.width.equalTo(0.8*wd)
            make.top.equalTo(winnerImage.snp.bottom).offset(20)
            make.height.equalTo(0.05*hg)
        }
        
        lineLB.backgroundColor = .gray
        winnerView.addSubview(lineLB)
        
        lineLB.snp.makeConstraints { make in
            make.centerX.equalTo(winnerNameTF.snp.centerX)
            make.width.equalTo(0.84*wd)
            make.left.equalTo(0.08*wd)
            make.height.equalTo(2)
            make.top.equalTo(winnerNameTF.snp.bottom)
        }
        
        winnerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        winnerImage.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.3) {
            self.winnerView.transform = CGAffineTransform.identity
            self.winnerImage.transform = CGAffineTransform.identity
        }
        
        saveBtn = .borRadBackColor(true, 0.02 * wd, backColor)
        saveBtn.frame = CGRect(x: 0.35 * wd,
                               y: 0.65 * hg,
                               width: 0.3 * wd,
                               height: 0.05 * hg)
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
        saveBtn.titleLabel?.font = UIFont(name: "Futura", size: 0.06*wd)
        winnerView.addSubview(saveBtn)
        
        stepsLb = .textPropertiesBackColor(.clear, .white, .center)
        stepsLb.font = UIFont(name: "Futura", size: 0.05*wd)
        stepsLb.text = "Your steps: \(stepNum)"
        winnerView.addSubview(stepsLb)
        
        stepsLb.snp.makeConstraints { make in
            make.top.equalTo(winnerImage.snp.bottom).offset(-0.05*wd)
            make.width.equalTo(wd)
            make.height.equalTo(0.05*hg)
        }
        winnerPresentBool = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if winnerPresentBool { winnerNameTF.endEditing(true) }
    }

    
    @objc func saveBtnClick() {
        UIView.animate(withDuration: 0.3) {
            self.winnerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        winnerNameTF.text == "" ? CoreDataFunc().createItem("Unknown", Int32(stepNum)) : CoreDataFunc().createItem(winnerNameTF.text!, Int32(stepNum))

        winnerLabel.removeFromSuperview()
        winnerView.removeFromSuperview()
        stepsLb.removeFromSuperview()
        winnerImage.removeFromSuperview()
        winnerNameTF.removeFromSuperview()
        saveBtn.removeFromSuperview()
        lineLB.removeFromSuperview()
        removeBtn_Restart()
        winnerPresentBool = false
    }
    
    func winnerSoundEffects() {
        let sound = Bundle.main.path(forResource: "winner", ofType: "mp3")
        do {
            avplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            avplayer.play()
        } catch  {
            print("Error")
        }
    }
}

    
