//
//  NewsCell.swift
//  VKClient
//
//  Created by Роман Мисников on 10.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    // MARK: - Constants
    struct Constant {
        // insets constants
        static let cellInset: CGFloat = 4.0
        static let insets: CGFloat = 16.0
        static let titleToDateInset: CGFloat = 0.0
        static let iconsInset: CGFloat = 8.0
        // images size (w and h)
        static let avatarSize: CGFloat = 60.0
        static let iconSize: CGFloat = 25.0
        static let titleHeight: CGFloat = 24.0
        static let pictureHeight: CGFloat = 200.0
        // font constants
        static let titleFont = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        static let dateFont = UIFont.systemFont(ofSize: 14.0, weight: .light)
        static let bodyFont = UIFont.systemFont(ofSize: 14.0)
    }
    
    // MARK: - UI components
    let avatarImageView = UIImageView()
    let titleLbl = UILabel()
    let timeLbl = UILabel()
    let bodyLbl = UILabel()
    let pictureImageView = UIImageView()
    let likesImageView = UIImageView()
    let likesLbl = UILabel()
    let repostsImageView = UIImageView()
    let repostsLbl = UILabel()
    let commentsImageView = UIImageView()
    let commentsLbl = UILabel()
    let viewsImageView = UIImageView()
    let viewsLbl = UILabel()
    
    private var containsImage: Bool = false
    
    // MARK: - Variable
    private var cellSize = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    // MARK: - Cell life cycle functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // cancel auto calculation of constraints
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        bodyLbl.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        likesImageView.translatesAutoresizingMaskIntoConstraints = false
        likesLbl.translatesAutoresizingMaskIntoConstraints = false
        repostsImageView.translatesAutoresizingMaskIntoConstraints = false
        repostsLbl.translatesAutoresizingMaskIntoConstraints = false
        commentsImageView.translatesAutoresizingMaskIntoConstraints = false
        commentsLbl.translatesAutoresizingMaskIntoConstraints = false
        viewsImageView.translatesAutoresizingMaskIntoConstraints = false
        viewsLbl.translatesAutoresizingMaskIntoConstraints = false
        
        // get cell origin (top left angle)
        cellSize = contentView.frame
        
        // setup all UI components
        setupAvatarImage(cellSize)
        setupTitleLbl(cellSize)
        setupTimeLbl(cellSize)
        setupBodyLbl(cellSize)
        setupPictureImageView(cellSize)
        setupLikesImageView(cellSize)
        setupLikesLbl(cellSize)
        setupRepostsImageView(cellSize)
        setupRepostsLbl(cellSize)
        setupCommentsImageView(cellSize)
        setupCommentLbl(cellSize)
        setupViewImageView(cellSize)
        setupViewLbl(cellSize)
        
        // add subviews to view
        contentView.addSubview(avatarImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(timeLbl)
        contentView.addSubview(bodyLbl)
        contentView.addSubview(pictureImageView)
        contentView.addSubview(likesImageView)
        contentView.addSubview(likesLbl)
        contentView.addSubview(repostsImageView)
        contentView.addSubview(repostsLbl)
        contentView.addSubview(commentsImageView)
        contentView.addSubview(commentsLbl)
        contentView.addSubview(viewsImageView)
        contentView.addSubview(viewsLbl)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        setupAvatarImage(cellSize)
        setupTitleLbl(cellSize)
        setupTimeLbl(cellSize)
        setupBodyLbl(cellSize)
        setupPictureImageView(cellSize)
        setupLikesImageView(cellSize)
        setupLikesLbl(cellSize)
        setupRepostsImageView(cellSize)
        setupRepostsLbl(cellSize)
        setupCommentsImageView(cellSize)
        setupCommentLbl(cellSize)
        setupViewImageView(cellSize)
        setupViewLbl(cellSize)
    }
    
    // MARK: - Setup methods
    private func setupAvatarImage(_ cellSize: CGRect) {
        // configure avatarImageView
        let avatarOrigin = CGPoint(x: ceil(cellSize.origin.x + Constant.insets), y: ceil(cellSize.origin.y + Constant.insets))
        //avatarImageView.image = #imageLiteral(resourceName: "avatar-man")
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = Constant.avatarSize / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.frame = CGRect(origin: avatarOrigin, size: CGSize(width: Constant.avatarSize, height: Constant.avatarSize))
        //avatarImageView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    
    private func setupTitleLbl(_ cellSize: CGRect) {
        // calculate frame
        let titleOriginX = ceil(2 * Constant.insets + avatarImageView.frame.width)
        let titleOriginY = ceil(avatarImageView.frame.origin.y + Constant.avatarSize / 2 - Constant.titleToDateInset / 2 - Constant.titleHeight)
        let titleSizeWidth = ceil(cellSize.width - (Constant.avatarSize + 3 * Constant.insets))
        let titleSizeHeight = ceil(Constant.titleHeight)
        // set frame
        titleLbl.frame = CGRect(x: titleOriginX, y: titleOriginY, width: titleSizeWidth, height: titleSizeHeight)
        // visual setup
        //titleLbl.text = "Varlamov.ru"
        //titleLbl.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        titleLbl.font = Constant.titleFont
    }
  
    private func setupTimeLbl(_ cellSize: CGRect) {
        // calculate frame
        let timeOriginX = ceil(titleLbl.frame.origin.x)
        let timeOriginY = ceil(titleLbl.frame.origin.y + titleLbl.frame.size.height + Constant.titleToDateInset)
        let timeSizeWidth = ceil(titleLbl.frame.size.width)
        let timeSizeHeight = ceil(titleLbl.frame.size.height)
        // set frame
        timeLbl.frame = CGRect(x: timeOriginX, y: timeOriginY, width: timeSizeWidth, height: timeSizeHeight)
        // visual setup
        //timeLbl.text = "15 минут назад"
        timeLbl.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        //timeLbl.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        timeLbl.font = Constant.dateFont
    }
    
    private func setupBodyLbl(_ cellSize: CGRect) {
        guard let text = self.bodyLbl.text else { return }
        let haveNoText: Bool = (text == "")
        // calculate frame
        let bodyOriginX = ceil(avatarImageView.frame.origin.x)
        let bodyOriginY = ceil(avatarImageView.frame.origin.y + Constant.avatarSize + (haveNoText ? 0.0 : Constant.insets))
        let bodySizeWidth = ceil(cellSize.size.width - 2 * Constant.insets)
        let bodySizeHeight: CGFloat = haveNoText ? 0.0 :ceil(​getLabelSize(text: text, font: Constant.bodyFont, maxWidth: cellSize.size.width - 2 * Constant.insets).height)
        // set frame
        bodyLbl.frame = CGRect(x: bodyOriginX, y: bodyOriginY, width: bodySizeWidth, height: bodySizeHeight)
        // visual setup
        bodyLbl.numberOfLines = 0
        //bodyLbl.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        bodyLbl.font = Constant.dateFont
    }
    
    private func setupPictureImageView(_ cellSize: CGRect) {
        // calculate frame
        let pictureOriginX = ceil(bodyLbl.upLeftCorner.x)
        let pictureOriginY = ceil(bodyLbl.downLeftCorner.y + Constant.insets)
        let pictureSizeWidth = ceil(cellSize.size.width - 2 * Constant.insets)
        let pictureSizeHeight = containsImage ? ceil(Constant.pictureHeight) : 0.0
        // set frame
        pictureImageView.frame = CGRect(x: pictureOriginX, y: pictureOriginY, width: pictureSizeWidth, height: pictureSizeHeight)
        // visual setup
        //pictureImageView.image = #imageLiteral(resourceName: "loginbg")
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.clipsToBounds = true
        pictureImageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    private func setupLikesImageView(_ cellSize: CGRect) {
        // calculate frame
        let likesImgOriginX = ceil(pictureImageView.downLeftCorner.x)
        let likesImgOriginY = ceil(pictureImageView.downLeftCorner.y + Constant.insets)
        let likeImgSizeWidth = ceil(Constant.iconSize)
        let likeImgSizeHeight = ceil(Constant.iconSize)
        // set frame
        likesImageView.frame = CGRect(x: likesImgOriginX, y: likesImgOriginY, width: likeImgSizeWidth, height: likeImgSizeHeight)
        // visual setup
        likesImageView.image = #imageLiteral(resourceName: "like")
        likesImageView.contentMode = .scaleAspectFit
        likesImageView.clipsToBounds = true
//        likesImageView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    
    private func setupLikesLbl(_ cellSize: CGRect) {
        // get text
        guard let text = self.likesLbl.text else { return }
        // calculate frame
        let likesOriginX = likesImageView.upRightCorner.x + Constant.iconsInset - 2.0
        let likesOriginY = likesImageView.upRightCorner.y
        let likesLblWidth = ​getLabelSize(text: text, font: Constant.bodyFont, maxWidth: 100.0).width
        let likesLblHeight = likesImageView.frame.height
        // set frame
        likesLbl.frame = CGRect(x: likesOriginX, y: likesOriginY, width: likesLblWidth, height: likesLblHeight)
        // visual setup
        likesLbl.font = Constant.bodyFont
        //likesLbl.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    private func setupRepostsImageView(_ cellSize: CGRect) {
        // calculate frame
        let originX = likesLbl.upRightCorner.x + Constant.iconsInset - 2.0
        let originY = likesLbl.upRightCorner.y
        let origin = CGPoint(x: originX, y: originY)
        let size = likesImageView.frame.size
        // set frame
        repostsImageView.frame = CGRect(origin: origin, size: size)
        // visual setup
        repostsImageView.image = #imageLiteral(resourceName: "reload")
        repostsImageView.contentMode = .scaleAspectFit
        repostsImageView.clipsToBounds = true
//        repostsImageView.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }
    
    private func setupRepostsLbl(_ cellSize: CGRect) {
        // get text
        guard let text = self.repostsLbl.text else { return }
        // calculate frame
        let originX = repostsImageView.upRightCorner.x + Constant.iconsInset - 2.0
        let originY = repostsImageView.upRightCorner.y
        let repostsLblWidth = ​getLabelSize(text: text, font: Constant.bodyFont, maxWidth: 100.0).width
        let repostsLblHeight = likesImageView.frame.height
        // set frame
        repostsLbl.frame = CGRect(x: originX, y: originY, width: repostsLblWidth, height: repostsLblHeight)
        // visual setup
        repostsLbl.font = Constant.bodyFont
        //repostsLbl.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    private func setupCommentsImageView(_ cellSize: CGRect) {
        // calculate frame
        let originX = repostsLbl.upRightCorner.x + Constant.iconsInset + 2.0
        let originY = repostsLbl.upRightCorner.y
        let origin = CGPoint(x: originX, y: originY)
        let size = repostsImageView.frame.size
        // set frame
        commentsImageView.frame = CGRect(origin: origin, size: size)
        // visual setup
        commentsImageView.image = #imageLiteral(resourceName: "chat")
        commentsImageView.contentMode = .scaleAspectFit
        commentsImageView.clipsToBounds = true
//        commentsImageView.backgroundColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
    }
    
    private func setupCommentLbl(_ cellSize: CGRect) {
        // get text
        guard let text = commentsLbl.text else { return }
        // calculate frame
        let originX = commentsImageView.upRightCorner.x + Constant.iconsInset
        let originY = commentsImageView.upRightCorner.y
        let commentsLblWidth = ​getLabelSize(text: text, font: Constant.bodyFont, maxWidth: 100.0).width
        let commentsLblHeight = repostsImageView.frame.height
        // set frame
        commentsLbl.frame = CGRect(x: originX, y: originY, width: commentsLblWidth, height: commentsLblHeight)
        // visual setup
        commentsLbl.font = Constant.bodyFont
        //commentsLbl.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    }
    
    private func setupViewImageView(_ cellSize: CGRect) {
        // calculate frame
        let originX = commentsLbl.upRightCorner.x + Constant.iconsInset
        let originY = commentsLbl.upRightCorner.y
        let origin = CGPoint(x: originX, y: originY)
        let size = commentsImageView.frame.size
        // set frame
        viewsImageView.frame = CGRect(origin: origin, size: size)
        // visual setup
        viewsImageView.image = #imageLiteral(resourceName: "eye")
        viewsImageView.contentMode = .scaleAspectFit
        viewsImageView.clipsToBounds = true
//        viewsImageView.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
    }
    
    private func setupViewLbl(_ cellSize: CGRect) {
        // get text
        guard let text = viewsLbl.text else { return }
        // calculate frame
        let originX = viewsImageView.upRightCorner.x + Constant.iconsInset
        let originY = viewsImageView.upRightCorner.y
        let commentsLblWidth = ​getLabelSize(text: text, font: Constant.bodyFont, maxWidth: 100.0).width
        let commentsLblHeight = viewsImageView.frame.height
        // set frame
        viewsLbl.frame = CGRect(x: originX, y: originY, width: commentsLblWidth, height: commentsLblHeight)
        // visual setup
        viewsLbl.font = Constant.bodyFont
        //viewsLbl.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    // расчет высоты ячейки с текстом исходя из текста и шрифта
    private func ​getLabelSize(text: String, font: UIFont, maxWidth: CGFloat) -> CGSize {
        // получаем максимальные размеры
        let textBlockSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        // расчитываем размер рамки вокруг текста
        let rect = text.boundingRect(with: textBlockSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        // округляем высоту и ширину
        let width = ceil(rect.width)
        let height = ceil(rect.height)
        // создаем возвращаемое значение
        let size = CGSize(width: width, height: height)
        // возвращаем высоту ячейки с округлением до большего числа
        return size
    }
    
    func setupCell(newsItem: NewsItem, for indexPath: IndexPath) {
        // 1 - set avatar
        if newsItem.avatarImage == nil { avatarImageView.image = #imageLiteral(resourceName: "avatar-man") }
        let url = URL(string: newsItem.avatarImage!)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: url)
        // 2 - set title
        titleLbl.text = newsItem.author
        // 3 - set text date
        let unixDate = newsItem.date
        getTimeToNow(from: unixDate) { self.timeLbl.text = $0 }
        // 4 - set body and calculate new frame
        bodyLbl.text = newsItem.body
        setupBodyLbl(cellSize)
        // 5 - add attachment and calculate frame
        // with KingFisher pod
        picture: if let photoStringUrl = newsItem.attachmentUrl {
            // KINGFISHER
            guard let pictureUrl = URL(string: photoStringUrl) else { setupPictureImageView(cellSize); break picture }
            containsImage = true
            pictureImageView.kf.indicatorType = .activity
            pictureImageView.kf.setImage(with: pictureUrl)
        } else {
            containsImage = false
        }
        setupPictureImageView(cellSize)
        // 6 - set likes count and calculate frame
        likesLbl.text = "\(newsItem.likesCount)"
        setupLikesLbl(cellSize)
        // 7 - set reposts count and calculate frame
        repostsLbl.text = "\(newsItem.repostsCount)"
        setupRepostsLbl(cellSize)
        // 8 - set comments count and calculate frame
        commentsLbl.text = "\(newsItem.commentsCount)"
        setupCommentLbl(cellSize)
        // 9 - set views count and calculate frame
        viewsLbl.text = "\(newsItem.viewsCount)"
        setupViewLbl(cellSize)
    }
    
}
