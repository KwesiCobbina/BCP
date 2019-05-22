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
	
	var policy_id = ""
	var attachments:[String] = []
	var downloadedAttachments: [NSURL] = []
	var appDelegate = UIApplication.shared.delegate as! AppDelegate
	
	lazy var context = appDelegate.persistentContainer.viewContext
	var docURL: String?
	var activityIndicator = UIActivityIndicatorView(style: .gray)
	
//	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	// MARK: -
	
	private let persistentContainer = NSPersistentContainer(name: "Ghana_Business_Consultation")
	
	fileprivate lazy var fetchedResultsController: NSFetchedResultsController<DownloadedDocuments> = {
		// Create Fetch Request
		let fetchRequest: NSFetchRequest<DownloadedDocuments> = DownloadedDocuments.fetchRequest()
		
		// Configure Fetch Request
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
		
		// Create Fetched Results Controller
		let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
		
		// Configure Fetched Results Controller
		fetchedResultsController.delegate = self
		
		return fetchedResultsController
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		docsTableView.delegate = self
		docsTableView.dataSource = self
		quickLookController.dataSource = self
		fetchMore()
		setupSpinner()
		
		persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
			if let error = error {
				print("Unable to Load Persistent Store")
				print("\(error), \(error.localizedDescription)")
				
			} else {
//				self.setupView()
				
				do {
					try self.fetchedResultsController.performFetch()
				} catch {
					let fetchError = error as NSError
					print("Unable to Perform Fetch Request")
					print("\(fetchError), \(fetchError.localizedDescription)")
				}
//				self.updateView()
			}
		}
		
    }
	
	func setupSpinner(){
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//		spinner.startAnimating()
		view.addSubview(activityIndicator)
//		activityIndicator.isHidden = true
		activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
    

	func fetchMore() {
//		var tempInterests: [Read] = []
//		let menu_id = "5"
		activityIndicator.startAnimating()
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_read_policy_details.php")
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
				print(dataResponse)
				let info = try JSONDecoder().decode([PolicyInfo].self, from: dataResponse)
//				print(info.policy_title)
				for data in info {
//					tempInterests.append(data)
					print(data)
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
//						self.postedYearLabel.text = "Posted Year: \(postedYear)"
						self.postedYearLabel.attributedText = formattedString
					}
					if data.attachment != [] {
						self.attachments = []
						for data2 in data.attachment! {
							print(data2)
							self.attachments.append(data2)
						}
					}
				}
	
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
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
		print(attachments.count)
		return attachments.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = attachments[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableViewCell") as! DocumentTableViewCell
		if post.contains(".pdf") {
			cell.docIcon?.image = UIImage(named: "pdf-80")
			return cell
		}
		else if post.contains(".docx") {
			cell.docIcon?.image = UIImage(named: "word_doc-80")
			return cell
		}
		else {
			cell.docIcon?.image = UIImage(named: "generic_doc-80")
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let post = attachments[indexPath.row]
		let downloadedPost = fetchedResultsController.object(at: indexPath)
		let fin = NSURL(fileURLWithPath: post)
		self.docURL = post
		if post.contains(downloadedPost.fileName!) {
			let fileu = NSURL(fileURLWithPath: downloadedPost.fileURL!)
			if QLPreviewController.canPreview(fileu) {
				quickLookController.currentPreviewItemIndex = indexPath.row
//				quickLookController.currentPreviewItemIndex = fileu
				navigationController?.pushViewController(quickLookController, animated: true)
			}
		}
		else {
			self.downloadNewDoc(fin: fin)
		}
//		let downladed = downloadedAttachments
//		if downladed.contains(fin) {
//			if QLPreviewController.canPreview(downladed[indexPath.row]) {
//				quickLookController.currentPreviewItemIndex = indexPath.row
//				navigationController?.pushViewController(quickLookController, animated: true)
//			}
//		} else {
////			download file here
//
//		}
		
	}
	
	func removeFile(itemName:String) {
		let fileManager = FileManager.default
		let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
		let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
		let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
		guard let dirPath = paths.first else {
			return
		}
		let filePath = "\(dirPath)/\(itemName)"
		do {
			try fileManager.removeItem(atPath: filePath)
			print("delete was successful")
		} catch let error as NSError {
			let a = "aa"
			let alert = UIAlertController(title: "Delete Failed", message: "Failed to delete \(String(describing: a)) file", preferredStyle: UIAlertController.Style.alert)
			
			// add an action (button)
			alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
			
			// show the alert
			self.present(alert, animated: true, completion: nil)
			print(error.debugDescription)
		}}
	
	private func downloadNewDoc(fin: NSURL){
		self.activityIndicator.startAnimating()
		let ent = NSEntityDescription.entity(forEntityName: "DownloadedDocuments", in: context)
		let newDoc = NSManagedObject(entity: ent!, insertInto: context)
		guard let docUrl = self.docURL else { return }
		
		let finalURL = "http://www.index-holdings.com/bcp/\(docUrl)"
		let urlNew:String = finalURL.replacingOccurrences(of: " ", with: "%20")
//		let pp = URL(string: finalURL)
		let title = fin.lastPathComponent
		AppConstants.sharedInstance.title = title!
		
//		print(title)
		let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let fileURL = documentsURL.appendingPathComponent(title!)
		AppConstants.sharedInstance.url = fileURL as NSURL
		let destination: DownloadRequest.Destination = { _, _ in
//			print(fileURL.lastPathComponent)
			return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
		}
		
		if FileManager.default.fileExists(atPath: fileURL.path) {
			print("The file already exists at path")
			let alert = UIAlertController(title: "Download Issue", message: "The file you're trying to download already exists.", preferredStyle: UIAlertController.Style.alert)
			removeFile(itemName: title!)
			// add an action (button)
			activityIndicator.stopAnimating()
			alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
			
			// show the alert
			self.present(alert, animated: true, completion: nil)
			// if the file doesn't exist
		} else {
			
			AF.download(urlNew, to: destination).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
				if (progress.fractionCompleted < 1) {
					DispatchQueue.main.async {
//						self.progressBar.isHidden = false
//						self.titleLabel.isHidden = false
//						self.holdLbl.isHidden = false
//						self.hideViews()
//						let progressval = progress.fractionCompleted
//						self.progressBar.progress = Float(progressval)
//						self.titleLabel.text = Double(round(1000 * progressval) / 10).description + "%"
					}
				}
				if (progress.fractionCompleted == 1) {
					DispatchQueue.main.async {
//						self.progressBar.isHidden = true
//						self.titleLabel.isHidden = true
//						self.holdLbl.isHidden = true
//						self.showViews()
					}
				}
				}.response { response in
					print(response)
//					self.progressBar.isHidden = true
//					self.titleLabel.isHidden = true
//					self.holdLbl.isHidden = true
//					self.showViews()
					
					
					if response.error == nil, let _ = response.fileURL?.path {
//						self.progressBar.isHidden = true
//						self.titleLabel.isHidden = true
//						self.holdLbl.isHidden = true
//						self.showViews()
//						newSermon.setValue((titlex! + ".mp3"), forKey: "sermonURL")
//						newSermon.setValue(self.sstitle!, forKey: "title")
						newDoc.setValue(self.title, forKey: "fileName")
						newDoc.setValue(AppConstants.sharedInstance.url!, forKey: "fileURL")
						self.activityIndicator.stopAnimating()
						do {
							
							try self.context.save()
							
							print("Saved in coredata")
							let alert = UIAlertController(title: "Downlad Successful", message: "Your file \(title!) has been successfully downloaded.", preferredStyle: UIAlertController.Style.alert)
							
							// add an action (button)
							alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
							self.activityIndicator.stopAnimating()
							// show the alert
							self.present(alert, animated: true, completion: nil)
							
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
		return downloadedAttachments.count
	}
	
	func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
		return downloadedAttachments[index]
	}
	
	
}


extension MoreOnPolicyViewController: NSFetchedResultsControllerDelegate {
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		
		switch type {
		case .insert:
			if let insertIndexPath = newIndexPath {
//				self.downloadedSermonsTableView.insertRows(at: [insertIndexPath], with: .fade)
			}
		case .delete:
			if let deleteIndexPath = indexPath {
//				self.downloadedSermonsTableView.deleteRows(at: [deleteIndexPath], with: .fade)
			}
		case .move:
			if let deleteIndexPath = indexPath {
//				self.downloadedSermonsTableView.deleteRows(at: [deleteIndexPath], with: .fade)
			}
		case .update:
			if let updateIndexPath = indexPath {
//				let cell = self.downloadedSermonsTableView.cellForRow(at: updateIndexPath) as! DownloadedSermonsTableViewCell
				let serm = self.fetchedResultsController.object(at: updateIndexPath)
				//					as! DownloadedSermons
				
//				cell.semonTitleLabel.text = serm.title
			}
			// Note that for Move, we insert a row at the __newIndexPath__
			if let insertIndexPath = newIndexPath {
//				self.downloadedSermonsTableView.insertRows(at: [insertIndexPath], with: .fade)
			}
		}
	}
}
