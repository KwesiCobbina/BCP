//
//  MoreOnPolicyViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 20/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import CoreData
import QuickLook
import Alamofire

class MoreOnPolicyViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var postedByLabel: UILabel!
	@IBOutlet weak var postedYearLabel: UILabel!
	@IBOutlet weak var aboutLabel: UILabel!
	@IBOutlet weak var docsTableView: UITableView!
	
	let quickLookController = QLPreviewController()
	let fileManager = FileManager.default
	var policy_id = ""
	var attachments:[String] = []
    var allDocs : [DownloadedDocuments] = []
	var tempDocs : [DownloadedDocuments] = []
	var downloadedAttachments: [NSURL] = []
	var appDelegate = UIApplication.shared.delegate as! AppDelegate
	
	var docURL: String?
	var activityIndicator = UIActivityIndicatorView(style: .gray)
	
	private let persistentContainer = NSPersistentContainer(name: "Ghana_Business_Consultation")
	
    func checkifItsDownloaded(value: String) -> Bool {
        
        let result =  allDocs.filter{$0.fileName ==  value}
       return result.isEmpty ?  false :  true
    }
	
	func checkIfItsThere(val: String) -> Bool{

		let result =  allDocs.filter{$0.onlineURL ==  val}
		return result.isEmpty ?  false :  true
	}

	
    override func viewDidLoad() {
        super.viewDidLoad()
		docsTableView.delegate = self
		docsTableView.dataSource = self
		quickLookController.dataSource = self
		fetchMore()
		setupSpinner()
		
        allDocs = CoreDataManager.sharedManager.getAllDocuments() ?? []

    }
	
	func setupSpinner(){
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(activityIndicator)
		activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
    

	func fetchMore() {
        
        
        
		activityIndicator.startAnimating()
		let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_read_policy_details.php")
//		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_read_policy_details.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		
		
		let params = "policy_id=\(policy_id)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					self.activityIndicator.stopAnimating()
					return }
			do{
				let info = try JSONDecoder().decode([PolicyInfo].self, from: dataResponse)
				for data in info {
					DispatchQueue.main.async {
						guard let title = data.policy_title else {return}
						
						guard let postedBy = data.posted_by else {return}
						guard let postedYear = data.policy_year else {return}
						guard let summary = data.summary else {return}
						self.titleLabel.text = title.firstCapitalized
						let formattedString = NSMutableAttributedString()
						formattedString
						.normal("Posted Year: ")
						.bold(postedYear)
						self.postedByLabel.text = "Posted By: \(postedBy)"
						self.aboutLabel.text = summary
						self.postedYearLabel.attributedText = formattedString
					}
					if data.attachment != [] {
						self.attachments = []
						for data2 in data.attachment! {
//							print(data2)
							self.attachments.append(data2)
							if self.checkIfItsThere(val: data2) == false {
								CoreDataManager.sharedManager.saveFileName(name: "" , url: "", attach: data2)
							}
						}
					}
				}
	
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.allDocs = CoreDataManager.sharedManager.getAllDocuments() ?? []
				self.docsTableView.reloadData()
				self.activityIndicator.stopAnimating()
			}
		}
		task.resume()
	}
	
	@IBAction func dismissClicked(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
}


