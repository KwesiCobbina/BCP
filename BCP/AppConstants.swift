//
//  AppConstants.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 22/05/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation

func background(work: @escaping () -> ()) {
    DispatchQueue.global(qos: .userInitiated).async {
        work()
    }
}

func main(work: @escaping () -> ()) {
    DispatchQueue.main.async {
        work()
    }
}


class AppConstants {
	
	private init () {}
	static let sharedInstance = AppConstants()
	var url: NSURL?
    var clauseStatus: Bool?
    var selectedsearch: SearchResults?
    var regulate: Regulation?
    var policy_id: String?
    var selectedClause: Clause?
	var title: String = ""
	var devURL = "http://www.Index-holdings.com/bcp/bcp_api/"
	var prodURL = "https://bcp.gov.gh/bcp_api/"
	var licencesURL = "https://bcp.gov.gh/"
//	http://bcp.gov.gh/bcp_api/
    var about_bcp = "The BRR App is the official Mobile Application for the Ghana Business Regulatory Reforms Portal. The Portal is developed to enable policy makers easily consult affected businesses and individuals in a transparent and timely way, and at a considerable cost savings. It also provides free and transparent access to business regulations, through its Electronic Registry of Acts, Legislative Instruments, Regulatory Notices, Administrative Directives, Procedures, Forms and Fees. This will enable businesses anywhere in the world to easily view and obtain every business law and regulation (business-related Acts, Legislative Instruments, Regulatory Notices and Administrative Directives) in force in Ghana, on this single electronic register (e-Register).<br>The App has features and functionalities similar to the web portal for interactive public consultations as well as accessing business regulations in force in Ghana. Users can use the App to take part in ongoing Business Consultations which will feed into Regulatory Impact Analysis and significantly improve the evidence basis for Inter-Ministerial decision-making.<br>Similarly, the App has simple search and query functionality which gives easy and timely access to specific provisions and sections of the various Business Regulations in force in Ghana. These business regulations are indexed and classified into various subjects with appropriate cross referencing as well as related services such as Procedures, Fees and Charges. These Business Regulations and Forms can be viewed online, shared via social media or downloaded."
    
    var about_bcps = "<b>The Ghana Business Consultations Portal</b><br>The Ghana Business Consultations Portal (BCP) is an interactive portal to enable policy makers easily consult affected businesses and individuals in a transparent and timely way, and at a considerable cost savings. E-consultations is one of the important steps envisaged in the simplified process for Ministries preparing draft memorandum for submission to Cabinet, according to the 2017 revised guidelines. It is expected in advance to ensure that the real-world impacts of proposed policies and regulations are anticipated and considered by Government, and cumulative or overlapping regulations are avoided. Inputs from the Business Consultation portal will feed into Regulatory Impact Analysis and significantly improve the evidence basis for Inter-Ministerial decision-making.<br><br>The functions and indicative features of the <b>Ghana Business Consultation Portal</b> are:<br><br><b>1.</b> BCP primarily focus on building an online community of users to participate in consultations on business policies and regulatory reforms on a regular basis. It allows Government to interact directly with people who offer/register to be consulted when business policies and regulations are being developed or improved.<br><br> <b>2.</b> It connects businesses, individuals, industry associations and not-for-profit organizations with Government Ministries, Departments and Agencies (MDAs), with a schedule of upcoming consultations on draft policies and regulations announced and published on the Portal in advance by MDAs.<br><br><b>3.</b>Businesses, individuals, industry associations, policy think-tanks, civil society and not-for-profit organizations can register to have their details supplied to the relevant MDAs. These details will be used when a consultation request is being made. They could be notified by email when public consultations relevant to their selected interests are posted on the Portal.<br><br>The portal will provide the private sector and other economic operators with virtual opportunities to contribute publicly or directly to discussions with Government on improving specific business policies and regulations."
                
    
        var terms_of_use  = "<b>ACCEPTANCE OF TERMS OF USE</b><br><br>Welcome to the <b>Ghana Business Regulatory Reforms Portal</b> (‘BRR App’ or 'the Portal’)!In exchange for your use of the Portal, you agree to be bound and abide by the following Terms of Use (TOU). Your use of the Portal constitutes your acceptance of the TOU and any posted guidelines or rules applicable to particular features (feature guidelines) which may be posted on the Portal from time to time. All such feature guidelines shall be considered part of the TOU.BCP (representing the Government of the Republic of Ghana) may add to, delete or modify any or all of the terms and conditions in the TOU (including the feature guidelines) at any time without notice to you. <br></b><br></b><b>DESCRIPTION OF BCP'S SERVICES</b><br>We aim to gather and gauge ground sentiments, engage citizens and promote active citizenry. Our feedback platforms, including the BCP Portal and the BCP social media pages, provide channels for you to share your feedback with the Government. Feedback received is read by BCP staff, and forwarded to relevant agencies. We also facilitate communication between citizens and agencies by proactively initiating discussion on various policies and regulations.<br></br><br></br> <b><u>DISCLAIMER OF WARRANTIES</u></b> <br></br><br></br>The Portal is provided as is, with no warranties whatsoever. All express, implied, and statutory warranties, including, without limitation, the warranties of merchantability, fitness for a particular purpose, and non-infringement of proprietary rights, are expressly disclaimed to the fullest extent permitted by law. BCP disclaims any and all responsibility or liability for the accuracy, content, completeness, legality, reliability, or operability or availability of information or material in the Portal.<br></br><br></br> <b><u>EXCLUSION OF LIABILITY</u></b> <br></br><br></br>Under no circumstances shall BCP be liable to you on account of your use or misuse of and reliance on the Portal. Such exclusion of liability shall apply whether the damages arise from use or misuse of and reliance on the Portal, from inability to use the Portal, or from the interruption, suspension, or termination of the Portal (including such damages incurred by third parties). BCP shall also not be liable to you if any information or material submitted, posted or otherwise contributed by you, fails or ceases to appear on the Portal.<br></br><br></br> <b><u>GOVERNING LAW </u></b> <br></br><br></br>The use of the Portal and any questions or dispute arising from the use of the Portal shall be construed in accordance with the laws of the Republic of Ghana and you agree to submit to the exclusive jurisdiction of the Ghana courts."
    
