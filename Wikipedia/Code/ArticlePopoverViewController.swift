import UIKit


protocol ArticlePopoverViewControllerDelegate: NSObjectProtocol {
    func articlePopoverViewController(articlePopoverViewController: ArticlePopoverViewController, didSelectAction: WMFArticleAction)
}

class ArticlePopoverViewController: UIViewController {

    weak var delegate: ArticlePopoverViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    
    @IBOutlet weak var articleSummaryView: UIView!
    
    let article: WMFArticle
    
    required init(_ article: WMFArticle) {
        self.article = article
        super.init(nibName: "ArticlePopoverViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        articleSummaryView.addGestureRecognizer(tapGR)
        
        //shareButton.setTitle(localizedStringForKeyFallingBackOnEnglish("action-share"), for: .normal)
        shareButton.setImage(#imageLiteral(resourceName: "places-share"), for: .normal)
        
        readButton.setTitle(localizedStringForKeyFallingBackOnEnglish("action-read"), for: .normal)
        readButton.setImage(#imageLiteral(resourceName: "places-more"), for: .normal)
        
//        let saveTitle = article.savedDate == nil ? localizedStringForKeyFallingBackOnEnglish("action-save") : localizedStringForKeyFallingBackOnEnglish("action-unsave")
//        saveButton.setTitle(saveTitle, for: .normal)
        let saveImage = article.savedDate == nil ? #imageLiteral(resourceName: "places-save"): #imageLiteral(resourceName: "places-unsave")
        saveButton.setImage(saveImage, for: .normal)
        
        titleLabel.text = article.displayTitle
        subtitleLabel.text = article.wikidataDescription
    }
    
    func handleTapGesture(_ tapGR: UITapGestureRecognizer) {
        switch tapGR.state {
        case .recognized:
            delegate?.articlePopoverViewController(articlePopoverViewController: self, didSelectAction: .read)
        default:
            break
        }
    }
    
    @IBAction func save(_ sender: Any) {
        delegate?.articlePopoverViewController(articlePopoverViewController: self, didSelectAction: .save)
    }
    
    @IBAction func share(_ sender: Any) {
        delegate?.articlePopoverViewController(articlePopoverViewController: self, didSelectAction: .share)
    }
    
    @IBAction func read(_ sender: Any) {
        delegate?.articlePopoverViewController(articlePopoverViewController: self, didSelectAction: .read)
    }
    
}

