// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

/// A LinkedIn feed item that is implemented with Auto Layout.
class FeedItemAutoLayoutView: UIView, DataBinder {

    let topBarView = TopBarView()
    let miniProfileView = MiniProfileView()
    let miniContentView = MiniContentView()
    let socialActionsView = SocialActionsView()
    let commentView = CommentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        let views = [
            "topBarView": topBarView,
            "miniProfileView": miniProfileView,
            "miniContentView": miniContentView,
            "socialActionsView": socialActionsView,
            "commentView": commentView
        ]

        addAutoLayoutSubviews(views)
        addConstraintsWithVisualFormat("V:|-0-[topBarView]-0-[miniProfileView]-0-[miniContentView]-0-[socialActionsView]-0-[commentView]-0-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[topBarView]-0-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[miniProfileView]-0-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[miniContentView]-0-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[socialActionsView]-0-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[commentView]-0-|", views: views)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(data: FeedItemData) {
        topBarView.actionLabel.text = data.actionText
        miniProfileView.posterNameLabel.text = data.posterName
        miniProfileView.posterHeadlineLabel.text = data.posterHeadline
        miniProfileView.posterTimeLabel.text = data.posterTimestamp
        miniProfileView.posterCommentLabel.text = data.posterComment
        miniContentView.contentTitleLabel.text = data.contentTitle
        miniContentView.contentDomainLabel.text = data.contentDomain
        commentView.actorCommentLabel.text = data.actorComment
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        return systemLayoutSizeFittingSize(CGSize(width: size.width, height: 0))
    }
}

class CommentView: UIView {
    let actorImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        i.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        i.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        return i
    }()

    let actorCommentLabel: UILabel = UILabel()

    init() {
        super.init(frame: CGRectZero)

        let views: [String: UIView] = [
            "actorImageView": actorImageView,
            "actorCommentLabel": actorCommentLabel
        ]
        addAutoLayoutSubviews(views)

        addConstraintsWithVisualFormat("H:|-0-[actorImageView]-0-[actorCommentLabel]-0-|", views: views)
        addConstraintsWithVisualFormat("V:|-0-[actorImageView]-(>=0)-|", views: views)
        addConstraintsWithVisualFormat("V:|-0-[actorCommentLabel]-(>=0)-|", views: views)
        addConstraintsWithVisualFormat("V:[actorImageView]-(0@749)-|", views: views)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MiniContentView: UIView {
    let contentImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "350x200.png")
        i.contentMode = .ScaleAspectFit
        i.backgroundColor = UIColor.orangeColor()
        return i
    }()

    let contentTitleLabel: UILabel = UILabel()
    let contentDomainLabel: UILabel = UILabel()

    init() {
        super.init(frame: CGRectZero)

        let views = [
            "contentImageView": contentImageView,
            "contentTitleLabel": contentTitleLabel,
            "contentDomainLabel": contentDomainLabel
        ]

        addAutoLayoutSubviews(views)

        addConstraintsWithVisualFormat("V:|-0-[contentImageView]-0-[contentTitleLabel]-0-[contentDomainLabel]-0-|", views: views)

        addConstraintsWithVisualFormat("H:|-0-[contentImageView]-0-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[contentTitleLabel]-0-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[contentDomainLabel]-0-|", views: views)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MiniProfileView: UIView {

    let posterImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "50x50.png")
        i.backgroundColor = UIColor.orangeColor()
        i.contentMode = .Center
        i.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        i.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        return i
    }()

    let posterNameLabel: UILabel = UILabel()

    let posterHeadlineLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 3
        return l
    }()

    let posterTimeLabel: UILabel = UILabel()
    let posterCommentLabel: UILabel = UILabel()

    init() {
        super.init(frame: CGRectZero)

        let views = [
            "posterImageView": posterImageView,
            "posterNameLabel": posterNameLabel,
            "posterHeadlineLabel": posterHeadlineLabel,
            "posterTimeLabel": posterTimeLabel,
            "posterCommentLabel": posterCommentLabel
        ]
        addAutoLayoutSubviews(views)
        addConstraintsWithVisualFormat("V:|-0-[posterImageView]-(>=0)-[posterCommentLabel]-0-|", views: views)
        addConstraintsWithVisualFormat("V:|-1-[posterNameLabel]-1-[posterHeadlineLabel]-1-[posterTimeLabel]-(>=3)-[posterCommentLabel]", views: views)
        addConstraintsWithVisualFormat("V:[posterImageView]-(0@749)-[posterCommentLabel]", views: views)

        addConstraintsWithVisualFormat("H:|-0-[posterImageView]-2-[posterNameLabel]-4-|", views: views)
        addConstraintsWithVisualFormat("H:[posterImageView]-2-[posterHeadlineLabel]-4-|", views: views)
        addConstraintsWithVisualFormat("H:[posterImageView]-2-[posterTimeLabel]-4-|", views: views)
        addConstraintsWithVisualFormat("H:|-0-[posterCommentLabel]-0-|", views: views)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SocialActionsView: UIView {
    let likeLabel: UILabel = {
        let l = UILabel()
        l.text = "Like"
        l.backgroundColor = UIColor(red: 0, green: 0.9, blue: 0, alpha: 1)
        return l
    }()

    let commentLabel: UILabel = {
        let l = UILabel()
        l.text = "Comment"
        l.backgroundColor = UIColor(red: 0, green: 1.0, blue: 0, alpha: 1)
        l.textAlignment = .Center
        return l
    }()

    let shareLabel: UILabel = {
        let l = UILabel()
        l.text = "Share"
        l.textAlignment = .Right
        l.backgroundColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1)
        return l
    }()

    init() {
        super.init(frame: CGRectZero)

        let views: [String: UIView] = [
            "likeLabel": likeLabel,
            "commentLabel": commentLabel,
            "shareLabel": shareLabel
        ]
        addAutoLayoutSubviews(views)

        addConstraintsWithVisualFormat("V:|-0-[likeLabel]-0-|", views: views)
        addConstraintsWithVisualFormat("V:|-0-[commentLabel]-0-|", views: views)
        addConstraintsWithVisualFormat("V:|-0-[shareLabel]-0-|", views: views)

        addConstraints([
            NSLayoutConstraint(item: likeLabel, attribute: .LeadingMargin, relatedBy: .Equal, toItem: self, attribute: .LeadingMargin, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: commentLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: shareLabel, attribute: .TrailingMargin, relatedBy: .Equal, toItem: self, attribute: .TrailingMargin, multiplier: 1, constant: 0)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopBarView: UIView {
    let actionLabel: UILabel = UILabel()

    let optionsLabel: UILabel = {
        let l = UILabel()
        l.text = "..."
        l.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        l.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        return l
    }()

    init() {
        super.init(frame: CGRectZero)
        backgroundColor = UIColor.blueColor()
        let views: [String: UIView] = ["actionLabel": actionLabel, "optionsLabel": optionsLabel]
        addAutoLayoutSubviews(views)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[actionLabel]-0-[optionsLabel]-0-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[actionLabel]-(>=0)-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[optionsLabel]-(>=0)-|", options: [], metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UIView {

    func addAutoLayoutSubviews(subviews: [String: UIView]) {
        for (_, view) in subviews {
            addAutoLayoutSubview(view)
        }
    }

    func addAutoLayoutSubview(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }

    func addConstraintsWithVisualFormat(visualFormat: String, views: [String: UIView]) {
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: [], metrics: nil, views: views))
    }
}