extension MoreOnPolicyViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allDocs.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = allDocs[indexPath.item].onlineURL
		let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableViewCell") as! DocumentTableViewCell
		cell.delegate = self
        
        let title = URL(fileURLWithPath: post!).lastPathComponent
        
		if checkifItsDownloaded(value: post ?? "") == true {
			
            cell.downloadDocs.setTitle("Delete Document", for: .normal)
			cell.docTitleLabel.text = title
			cell.docTitleLabel.isHidden = false
			cell.viewBtn.isHidden = false
        }else{
            
             cell.downloadDocs.setTitle("Download Document", for: .normal)
             cell.docTitleLabel.text = "Loading..."
			cell.docTitleLabel.isHidden = true
			cell.viewBtn.isHidden = true
        }
		
		if post!.contains(".pdf") {
			cell.docIcon?.image = UIImage(named: "pdf-80")
			return cell
		}
		else if post!.contains(".docx") {
			cell.docIcon?.image = UIImage(named: "word_doc-80")
			return cell
		}
		else {
			cell.docIcon?.image = UIImage(named: "generic_doc-80")
			return cell
		}
	}
	
	
	func removeFile(itemName:String, name: String, url: String) {
		let fileManager = FileManager.default
		let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
		let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
		let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
		guard let dirPath = paths.first else {return}
		let filePath = "\(dirPath)/\(itemName)"
		
		do {
			try fileManager.removeItem(atPath: filePath)
			let aa = CoreDataManager.sharedManager.delete(file: name, web: filePath, url: url)
			self.docsTableView.reloadData()
			print("delete was successful")
		} catch let error as NSError {
			
			self.showAlert(title: "Delete Failed", message: "Failed to delete \(String(describing: error)) file")
			print(error.debugDescription)
		}}
	
	
	
	private func downloadNewDoc(fin: String, cell: DocumentTableViewCell){
		self.activityIndicator.startAnimating()

		let docUrl = fin
		let finalURL = "http://www.index-holdings.com/bcp/\(docUrl)"
		let urlNew:String = finalURL.replacingOccurrences(of: " ", with: "%20")
		let pp = URL(string: urlNew)
		let title = pp!.lastPathComponent
		let finalTitle = title.replacingOccurrences(of: "%20", with: " ")
		AppConstants.sharedInstance.title = finalTitle
		let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let fileURL = documentsURL.appendingPathComponent(finalTitle)
		AppConstants.sharedInstance.url = fileURL as NSURL
		let destination: DownloadRequest.Destination = { _, _ in
			return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
		}
		
		if fileManager.fileExists(atPath: fileURL.path) {
			print("The file already exists at path")
			
			removeFile(itemName: title, name: fin, url: fileURL.absoluteString)
			activityIndicator.stopAnimating()
			showAlert(title: "Deleted", message: "The file \(title) was successfully deleted.")

		} else {

            
            //cell.downloadProgressBar.isHidden = false
			AF.download(urlNew, to: destination).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
				if (progress.fractionCompleted < 1) {
					DispatchQueue.main.async {
						//cell.downloadProgressBar.isHidden = false
						cell.docTitleLabel.isHidden = false
						//let progressval = progress.fractionCompleted
						//cell.downloadProgressBar.progress = Float(progressval)
					}
				}
				if (progress.fractionCompleted == 1) {
					DispatchQueue.main.async {

					}
				}
				}.response { response in

					if response.error == nil, let _ = response.fileURL?.path {
					
						self.activityIndicator.stopAnimating()
						do {
							
							CoreDataManager.sharedManager.update(file: fin, url: response.fileURL?.absoluteString ?? "", name: fin)
							self.activityIndicator.stopAnimating()
							self.showAlert(title: "Downlad Successful", message: "The file \(title) has been successfully downloaded.")

							
							main {
								self.allDocs = CoreDataManager.sharedManager.getAllDocuments() ?? []
								self.docsTableView.reloadData()
                                }

						} catch {
							print("Failed saving")
						}

					}
			}
		}
	}
}



extension MoreOnPolicyViewController: QLPreviewControllerDataSource {
	func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
		return allDocs.count
	}
	
	func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
		let b = allDocs[index].fileURL!
		var title = ""
		if b != "" {
			let urlNew:String = b.replacingOccurrences(of: "%20", with: " ")
			let ff = URL(fileURLWithPath: urlNew)
			title = ff.lastPathComponent
			print(title)
		}
			let fileManager = FileManager.default
			let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
			let documentDirectoryURL: URL = (urls.first!)
			let playFile = documentDirectoryURL.appendingPathComponent(title)
			return  playFile as QLPreviewItem
			
//		}
//		return nil
	}
	
	
}




extension MoreOnPolicyViewController: DocumentTableViewCellDelegate {
	
	func didHitDownload(for Doc: DocumentTableViewCell) {
		guard let indexPath = docsTableView?.indexPath(for: Doc) else {return}
		let post = allDocs[indexPath.item].onlineURL
		self.downloadNewDoc(fin: post!, cell: Doc)
		
	}
	
	func didHitOpen(for Doc: DocumentTableViewCell) {
		guard let indexPath = docsTableView?.indexPath(for: Doc) else {return}
		let origin = allDocs[indexPath.row].fileName
		
		if checkifItsDownloaded(value: origin!) == true {
			let b = allDocs[indexPath.item].fileURL!
			let urlNew:String = b.replacingOccurrences(of: "%20", with: " ")
			let ff = URL(fileURLWithPath: urlNew)
			let title = ff.lastPathComponent
			print(title)
			let fileManager = FileManager.default
			let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
			if let documentDirectoryURL: URL = (urls.first) {
				let playFile = documentDirectoryURL.appendingPathComponent(title)
				if fileManager.fileExists(atPath: playFile.path) {
					print("true")
					print(playFile.path)
					let quickLookController = QLPreviewController()
					quickLookController.dataSource = self
					quickLookController.navigationController?.navigationBar.barTintColor = UIColor.red
					if QLPreviewController.canPreview(playFile as NSURL) {
						quickLookController.currentPreviewItemIndex = indexPath.row
						present(quickLookController, animated: true, completion: nil)
					}
				}
				else {
					print("I can't find it ooo ")
				}
			}
		}
		else {
			print("not yet")
		}
	}
	
	
}



extension MoreOnPolicyViewController: NSFetchedResultsControllerDelegate {
	
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		self.docsTableView.beginUpdates()
	}
	
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		self.docsTableView.endUpdates()
	}
}

