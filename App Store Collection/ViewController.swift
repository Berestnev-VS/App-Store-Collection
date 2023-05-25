//
//  ViewController.swift
//  AppStore Collection
//
//  Created by Владимир on 25.05.2023.
//

import UIKit

class CustomCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "App Store"
        setupCollectionView()
    }
    override func viewDidLayoutSubviews() {
        let layoutItemHeight: CGFloat = 400
        let verticalInsets = (collectionView.frame.height - layoutItemHeight) / 2
        collectionView.contentInset = UIEdgeInsets(top: verticalInsets, left: collectionView.layoutMargins.left, bottom: verticalInsets, right: collectionView.layoutMargins.right)
        
    }
    
    func setupCollectionView() {
        let layout = CenterCellFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width * 2 / 3, height: 400)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.decelerationRate = .fast 
        collectionView.showsHorizontalScrollIndicator = false

        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.labelText.text = "\(indexPath.row) cell"
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = round((offset.x + collectionView.contentInset.left) / cellWidthIncludingSpacing)
        offset = CGPoint(x: index * cellWidthIncludingSpacing - collectionView.layoutMargins.left, y: -collectionView.contentInset.top)
        targetContentOffset.pointee = offset
    }

}

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCell"
    
    var labelText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4.withAlphaComponent(0.4)
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        labelText.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        labelText.center.x = contentView.frame.midX
        labelText.center.y = contentView.frame.midY
        labelText.textAlignment = .center
        labelText.text = "cell"
        labelText.font = .boldSystemFont(ofSize: 34)
        labelText.textColor = .black
        contentView.addSubview(labelText)
       
//        contentView.layer.shadow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CenterCellFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = cellSpacing
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
