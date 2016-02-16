//
//  DetailViewController.h
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 2/16/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectModel *contact;

@property (weak, nonatomic) IBOutlet UILabel *nomeText;
@property (weak, nonatomic) IBOutlet UILabel *telText;
@property (weak, nonatomic) IBOutlet UILabel *endText;
@property (weak, nonatomic) IBOutlet UILabel *emailText;

-(IBAction)callContact:(id)sender;
-(IBAction)sendSMS:(id)sender;
-(IBAction)sendMail:(id)sender;

@end
