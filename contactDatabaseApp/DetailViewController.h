//
//  DetailViewController.h
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 2/16/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <CoreData/CoreData.h>

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectModel *contact;

@property (weak, nonatomic) IBOutlet UILabel *nomeText;
@property (weak, nonatomic) IBOutlet UILabel *telText;
@property (weak, nonatomic) IBOutlet UILabel *endText;
@property (weak, nonatomic) IBOutlet UILabel *emailText;

@property (weak, nonatomic) IBOutlet UIButton *callBnt;
@property (weak, nonatomic) IBOutlet UIButton *smsBnt;
@property (weak, nonatomic) IBOutlet UIButton *mailBnt;

-(IBAction)callContact:(id)sender;
-(IBAction)sendSMS:(id)sender;
-(IBAction)sendMail:(id)sender;

@end
