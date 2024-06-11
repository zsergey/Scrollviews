import UIKit

final class ViewController: UIViewController {
	
	private let tabScrollView = UIScrollView()
	private var pages: [UIViewController] = []
	private var buttons: [UIButton] = []
	private var currentIndex = 0
	private var productNames: [String] = []
	let pageViewController = UIPageViewController(
		transitionStyle: .scroll,
		navigationOrientation: .horizontal
	)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addPageViewController()
		setupTabScrollView()
		addTutorial()
	}
	
	private func setupTabScrollView() {

		view.addSubview(tabScrollView)
		
		let height: CGFloat = 60
		tabScrollView.showsHorizontalScrollIndicator = false
		tabScrollView.frame = CGRect(x: 0, y: view.center.y * 1.5, width: view.bounds.width, height: height)
		let padding: CGFloat = 16
		var x: CGFloat = padding
		var width: CGFloat = 0
		for index in 0..<pages.count {
			let button = UIButton()
			button.setTitle("  \(productNames[index])  ", for: .normal)
			button.backgroundColor = .white
			button.setTitleColor(.black, for: .normal)
			button.layer.cornerRadius = 12
			button.layer.cornerCurve = .continuous
			button.sizeToFit()
			button.addAction(UIAction { [weak self] _ in
				guard let self else {
					return
				}
				let currentIndex = self.index(of: self.pageViewController.viewControllers!.first!)
				let viewController = pages[index]
				pageViewController.setViewControllers([viewController],
													  direction: currentIndex < index ? .forward : .reverse,
													  animated: true)
				scrollToButton(at: index)
			}, for: .touchUpInside)
			
			width += button.frame.width + padding
			
			button.frame.origin = CGPoint(x: x, y: 0)
			tabScrollView.addSubview(button)
			x += button.frame.size.width + padding
			
			buttons.append(button)
		}
		width += padding
		
		tabScrollView.contentSize = CGSize(width: width, height: height)
	}
	
	private func addPageViewController() {
		productNames = ["🍎", "🍉", "🥑", "🍇", "🍊", "🍑", "🍓"].map { emojie in
			"Product Page " + emojie
		}
		
		pages = productNames.map { name in
			let viewController = ProductViewController()
			viewController.name = name
			return viewController
		}
		
		pageViewController.dataSource = self
		pageViewController.delegate = self
		
		addChild(pageViewController)
		view.addSubview(pageViewController.view)
		pageViewController.didMove(toParent: self)
		pageViewController.setViewControllers(
			[pages.first!],
			direction: .forward,
			animated: false
		)
	}
	
	private func addTutorial() {
		let label = UILabel()
		label.text = "Swipe product pages left or right"
		view.addSubview(label)
		label.font = .boldSystemFont(ofSize: 18.0)
		label.sizeToFit()
		label.textColor = .white
		label.center = CGPoint(x: view.center.x, y: view.center.y * 1.8)
	}
	
	private func scrollToButton(at index: Int) {
		let width = view.bounds.width
		let button = buttons[index]
		var contentOffset = button.frame.origin
		contentOffset.x -= width / 2 - button.frame.size.width / 2
		contentOffset.x = min(max(contentOffset.x, 0), tabScrollView.contentSize.width - width)
		tabScrollView.setContentOffset(contentOffset, animated: true)
	}
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	
	func pageViewController(
		_ pageViewController: UIPageViewController,
		viewControllerBefore viewController: UIViewController
	) -> UIViewController? {
		let index = index(of: viewController)
		return index == 0
		? pages.last!
		: pages[index - 1]
	}
	
	func pageViewController(
		_ pageViewController: UIPageViewController,
		viewControllerAfter viewController: UIViewController
	) -> UIViewController? {
		let index = index(of: viewController)
		return index == pages.count - 1
		? pages.first!
		: pages[index + 1]
	}
	
	func pageViewController(
		_ pageViewController: UIPageViewController,
		didFinishAnimating finished: Bool,
		previousViewControllers: [UIViewController],
		transitionCompleted completed: Bool
	) {
		if completed {
			currentIndex = index(of: pageViewController.viewControllers!.first!)
			scrollToButton(at: currentIndex)
		}
	}
	
	private func index(of vc: UIViewController) -> Int {
		pages.firstIndex {
			vc == $0
		}!
	}
}
