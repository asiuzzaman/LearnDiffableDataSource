import UIKit
import SafariServices

class VideosViewController: UICollectionViewController {
  enum Section {
    case main
  }
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Video>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Video>


  // MARK: - Properties
  private var videoList = Video.allVideos
  private var searchController = UISearchController(searchResultsController: nil)
  
  private lazy var dataSource = makeDataSource()
  
  // MARK: - Value Types
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureSearchController()
    configureLayout()
    applySnapshot(animatingDifferences: false)
  }
  
  // 1
  func applySnapshot(animatingDifferences: Bool = true) {
    // 2
    var snapshot = Snapshot()
    // 3
    snapshot.appendSections([.main])
    // 4
    snapshot.appendItems(videoList)
    // 5
    dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }

  
  func makeDataSource() -> DataSource {
    // 1
    let dataSource = DataSource(
      collectionView: collectionView,
      cellProvider: { (collectionView, indexPath, video) ->
        UICollectionViewCell? in
        // 2
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "VideoCollectionViewCell",
          for: indexPath) as? VideoCollectionViewCell
        cell?.video = video
        return cell
    })
    return dataSource
  }

  
  // MARK: - Functions
}

// MARK: - UICollectionViewDataSource Number of itemSelection
extension VideosViewController {
  
}

// MARK: - UICollectionViewDelegate
extension VideosViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    
    guard let video = dataSource.itemIdentifier(for: indexPath) else {
      print("video not found")
      return
    }

    guard let link = video.link else {
      print("Invalid link")
      return
    }
    let safariViewController = SFSafariViewController(url: link)
    present(safariViewController, animated: true, completion: nil)
  }
}

// MARK: - UISearchResultsUpdating Delegate
extension VideosViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    videoList = filteredVideos(for: searchController.searchBar.text)
    applySnapshot()
  }
  
  func filteredVideos(for queryOrNil: String?) -> [Video] {
    let videos = Video.allVideos
    guard
      let query = queryOrNil,
      !query.isEmpty
      else {
        return videos
    }
    return videos.filter {
      return $0.title.lowercased().contains(query.lowercased())
    }
  }
  
  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Videos"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
}

// MARK: - Layout Handling
extension VideosViewController {
  private func configureLayout() {
    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
      let size = NSCollectionLayoutSize(
        widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
        heightDimension: NSCollectionLayoutDimension.absolute(isPhone ? 280 : 250)
      )
      let itemCount = isPhone ? 1 : 3
      let item = NSCollectionLayoutItem(layoutSize: size)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      section.interGroupSpacing = 10
      return section
    })
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: { context in
      self.collectionView.collectionViewLayout.invalidateLayout()
    }, completion: nil)
  }
}

// MARK: - SFSafariViewControllerDelegate Implementation
extension VideosViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
