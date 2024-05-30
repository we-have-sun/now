//
//  CloudKitManager.swift
//  Now
//
//  Created by Natalia Terlecka on 30/05/2024.
//

import CloudKit

class CloudKitManager {
    let container: CKContainer
    let publicDatabase: CKDatabase

    init() {
        self.container = CKContainer.default()
        self.publicDatabase = container.publicCloudDatabase
    }

    func save(strings: [String]) {
        let record = CKRecord(recordType: "UserInputStrings")
        record["strings"] = strings as CKRecordValue

        publicDatabase.save(record) { record, error in
            if let error = error {
                print("Error saving to CloudKit: \(error.localizedDescription)")
            } else {
                print("Successfully saved to CloudKit")
            }
        }
    }

    func fetchStrings(completion: @escaping ([String]?) -> Void) {
        let query = CKQuery(recordType: "UserInputStrings", predicate: NSPredicate(value: true))
        
        publicDatabase.fetch(withQuery: query, inZoneWith: nil, desiredKeys: ["strings"], resultsLimit: CKQueryOperation.maximumResults) { result in
            switch result {
            case .success(let (matchResults, _)):
                let strings = matchResults.compactMap { _, result in
                    switch result {
                    case .success(let record):
                        return record["strings"] as? [String]
                    case .failure:
                        return nil
                    }
                }
                completion(strings.first)
            case .failure(let error):
                print("Error fetching from CloudKit: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
