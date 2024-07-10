//
//  SubscriptionsViewModel.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import Foundation
import Observation
import SwiftUI

protocol SubscriptionsViewModelProtocol {
    var subscriptions: [Subscription] { get set }
    var databaseError: DatabaseError? { get set }
}

@Observable
public class SubscriptionsViewModel: SubscriptionsViewModelProtocol {
    var subscriptions: [Subscription]
    var databaseError: DatabaseError?
    
    private var createSubscriptionUseCase: CreateSubscriptionProtocol
    private var fetchAllSubscriptionsUseCase: FetchAllSubscriptionsProtocol
    private var updateSubscriptionsUseCase: UpdateSubscriptionProtocol
    private var removeSubscriptionUseCase: RemoveSubscriptionProtocol
    
    init(
        subscriptions: [Subscription] = [],
        createSubscriptionUseCase: CreateSubscriptionProtocol = CreateSubscriptionUseCase(),
        fetchAllSubscriptionsUseCase: FetchAllSubscriptionsProtocol = FetchAllSubscriptionsUseCase(),
        updateSubscriptionsUseCase: UpdateSubscriptionProtocol = UpdateSubscriptionUseCase(),
        removeSubscriptionUseCase: RemoveSubscriptionProtocol = RemoveSubscriptionUseCase()
    ) {
        self.subscriptions = subscriptions
        self.createSubscriptionUseCase = createSubscriptionUseCase
        self.fetchAllSubscriptionsUseCase = fetchAllSubscriptionsUseCase
        self.updateSubscriptionsUseCase = updateSubscriptionsUseCase
        self.removeSubscriptionUseCase = removeSubscriptionUseCase
        fetchSubscriptions()
    }
    
    func createSubscription(service: String, amount: Double, billing: Subscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) {
        do {
            /// Need to implemente receipt logo
            try createSubscriptionUseCase.createSubscription(
                service: service,
                amount: amount,
                billing: billing,
                chargeDate: chargeDate,
                active: active,
                notification: notification,
                serviceLogo: serviceLogo
            )
            fetchSubscriptions()
        } catch {
            print("DEBUG - Error: Error updating subscriptions \(error.localizedDescription)")
        }
    }
    func updateSubscription(id: UUID, service: String, amount: Double, billing: Subscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) {
        do {
            try updateSubscriptionsUseCase.updateSubscription(
                id: id,
                service: service,
                amount: amount,
                billing: billing,
                chargeDate: chargeDate,
                active: active,
                notification: notification,
                serviceLogo: serviceLogo
            )
            fetchSubscriptions()
        } catch {
            print("DEBUG - Error: Error updating subscription \(error.localizedDescription)")
        }
    }
    func removeSubscription(id: UUID) {
        do {
            try removeSubscriptionUseCase.removeSubscription(id: id)
            fetchSubscriptions()
        } catch let error as DatabaseError {
            print("DEBUG - Error: Database error \(error.localizedDescription)")
            databaseError = error
        } catch {
            print("DEBUG - Error: Use case error \(error.localizedDescription)")
        }
    }
    
    private func fetchSubscriptions() {
        do {
            self.subscriptions = try fetchAllSubscriptionsUseCase.fetchAll()
        } catch {
            print("DEBUG - Error: Can't fetch subscriptions \(error.localizedDescription)")
        }
    }
    
    
}
