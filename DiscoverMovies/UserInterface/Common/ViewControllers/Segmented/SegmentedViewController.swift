//
//  SegmentedViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SegmentedViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var segmentedView: SegmentedView = {
        var titles: [String] = []
        for vc in self.viewControllers { titles.append(vc.title ?? "" ) }
        let sv = SegmentedView(frame: .zero, segmentTitles: titles, pageView: self.pageViewController.view)
        sv.delegate = self
        return sv
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pvc.delegate = self
        pvc.dataSource = self
        return pvc
    }()
    
    private let viewControllers: [UIViewController]
    
    // MARK: - Initialize 
    
    init(viewControllers: [UIViewController], title: String? = nil) {
        guard viewControllers.count > 0 else {
            fatalError("Initialize segmentedVC with at least one view controller")
        }
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        addChildViewController(pageViewController)
        view = segmentedView
        pageViewController.didMove(toParentViewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController.setViewControllers([viewControllers.first!], direction: .forward, animated: false, completion: nil)
        segmentedView.set(selectedIndex: 0)
    }
}

// MARK: - SegmentedViewDelegate

extension SegmentedViewController: SegmentedViewDelegate {
    
    func segmentedView(_ view: SegmentedView, changedSegmentedIndexToValue toValue: Int, fromValue: Int) {
        let direction = toValue > fromValue ? UIPageViewControllerNavigationDirection.forward : UIPageViewControllerNavigationDirection.reverse
        let vc = viewControllers[toValue]
        pageViewController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDelegate

extension SegmentedViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = viewControllers.index(of: viewController)! - 1
        return index >= 0 && index < viewControllers.count ? viewControllers[index] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = viewControllers.index(of: viewController)! + 1
        return index >= 0 && index < viewControllers.count ? viewControllers[index] : nil
    }
}

// MARK: - UIPageViewControllerDataSource

extension SegmentedViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else {
            return
        }
        
        let visibleViewController = pageViewController.viewControllers!.first!
        let index = viewControllers.index(of: visibleViewController)!
        segmentedView.set(selectedIndex: index)
    }
}
