//
//  TabItemView.swift
//  TabBar
//
//  Created by hsnm on 2018/10/10.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

final class TabItemView: UIView {
    
    // MARK: - Instantiate
    
    static func instantiate(with type: TabContentType, tapHandler: TapHandler? = nil) -> TabItemView {
        let tabItemView = UINib(nibName: "TabItemView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! TabItemView
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: tabItemView, action: #selector(TabItemView.tapped(_:)))
        tabItemView.addGestureRecognizer(tapGesture)
        tabItemView.tapHandler = tapHandler
        tabItemView.tabContentType = type
        tabItemView.textLabel.text = type.tabText
        tabItemView.textLabel.textColor = type.tintColor
        tabItemView.imageView.image = type.image
        tabItemView.imageView.tintColor = type.tintColor
        return tabItemView
    }
    
    // MARK: - Handler
    
    typealias TapHandler = (TabContentType) -> Void
    var tapHandler: TapHandler?
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        // 連続タップ防止でアニメーション中はタップ検知させない
        guard !isTapAnimationg else { return }
        isTapAnimationg = true
        tapHandler?(tabContentType)
    }
    
    // MARK: - Properties
    
    var tabContentType: TabContentType = .a
    var isTapAnimationg = false
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    // MARK: - UITouch
    
    /// タッチ開始時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard !isTapAnimationg else { return }
        // ちょっと表示を縮小する
        UIView.animate(withDuration: 0.2) {
            self.imageView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }
    }
    
    /// タッチキャンセル時(タッチ中に電話アプリ等の別アプリから中断されたとき)
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        // 縮小を戻す
        UIView.animate(withDuration: 0.2) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    /// タッチ終了時
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        // 縮小を戻す
        UIView.animate(withDuration: 0.2) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    // MARK: - Function
    
    func configure(_ type: TabContentType) {
        if tabContentType == type {
            // 選択状態にする
            textLabel.font = UIFont.boldSystemFont(ofSize: 10)
            textLabel.textColor = type.tintColor
            imageView.tintColor = type.tintColor
            playTapImageAnimation()
            
        } else {
            // 非選択状態にする
            textLabel.font = UIFont.systemFont(ofSize: 10)
            textLabel.textColor = .darkGray
            imageView.tintColor = .darkGray
        }
    }
    
    // MARK: - Private Function
    
    /// イメージのタップアニメーションを開始
    private func playTapImageAnimation() {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [0.85, 1.1, 0.95, 1.0]
        bounceAnimation.duration = 0.4
        bounceAnimation.calculationMode = .cubic
        imageView.layer.add(bounceAnimation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isTapAnimationg = false
        }
    }
}
