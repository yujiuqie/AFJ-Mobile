//
//  ScaleSlider.swift
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/12/31.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

import UIKit

struct Defauts {
    static let normalImage = UIImage(named: "slider_normal")!
    static let selectedImage = UIImage(named: "slider_touchon")!
    static let trackColor: UIColor = .lightGray
    static let progressColor: UIColor = .orange
    static let trackHeigth: CGFloat = 5.0
    static let indexVPadding: CGFloat = 10.0
    static let indexHeight: CGFloat = 25.0
    static let indexFont: UIFont = UIFont.systemFont(ofSize: 12)
    static let titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    static let valueFont: UIFont = UIFont.systemFont(ofSize: 14)
    static let titleColor: UIColor = .orange
    static let valueColor: UIColor = .darkGray
    static let sliderCallback: ((low: Int, high: Int)) -> String = { scale in
        if scale.0 == 0 && scale.1 == 51 {
            return "不限"
        } else if scale.1 == 51 {
            return "\(scale.0)以上"
        }
        return "\(scale.0)-\(scale.1)"
    }
}


class ScaleSlider: UIView {

    @objc public var valueChanged: ((_ valye: String?) -> Void)?
    @objc public var width: CGFloat = 200;
    @objc public var height: CGFloat = 2
    @objc public var normalImage: UIImage = UIImage(named: "slider_normal") ?? UIImage()
    @objc public var selectedImage: UIImage = UIImage(named: "slider_touchon") ?? UIImage()
    @objc public var trackColor: UIColor = .lightGray
    @objc public var progressColor: UIColor = .orange
//    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    @objc public var realCount: Int = 0
    @objc public var indexTitles: [String] = [String]()
    @objc public var scaleValue: Int = 1
    @objc public var trackHeight: CGFloat = 5.0
    @objc public var indexFont: UIFont = UIFont.systemFont(ofSize: 12)
    @objc public var indexHeight: CGFloat = 25.0
    @objc public var imgWidth: CGFloat = 25
    @objc public var trackWidth: CGFloat = 200 - 25

    private let trackView = UIView()
    private let progressView = UIView()
    private let indexView = UIView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let leftThumb = UIImageView()
    private let rightThumb = UIImageView()

