//
//  DetailPhotoViewController.swift
//  PhotoViewer
//
//  Created by keith martin on 8/24/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import UIKit
import Kingfisher
import UICircularProgressRing

class DetailPhotoViewController: UIViewController {
    
    private let progressRingView: UICircularProgressRingView
    private let detailPhotoImageView: UIImageView
    private let detailPhotoUrl: String
    
    init(detailPhotoUrl: String) {
        self.detailPhotoUrl = detailPhotoUrl
        detailPhotoImageView = UIImageView(frame: .zero)
        progressRingView = UICircularProgressRingView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setDetailPhotoImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupUI() {
        title = "Detail Photo"
        self.navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        setupDetailPhotoImageView()
    }
    
    private func setDetailPhotoImage() {
        let detailPhotoProcessor = ResizingImageProcessor(referenceSize: CGSize(width: view.frame.width, height: view.frame.height))
        
        // Set progress of progress ring as imageview image is downloaded and set
        detailPhotoImageView.kf.setImage(with: URL(string: detailPhotoUrl), placeholder: nil, options: [.processor(detailPhotoProcessor)], progressBlock: { (receivedSize, totalSize) in
            let percentage = (CGFloat(receivedSize) / CGFloat(totalSize)) * 100.0
            DispatchQueue.main.async {
                self.progressRingView.setProgress(value: percentage, animationDuration: 0)
            }
        }) { (_, _, _, _) in
            DispatchQueue.main.async {
                self.progressRingView.removeFromSuperview()
            }
        }
    }
    
    private func setupDetailPhotoImageView() {
        detailPhotoImageView.backgroundColor = .backgroundLightGrey
        view.addSubview(detailPhotoImageView)
        
        createDetailPhotoImageViewConstraints()
        
        setupProgressRingView()
    }
    
    private func createDetailPhotoImageViewConstraints() {
        detailPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        detailPhotoImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        detailPhotoImageView.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        detailPhotoImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupProgressRingView() {
        progressRingView.shouldShowValueText = false
        progressRingView.outerRingWidth = 2
        progressRingView.outerRingColor = .backgroundGrey
        progressRingView.outerCapStyle = .square
        progressRingView.innerRingColor = .black
        progressRingView.innerRingWidth = 2
        progressRingView.ringStyle = .ontop
        progressRingView.maxValue = 100
        detailPhotoImageView.addSubview(progressRingView)
        
        createProgressRingViewConstraints()
    }
    
    private func createProgressRingViewConstraints() {
        progressRingView.translatesAutoresizingMaskIntoConstraints = false
        progressRingView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        progressRingView.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        progressRingView.centerXAnchor.constraint(equalTo: detailPhotoImageView.centerXAnchor).isActive = true
        progressRingView.centerYAnchor.constraint(equalTo: detailPhotoImageView.centerYAnchor).isActive = true
    }
}
