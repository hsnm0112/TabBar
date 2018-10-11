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
        tapHandler?(tabContentType)
    }
    
    // MARK: - Properties
    
    var tabContentType: TabContentType = .a

    // MARK: - IBOutlet
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    // MARK: - UITouch
    
    /// タッチ開始時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        playImageAnimation(.tapping)
    }
    
    /// タッチ終了時
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        playImageAnimation(.cancel)
    }
    
    // MARK: - Function
    
    func configure(_ type: TabContentType, animated: Bool) {
        if tabContentType == type {
            // 選択状態にする
            textLabel.font = UIFont.boldSystemFont(ofSize: 10)
            textLabel.textColor = type.tintColor
            imageView.tintColor = type.tintColor
            if animated {
                playImageAnimation(.bounce)
            }
        } else {
            // 非選択状態にする
            textLabel.font = UIFont.systemFont(ofSize: 10)
            textLabel.textColor = .darkGray
            imageView.tintColor = .darkGray
        }
    }
    
    // MARK: - Private Function
    
    private enum AnimationType {
        case tapping
        case cancel
        case bounce
        
        var values: [Float] {
            switch self {
            case .tapping:
                return [1.0, 0.85]
            case .cancel:
                return [0.85, 1.0]
            case .bounce:
                return [0.85, 1.1, 0.95, 1.0]
            }
        }
        
        var duration: CFTimeInterval {
            switch self {
            case .tapping:
                return 0.1
            case .cancel:
                return 0.1
            case .bounce:
                return 0.4
            }
        }
    }
    
    /// イメージのタップアニメーションを開始
    private func playImageAnimation(_ animationType: AnimationType) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = animationType.values
        bounceAnimation.duration = animationType.duration
        bounceAnimation.calculationMode = .cubic
        bounceAnimation.isRemovedOnCompletion = false
        bounceAnimation.fillMode = .forwards
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
}
