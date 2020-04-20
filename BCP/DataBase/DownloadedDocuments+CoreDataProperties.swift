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
