import UIKit

final class ProductViewController: UIViewController {
	
	var name = ""
	
	private let scrollView = UIScrollView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupScrollView()
		setupProduct()
	}
	
	private func setupProduct() {

		view.backgroundColor = .pageBackground

		let label = UILabel()
		label.text = name
		view.addSubview(label)
		label.font = .boldSystemFont(ofSize: 25.0)
		label.sizeToFit()
		label.textColor = .white
		label.center = CGPoint(x: view.center.x, y: view.center.y * 0.2)
	}
	
	private func setupScrollView() {
		
		view.addSubview(scrollView)
		
		scrollView.backgroundColor = .white
		scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
		
		let colors: [UIColor] = [.color1, .color2, .color3, .color4, .color5].shuffled()
		let width = view.bounds.width
		let height = view.bounds.height
		let count = colors.count
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		let size = CGSize(width: width * 0.8, height: height * 0.7)
		scrollView.frame = CGRect(origin: .zero, size: size)
		scrollView.contentSize = CGSize(width: size.width, height: size.height * CGFloat(count))
		scrollView.layer.cornerRadius = 24
		scrollView.layer.cornerCurve = .continuous
		scrollView.center = view.center
		
		for index in 0..<count {
			let view = UIView()
			
			view.backgroundColor = colors[index]
			view.frame = CGRect(x: 0, y: CGFloat(index) * size.height, width: size.width, height: size.height)
			scrollView.addSubview(view)
			
			let label = UILabel()
			label.text = "← Swipe →"
			view.addSubview(label)
			label.font = .boldSystemFont(ofSize: 18.0)
			label.sizeToFit()
			label.textColor = .white
			label.center = CGPoint(x: 40, y: size.height / 2)
			label.transform = CGAffineTransform(rotationAngle: .pi / 2)
		}
	}
}
