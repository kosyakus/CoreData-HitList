//
//  CallDirectoryHandler.swift
//  HitListCallExtension
//
//  Created by Natalia Sinitsyna on 12.05.2021.
//

import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {

    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self
        
        if context.isIncremental {
            addOrRemoveIncrementalBlockingPhoneNumbers(to: context)

            addOrRemoveIncrementalIdentificationPhoneNumbers(to: context)
        } else {
            addAllBlockingPhoneNumbers(to: context)

            addAllIdentificationPhoneNumbers(to: context)
        }

        context.completeRequest()
    }

    private func addAllBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        let allPhoneNumbers: [CXCallDirectoryPhoneNumber] = [ 1_408_555_5555, 1_800_555_5555 ]
        for phoneNumber in allPhoneNumbers {
            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
        }
    }

    private func addOrRemoveIncrementalBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        
        let phoneNumbersToAdd: [CXCallDirectoryPhoneNumber] = [ 1_408_555_1234 ]
        for phoneNumber in phoneNumbersToAdd {
            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
        }

        let phoneNumbersToRemove: [CXCallDirectoryPhoneNumber] = [ 1_800_555_5555 ]
        for phoneNumber in phoneNumbersToRemove {
            context.removeBlockingEntry(withPhoneNumber: phoneNumber)
        }
    }

    private func addAllIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
//        let phoneNumbers: [CXCallDirectoryPhoneNumber] = [ 79039783911 ]
//           let labels = [ "Test number" ]
        
        var phoneNumbers = [CXCallDirectoryPhoneNumber]()
        var labels = [String]()
        
        for i in 79039700000...79040000000 {
            phoneNumbers.append(CXCallDirectoryPhoneNumber(i))
            labels.append("Test number")
        }

           for (phoneNumber, label) in zip(phoneNumbers, labels) {
               context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
           }
    }

    private func addOrRemoveIncrementalIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        
        let phoneNumbersToAdd: [CXCallDirectoryPhoneNumber] = [ 1_408_555_5678 ]
        let labelsToAdd = [ "New local business" ]

        for (phoneNumber, label) in zip(phoneNumbersToAdd, labelsToAdd) {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
        }

        let phoneNumbersToRemove: [CXCallDirectoryPhoneNumber] = [ 1_888_555_5555 ]

        for phoneNumber in phoneNumbersToRemove {
            context.removeIdentificationEntry(withPhoneNumber: phoneNumber)
        }
    }

}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {

    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
    }

}
