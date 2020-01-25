//
//  ViewController.swift
//  CompositionalLayout-Basic-Sample
//
//  Created by kawaharadai on 2020/01/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit
import Photos

final class PhotoListViewController: UIViewController {

    private var photoListCollectionView: UICollectionView!
    private(set) var dataSource: UICollectionViewDiffableDataSource<Int, PHAsset>!

    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoService.requestAuthorizationIfNeeded { [weak self] (canAccess) in
            guard canAccess else { fatalError("写真へのアクセスが許可されていない") }
            self?.setupCollectionView()
            self?.setupDataSource(photoList: PhotoService.photoList())
        }
    }

    func setupCollectionView() {
        photoListCollectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: PhotoListLayout.gridLayout(collectionViewBounds: view.bounds,
                                                                                           itemCount: 3))
        photoListCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        photoListCollectionView.backgroundColor = .white
        photoListCollectionView.register(PhotoListCell.nib(), forCellWithReuseIdentifier: PhotoListCell.identifier)
        view.addSubview(photoListCollectionView)
    }

    func setupDataSource(photoList: [PHAsset]) {
        dataSource = UICollectionViewDiffableDataSource<Int, PHAsset>(collectionView: photoListCollectionView, cellProvider: { (collectionView, indexPath, asset) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCell.identifier, for: indexPath) as! PhotoListCell
            cell.setImage(asset: asset)
            return cell
        })

        var resource = NSDiffableDataSourceSnapshot<Int, PHAsset>()
        resource.appendSections([0])
        resource.appendItems(photoList)
        dataSource.apply(resource, animatingDifferences: false)
    }
}

