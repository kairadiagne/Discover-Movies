//
//  SegmentedViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

/// A view controller that dipslays a `UISegmentedControl` that lets the user page through several view controllers.
public class SegmentedViewController: UIViewController {

    // MARK: - Properties

    /// The segmented control used to switch between the different pages of content.
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.tintColor = .white
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    /// A page view controller which shows the different pages associated with the different segments of the segmented control.
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pvc.delegate = self
        pvc.dataSource = self
        return pvc
    }()

    /// The view controllers that should be shown in the different pages.
    private let viewControllers: [UIViewController]

    /// The index of the current presented view controller used to keep track of the scroll direction of the page view controller.
    private var currentSelectedIndex = 0

    // MARK: - Initialize 
    
    public init(viewControllers: [UIViewController], title: String? = nil) {
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

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupSegmentedControl()
        setupPageViewController()
        navigationItem.titleView = segmentedControl

        pageViewController.setViewControllers([viewControllers.first!], direction: .forward, animated: false, completion: nil)
        set(selectedIndex: 0)
    }

    private func setupPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }

    private func setupSegmentedControl() {
        for (index, vc) in viewControllers.enumerated() {
            segmentedControl.insertSegment(withTitle: vc.title, at: index, animated: false)
        }
    }

    // MARK: - Actions

    @objc private func segmentedControlValueChanged(_ control: UISegmentedControl) {
        let oldSegmentedIndex = currentSelectedIndex
        let newSegmentedIndex = control.selectedSegmentIndex
        let direction = newSegmentedIndex > oldSegmentedIndex ? UIPageViewController.NavigationDirection.forward : UIPageViewController.NavigationDirection.reverse
        let newViewController = viewControllers[newSegmentedIndex]
        pageViewController.setViewControllers([newViewController], direction: direction, animated: true, completion: nil)
        currentSelectedIndex = newSegmentedIndex
    }

    func set(selectedIndex index: Int) {
        currentSelectedIndex = index
        segmentedControl.selectedSegmentIndex = currentSelectedIndex
    }

}

// MARK: - UIPageViewControllerDelegate

extension SegmentedViewController: UIPageViewControllerDelegate {

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = viewControllers.firstIndex(of: viewController)! - 1
        return index >= 0 && index < viewControllers.count ? viewControllers[index] : nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = viewControllers.firstIndex(of: viewController)! + 1
        return index >= 0 && index < viewControllers.count ? viewControllers[index] : nil
    }
}

// MARK: - UIPageViewControllerDataSource

extension SegmentedViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        
        let visibleViewController = pageViewController.viewControllers!.first!
        let index = viewControllers.firstIndex(of: visibleViewController)!
        set(selectedIndex: index)
    }
}
