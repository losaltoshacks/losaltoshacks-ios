//
//  CampusViewController.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/23/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class CampusViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!

    // TODO: Add gestures for zoom/pan

    @IBAction func changeFloor(sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0:
            imageView.image = UIImage(named: "floor1")
        case 1:
            imageView.image = UIImage(named: "floor2")
        default:
            imageView.image = nil
        }

        scrollView.zoomScale = 1.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false

        segmentedControl.layer.zPosition = 1.0
        segmentedControl.layer.cornerRadius = 5.0

        imageView.contentMode = .ScaleAspectFit
        imageView.userInteractionEnabled = true

//        setupMapViews()
    }

    override func setupConstraints() {
        segmentedControl.snp_makeConstraints { make in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(10)
            make.centerX.equalTo(view.snp_centerX)
        }
    }

}

extension CampusViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}