    var privacy = "This is a <b>Government of Ghana Portal</b>. If you are only browsing this Portal, we do not capture data that allows us to identify you individually. If you choose to make an application or send us an email for which you provide us with personally identifiable data, we may share necessary data with other Government agencies, so as to serve you in the most efficient and effective way, unless such sharing is prohibited by law. We will NOT share your personal data with non-Government entities, except where such entities have been authorised to carry out specific Government services. We may use cookies, where a small data file is sent to your browser to store and track information about you when you enter our Portals. The cookie is used to track information such as the number of users and their frequency of use, profiles of users and their preferred sites. While this cookie can tell us when you enter our sites and which pages you visit, it cannot read data off your hard disk.<br></br><br></br> You can choose to accept or decline cookies. Most web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies if you prefer. This may prevent you from taking full advantage of the Portal. For your convenience, we may also display to you data you had previously supplied us or to other Government agencies. This is done with the intent to save you the trouble of repeating previous submissions. Should the data be out-of-date, please supply us the latest data. We will retain your personal data only as necessary for the effective delivery of public services to you.<br></br><br></br> To safeguard your personal data, all electronic storage and transmission of personal data is secured with appropriate security technologies. This site may contain links to other Government agencies and non-Government sites whose data protection and privacy practices may differ from ours. We are not responsible for the content and privacy practices of these other Portals and encourage you to consult the privacy notices of those sites. If you have any enquires or feedback on our data protection policies and procedures or if you require more information on or access to the data which you have sent to us, please contact us."
    
    var governmentAgencyRegistrations = "<b>By registering your details on the Business Consultations Portal, you agree to the following conditions:</b><br></br><br></br><b>&#8226;</b>  The Ghana Business Consultations Portal (BCP) will provide relevant information of the interested business registrants (the Registrants) to the Agency only for the purpose of facilitating Business Consultation between the Agency and the Registrants in relation to the business-related policy development in the area which the Agency has specified.<br></b><br></b><b>&#8226;</b>  The Portal will have complete discretion in matching the Registrants with the Agency for the purposes of this Portal.<br></b><br></b><b>&#8226;</b>  The Portal accepts no responsibility for checking the accuracy of data and information provided by the Registrants.<br></b><br></b><b>&#8226;</b>  The Portal will not be liable to any person (including but not limited to any Registrant, Agencies or any third party) for any acts or omissions by the Agency for which any claim, compensation, remuneration or other amount payable to that person might arise from the consultation process and the storage of its information.<br></b><br></b><b>&#8226;</b>  The Agency will be assuming all risks associated with the use of this Portal and/or the relevant database including risk of the Agency's computer, software or data damaged by any virus which might be transmitted, downloaded or activated via this Portal and/or the relevant database, its contents and the Agency's access to it.<br></b><br></b><b>&#8226;</b>  The Agency will be deemed to have been registered for the purposes of this Portal, only upon being verified by the Business Consultation Team and by adhering to this disclaimer.<br></b><br></b><b>&#8226;</b>  The Agency may modify or remove its details from this database.<br></b><br></b>"
    
