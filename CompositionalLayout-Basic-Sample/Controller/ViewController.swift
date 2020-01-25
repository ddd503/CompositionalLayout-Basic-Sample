//
//  ViewController.swift
//  CompositionalLayout-Basic-Sample
//
//  Created by kawaharadai on 2020/01/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit
import Photos

final class ViewController: UIViewController {

    private var collectionView: UICollectionView!
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

    }

    func setupDataSource(photoList: [PHAsset]) {
        dataSource = UICollectionViewDiffableDataSource<Int, PHAsset>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, asset) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
            cell.setImage(asset: asset)
            return cell
        })

        var resource = NSDiffableDataSourceSnapshot<Int, PHAsset>()
        resource.appendSections([0])
        resource.appendItems(photoList)
        dataSource.apply(resource, animatingDifferences: false)
    }
}

