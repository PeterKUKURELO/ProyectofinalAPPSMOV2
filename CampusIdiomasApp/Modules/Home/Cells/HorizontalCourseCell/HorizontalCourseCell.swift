import UIKit

final class HorizontalCourseCell: UITableViewCell {

    static let identifier = "HorizontalCourseCell"

    @IBOutlet private weak var collectionView: UICollectionView!

    private var items: [CourseItem] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupCollectionView()
    }

    func configure(items: [CourseItem]) {
        self.items = items

        // Asegura que el collectionView ya tenga su tamaño final
        contentView.layoutIfNeeded()
        collectionView.layoutIfNeeded()

        // Recalcula tamaños
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        // Layout horizontal tipo carrusel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 14
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        collectionView.collectionViewLayout = layout

        collectionView.register(
            UINib(nibName: CourseCardCollectionCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CourseCardCollectionCell.identifier
        )
    }
}

extension HorizontalCourseCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CourseCardCollectionCell.identifier,
            for: indexPath
        ) as! CourseCardCollectionCell

        cell.configure(with: items[indexPath.item])
        return cell
    }
}

extension HorizontalCourseCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Ancho tipo card como tu mock
        let height = collectionView.bounds.height
        let width = min(320, UIScreen.main.bounds.width * 0.75)
        return CGSize(width: width, height: height)
    }
}
