//
//  StackController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 5..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class CardStackView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeStackBackView() {
        for column in 0..<7 {
            let stackView = UIView()
            stackView.makeStackView(column: column)
            self.addSubview(stackView)
        }
    }
}

extension CardStackView {
    //    private func makeTableColumnCards() {
    //        let tableStacks = makeColumnView()
    //        var column = 0
    //        for cardView in tableStacks {
    //            for index in 0..<cardView.count {
    //                cardView[index].makeStackView(column: column, cardsRow: index)
    //                let gesture = UITapGestureRecognizer(target: eventController,
    //                                                     action: #selector (eventController.moveFoundation(_:)))
    //                cardView[index].addGestureRecognizer(gesture)
    //                cardView[index].isUserInteractionEnabled = true
    //                self.addSubview(cardView[index])
    //            }
    //            column += 1
    //        }
    //    }
    //
    //    private func makeColumnView() -> [[UIImageView]] {
    //        var cardStackView = [[UIImageView]]()
    //        for cards in gameTable.cardStacksOfTable {
    //            cardStackView.append(makeCardStacks(cards: cards))
    //        }
    //        return cardStackView
    //    }
    //
    //    private func makeCardStacks(cards: [Card]) -> [UIImageView] {
    //        var stacks = [UIImageView]()
    //        for card in cards {
    //            stacks.append(choiceCardFace(with: card))
    //        }
    //        return stacks
    //    }
    //
    //    private func choiceCardFace(with card: Card) -> UIImageView {
    //        var cardView = UIImageView()
    //        if card.isUpside() {
    //            cardView = UIImageView(image: UIImage(named: card.getCardName()))
    //        } else {
    //            cardView = UIImageView(image: UIImage(named: "card_back"))
    //        }
    //        return cardView
    //    }
}
