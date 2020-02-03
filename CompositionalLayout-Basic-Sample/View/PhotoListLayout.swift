//
//  PhotoListLayout.swift
//  CompositionalLayout-Basic-Sample
//
//  Created by kawaharadai on 2020/01/25.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

final class PhotoListLayout {
    /// グリッド形式のレイアウトを生成する
    /// - Parameters:
    ///   - collectionViewBounds: UICollectionViewのBounds
    ///   - itemCount: 1列に表示するitemの個数
    static func gridLayout(collectionViewBounds: CGRect, itemCount: Int) -> UICollectionViewLayout {
        let lineCount = itemCount - 1
        let itemSpacing = CGFloat(1) // セル間のスペース
        let itemLength = (collectionViewBounds.width - (itemSpacing * CGFloat(lineCount))) / CGFloat(itemCount)
        // １つのitemを生成
        // .absoluteは固定値で指定する方法
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(itemLength),
                                                                             heightDimension: .absolute(itemLength)))
        // itemを3つ横並びにしたGroupを生成
        // .fractional~は親Viewとの割合
        let items = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                          heightDimension: .fractionalHeight(1.0)),
                                                       subitem: item,
                                                       count: itemCount)
        // Group内のitem間のスペースを設定
        items.interItemSpacing = .fixed(itemSpacing)

        // 生成したGroup(items)が縦に並んでいくGroupを生成（実質これがSection）
        let groups = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                         heightDimension: .absolute(itemLength)),
                                                      subitems: [items])
        // 用意したGroupを基にSectionを生成
        // 基本的にセルの数は意識しない、セルが入る構成(セクション)を用意しておくだけで勝手に流れてく
        let section = NSCollectionLayoutSection(group: groups)

        // Section間のスペースを設定
        section.interGroupSpacing = itemSpacing

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}
