//
//  ViewController.swift
//  OmikujiiApp
//
//  Created by 茶谷美咲 on 2020/09/14.
//  Copyright © 2020 Misaki Chatani. All rights reserved.
//

import UIKit
//音楽を再生するロキに必要なもの
import AVFoundation


class ViewController: UIViewController {
//  音楽再生用の変数を定義する
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    
    
    @IBOutlet var stickView: UIView!
    
    @IBOutlet var stickLabel: UILabel!
    
    @IBOutlet var stickHeight: NSLayoutConstraint!
    
    @IBOutlet var stickBottomMargin: NSLayoutConstraint!
    
    @IBOutlet var overView: UIView!
    
    
    
    
    @IBOutlet var BigLabel: UILabel!
    
    let resultTexts: [String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    
    
    
    @IBAction func tapRetryButton(_ sender: Any) {
        /*** リトライボタンを押したときの処理 ***/
        overView.isHidden = true
        stickBottomMargin.constant = 0
        
    }

    //結果表示するときに鳴らす音の準備
    func setupSound() {
        
//  ifletと記述して、読み込んだ結果が存在する場合にのみ処理する
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3") {
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
        }
    }
//    ここまで追記

    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false {
                   // シェイクモーションで作動させるコード
                   // 結果の表示中は動作させない
            // シェイクモーション以外では動作させない
            return
        }
        let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)) )
        stickLabel.text = resultTexts[resultNum]
        stickBottomMargin.constant = stickHeight.constant * -1

        UIView.animate(withDuration: 1, animations: {

            self.view.layoutIfNeeded()

            }, completion: { (finished: Bool) in
                // 後ほど記述します。
                UIView.animate(withDuration: 1.0, animations: {

                    self.view.layoutIfNeeded()

                    }, completion: { (finished: Bool) in
                        self.BigLabel.text = self.stickLabel.text
                        self.overView.isHidden = false
                })
                //次の1行を追加 -> 結果表示のときに音を再生(Play)する！
                self.resultAudioPlayer.play()
        })
        
        

        func viewDidLoad() {
        super.viewDidLoad()
        setupSound()
//      効果音を読み込む
    }


}
}