    var businessIndividualsRegistrations = "<b>By registering your details on the Business Consultations Portal, you agree to the following conditions:</b><br></br><br></br><b>&#8226;</b>  The Ghana Business Consultations Portal endeavors to keep information received from you via the Portal in a secure environment. Your personal or business information will only be released to other relevant government departments and agencies for the purpose of facilitating Business Consultation between you and interested government agencies in the policy areas you have expressed an interest in, unless the law permits it or your permission is granted. However, you need to be aware of inherent risks associated with the transmission of information via the internet. If you have any concerns regarding the transmission of information via the internet, the Department can receive information via mail, telephone and fax facilities.<br></b><br></b><b>&#8226;</b>  The Portal has complete discretion in matching private organisations with relevant government agencies for the purposes of this portal. Registering your details on this portal will not guarantee that any form of Business Consultation will be sought from you by the Department or other relevant government agencies.<br></b><br></b><b>&#8226;</b>  Whilst relevant government agencies will review the concerns you raise and seriously consider your recommendations once they are submitted, there is no guarantee that all or part of your views will be included in any outcome of the government policy for which consultation is being sought.<br></b><br></b><b>&#8226;</b>  By registering your details on this portal, you will be deemed to have released and discharged the Department from all liability which might arise from the consultation process and the storage of your information, including liability in respect of any acts or omission of other agencies involved in this Business Consultation process.<br></b><br></b><b>&#8226;</b>  You may modify or request for the removal of your details from our database.<br></b><br></b>"
    
    var businessIndividualsRegistration = "<b>&#8226;</b>The Ghana Business Regulatory Reforms Portal endeavors to keep information received from you via the Business Regulatory Reforms Portal in a secure environment. Your personal or business information will only be released to other relevant government departments and agencies for the purpose of facilitating consultations between you and interested government agencies in the policy areas you have expressed an interest in, unless the law permits it or your permission is granted. However, you need to be aware of inherent risks associated with the transmission of information via the internet. If you have any concerns regarding the transmission of information via the internet, the BRR team can receive information via mail, telephone and fax facilities.<br><b>&#8226;</b>The Ghana Business Regulatory Reforms Portal has complete discretion in matching private organisations with relevant government agencies for the purposes of this portal. Registering your details on this portal will not guarantee that any form of Business Regulatory Reforms will be sought from you by our unit or other relevant government agencies.<br><b>&#8226;</b>Whilst relevant government agencies will review the concerns you raise and seriously consider your recommendations once they are submitted, there is no guarantee that all or part of your views will be included in any outcome of the government policy for which consultation is being sought.<br><b>&#8226;</b>By registering your details on this portal, you will be deemed to have released and discharged the Unit from all liability which might arise from the Regulatory Reforms and consultation process and the storage of your information, including liability in respect of any acts or omission of other agencies involved in this Business Regulatory Reforms process.<br><b>&#8226;</b>You may request for the modification and/or removal of your details from our database."
    
    var governmentAgencyRegistration = "<b>By registering your details on the Ghana Business Regulatory Reforms Portal, you agree to the following conditions:</b><br><b>&#8226;</b>The Ghana Business Regulatory Reforms Portal will provide relevant information of the interested business registrants (the Registrants) to the Agency only for the purpose of facilitating Business Regulatory Reforms between the Agency and the Registrants in relation to the business-related policy development in the area which the Agency has specified.<br><b>&#8226;</b>The Ghana Business Regulatory Reforms Portal will have complete discretion in matching the Registrants with the Agency for the purposes of this Portal.<br><b>&#8226;</b>The Ghana Business Regulatory Reforms Portal accepts no responsibility for checking the accuracy of data and information provided by the Registrants.<br><b>&#8226;</b>The Ghana Business Regulatory Reforms Portal will not be liable to any person (including but not limited to any Registrant, Agencies or any third party) for any acts or omissions by the Agency for which any claim, compensation, remuneration or other amount payable to that person might arise from the Regulatory Reforms process and the storage of its information.<br><b>&#8226;</b>The Agency will be assuming all risks associated with the use of this Portal and/or the relevant database including risk of the Agency's computer, software or data damaged by any virus which might be transmitted, downloaded or activated via this Portal and/or the relevant database, its contents and the Agency's access to it.<br><b>&#8226;</b>The Agency will be deemed to have been registered for the purposes of this Portal, only upon being verified by the Business Regulatory Reforms (BRR) Team and by adhering to this disclaimer.<br><b>&#8226;</b>The Agency may modify or remove its details from this database."
    
    

    

}