    var sliderCallback: (((low: Int, high: Int)) -> String)?
    var title: String = "车价(万元)" {
        didSet {
            titleLabel.text = title
        }
    }

    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        self.width = frame.width
        self.height = frame.height
        self.imgWidth = normalImage.size.width
        self.trackWidth = width - imgWidth
        placeSubViews()
    }

    @objc public init(frame: CGRect,
                      normalImage: UIImage = Defauts.normalImage,
                      selectedImage: UIImage = Defauts.selectedImage,
                      trackColor: UIColor = Defauts.trackColor,
                      progressColor: UIColor = Defauts.progressColor,
                      realCount: Int = 0,
                      indexTitle: [String],
                      scaleValue: Int = 1,
                      trackHeight: CGFloat = Defauts.trackHeigth,
                      indexFont: UIFont = Defauts.indexFont,
                      indexHeight: CGFloat = Defauts.indexHeight) {
        self.width = frame.width
        self.height = frame.height
        self.normalImage = normalImage
        self.selectedImage = selectedImage
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.indexTitles = indexTitle
        self.scaleValue = scaleValue
        self.trackHeight = trackHeight
        self.indexFont = indexFont
        self.indexHeight = indexHeight
        self.realCount = (realCount == 0) ? indexTitle.count - 1 : realCount
        self.imgWidth = normalImage.size.width
        self.trackWidth = width - imgWidth
        self.titleLabel.text = title
        if realCount < 1 {
            fatalError("ScaleSlider: count of indexTitles must over 1")
        }
        super.init(frame: frame)
        placeSubViews()
    }

    @objc public func reset() {
        placeSubViews()
        callBack()
    }

    @objc public func placeSubViews() {

        titleLabel.frame = CGRect(x: 0, y: 0, width: width / 2, height: 20)
        valueLabel.frame = CGRect(x: width / 2, y: 0, width: width / 2, height: 20)
        leftThumb.frame = CGRect(x: 0, y: 25, width: imgWidth, height: imgWidth)
        rightThumb.frame = CGRect(x: width - imgWidth, y: 25, width: imgWidth, height: imgWidth)
        trackView.frame = CGRect(x: imgWidth / 2, y: imgWidth / 2 + 25, width: width - imgWidth, height: trackHeight)
        progressView.frame = CGRect(x: imgWidth / 2, y: imgWidth / 2 + 25, width: width - imgWidth, height: trackHeight)
        indexView.frame = CGRect(x: imgWidth / 2, y: imgWidth + Defauts.indexVPadding + 25, width: width - imgWidth, height: indexHeight)
        trackView.layer.cornerRadius = trackHeight / 2
        self.addSubview(trackView)
        self.addSubview(progressView)
        self.addSubview(indexView)
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        self.addSubview(leftThumb)
        self.addSubview(rightThumb)
        subviewsSet()
        setGestures()
        setIndexLabels()
        adaptHeight()
        self.valueLabel.text = "0-500"//额外加的初始化
    }

    private func adaptHeight() {
        let maxY = indexView.frame.maxY
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: maxY)
    }

    private func subviewsSet() {
        titleLabel.font = Defauts.titleFont
        titleLabel.textColor = Defauts.titleColor
        titleLabel.textAlignment = .left
        valueLabel.font = Defauts.valueFont
        valueLabel.textColor = Defauts.valueColor
        valueLabel.textAlignment = .center
        trackView.backgroundColor = trackColor
        progressView.backgroundColor = progressColor
        leftThumb.image = normalImage
        rightThumb.image = normalImage
        leftThumb.isUserInteractionEnabled = true
        rightThumb.isUserInteractionEnabled = true
    }

    private func setGestures() {
        let leftPan = UIPanGestureRecognizer(target: self, action: #selector(panAction(pan:)))
        let rightPan = UIPanGestureRecognizer(target: self, action: #selector(panAction(pan:)))
        leftThumb.addGestureRecognizer(leftPan)
        rightThumb.addGestureRecognizer(rightPan)
    }

    private func setIndexLabels() {
        for label in indexView.subviews {
            label.removeFromSuperview()
        }
        let labelWidth = trackWidth / CGFloat(indexTitles.count - 1)
        for title in indexTitles {
            let idx = CGFloat(indexTitles.index(of: title)!)
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: Defauts.indexHeight))
            label.center = CGPoint(x: idx * labelWidth, y: label.center.y)
            label.font = Defauts.indexFont
            label.textAlignment = .center
            label.text = title
            indexView.addSubview(label)
        }
    }

    @objc private func panAction(pan: UIPanGestureRecognizer) {
        let pt = pan.translation(in: self)
        let rect = progressView.frame
        let realScale = trackWidth / CGFloat(realCount)
        let pv = pan.view! as! UIImageView
        var newCenter = CGPoint(x: pv.center.x + pt.x, y: pv.center.y)
        if pv == leftThumb {
            newCenter.x = max(newCenter.x, imgWidth / 2)
            let maxX = rightThumb.frame.minX - realScale + imgWidth / 2
            newCenter.x = min(newCenter.x, maxX)
        } else {
            newCenter.x = min(newCenter.x, width - imgWidth / 2)
            let minX = leftThumb.frame.maxX + realScale - imgWidth / 2
            newCenter.x = max(newCenter.x, minX)
        }
        pv.center = newCenter
        progressView.frame = CGRect(x: leftThumb.center.x, y: rect.origin.y, width: rightThumb.center.x - leftThumb.center.x, height: rect.height)
        pan.setTranslation(.zero, in: self)
        if pan.state == .began {
            pv.image = selectedImage
//            impactFeedback.impactOccurred()
        } else if pan.state == .changed {
            callBack()
        } else {
            if leftThumb.frame.intersects(rightThumb.frame) {
                self.bringSubviewToFront(pv)
            }
            pv.image = normalImage
            let rate: Int = Int(round((newCenter.x - imgWidth / 2) / realScale))
            newCenter.x = CGFloat(rate) * realScale + imgWidth / 2
            pv.center = newCenter
            progressView.frame = CGRect(x: leftThumb.center.x, y: rect.origin.y, width: rightThumb.center.x - leftThumb.center.x, height: rect.height)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
                self.layoutIfNeeded()
            }, completion: nil)

        }
    }

    private func callBack() {
        let realScale = trackWidth / CGFloat(realCount)
        let low = Int(round((leftThumb.center.x - imgWidth / 2) / realScale)) * scaleValue
        let high = Int(round((rightThumb.center.x - imgWidth / 2) / realScale)) * scaleValue
        let callback = sliderCallback ?? Defauts.sliderCallback
        let str = callback((low: low, high: high))
        valueLabel.text = str//---------------------
        valueChanged?(str)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

