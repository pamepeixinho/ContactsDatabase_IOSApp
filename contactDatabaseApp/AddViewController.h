//
//  AddViewController.h
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 2/16/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectModel *contact;

@property (weak, nonatomic) IBOutlet UITextField *nomeText;
@property (weak, nonatomic) IBOutlet UITextField *telText;
@property (weak, nonatomic) IBOutlet UITextField *endText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;

-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)saveContact:(id)sender;

@end
