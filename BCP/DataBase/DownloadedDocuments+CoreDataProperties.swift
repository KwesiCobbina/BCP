//
//  DownloadedDocuments+CoreDataProperties.swift
//  BCP
//
//  Created by Engineer 144 on 09/06/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//
//

import Foundation
import CoreData


extension DownloadedDocuments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DownloadedDocuments> {
        return NSFetchRequest<DownloadedDocuments>(entityName: "DownloadedDocuments")
    }

    @NSManaged public var fileName: String?
    @NSManaged public var fileURL: String?
	@NSManaged public var onlineURL: String?

}

extension FavoritedClause {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedClause> {
        return NSFetchRequest<FavoritedClause>(entityName: "FavoritedClause")
    }

    @NSManaged public var clause_id: String?
    @NSManaged public var clause_title: String?
    @NSManaged public var clause_section: String?
    @NSManaged public var clause_details: String?
    @NSManaged public var clause_summary: String?
    @NSManaged public var clause_procedure: String?
    @NSManaged public var clause_form: String?
    @NSManaged public var clause_fee: String?
    @NSManaged public var clause_penalty: String?
    @NSManaged public var sector_id: String?
    @NSManaged public var sector_name: String?
    @NSManaged public var subject_name: String?
    @NSManaged public var date_added: Date?
}

