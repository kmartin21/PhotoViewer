//
//  PhotoFeedViewController.swift
//  PhotoViewer
//
//  Created by keith martin on 8/18/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoFeedViewController: UIViewController {
    
    fileprivate var collectionView: UICollectionView
    fileprivate var photos: [Photo] = []
    fileprivate var thumbnailPhotoProcessor: ResizingImageProcessor!
    private let refreshControl: UIRefreshControl
    private let photoService: PhotoService
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        refreshControl = UIRefreshControl(frame: .zero)
        
        self.photoService = PhotoService()
        
        /* Set a max memory cost and disk cache size to keep the image cache
           from taking a large amount of space */
        ImageCache.default.maxMemoryCost = 10 * 1024 * 1024
        ImageCache.default.maxDiskCacheSize = 50 * 1024 * 1024
        super.init(nibName: nil, bundle: nil)
        
        let photoSpacing = flowLayout.minimumInteritemSpacing + flowLayout.sectionInset.left
        let photoSize = CGSize(width: view.frame.width/2 - photoSpacing, height: view.frame.width/2 - photoSpacing)
        thumbnailPhotoProcessor = ResizingImageProcessor(referenceSize: photoSize)
        flowLayout.itemSize = photoSize
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    private func setupUI() {
        title = "Photo Viewer"
        view.backgroundColor = .white
        
        setupRefreshControl()
        setupCollectionView()
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        createCollectionViewConstraints()
    }
    
    private func createCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func fetchImages() {
        photoService.fetchImages { (photosResult, error) in
            guard error == nil, let photos = photosResult else {
                showAlertMessage(message: "Could not retrieve photos", messageType: .fail)
                self.endRefreshing()
                return
            }
            self.photos = photos
            self.reloadData()
            self.endRefreshing()
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        clearImageCache()
        fetchImages()
    }
    
    private func clearImageCache() {
        ImageCache.default.clearDiskCache()
        ImageCache.default.clearMemoryCache()
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}

extension PhotoFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.thumbnailImageView.kf.setImage(with: URL(string: photo.thumbnailUrl), placeholder: nil, options: [.processor(thumbnailPhotoProcessor)], progressBlock: nil, completionHandler: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoCollectionViewCell else { return }
        cell.thumbnailImageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        
        let detailPhotoViewController = DetailPhotoViewController(detailPhotoUrl: photo.url)
        
        navigationController?.pushViewController(detailPhotoViewController, animated: true)
    }
}
