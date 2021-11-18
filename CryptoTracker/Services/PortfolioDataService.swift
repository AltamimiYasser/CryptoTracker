//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 18/11/2021.
//

import Foundation
import CoreData

class PortfolioDataService {

    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "Portfolio"
    @Published var savedEntities = [Portfolio]()

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            self.getPortfolio()
        }
    }

    // MARK: - Public
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else if amount == 0 {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }


    // MARK: - Private
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: entityName)

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func add(coin: Coin, amount: Double) {
        let entity = Portfolio(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }

    private func update(entity: Portfolio, amount: Double) {
        entity.amount = amount
        applyChanges()
    }

    private func delete(entity: Portfolio) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func applyChanges() {
        save()
        getPortfolio()
    }
}
