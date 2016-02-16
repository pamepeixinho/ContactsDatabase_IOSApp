//
//  AddViewController.m
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 2/16/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import "AddViewController.h"
#import "TableViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize contact;

//delegate managed object context
-(NSManagedObjectContext *) managedObjectContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    
    return context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.contact) {
        _nomeText.text = [NSString stringWithFormat:@"%@", [contact valueForKey:@"name"]];
        _telText.text = [NSString stringWithFormat:@"%@", [contact valueForKey:@"phoneNumber"]];
        _endText.text = [NSString stringWithFormat:@"%@", [contact valueForKey:@"address"]];
        _emailText.text = [NSString stringWithFormat:@"%@", [contact valueForKey:@"mail"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)dismissKeyboard:(id)sender{
    [self resignFirstResponder];
}

-(IBAction)saveContact:(id)sender{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(self.contact){
        [contact setValue:_nomeText.text forKey:@"name"];
        [contact setValue:_telText.text forKey:@"phoneNumber"];
        [contact setValue:_endText.text forKey:@"address"];
        [contact setValue:_emailText.text forKey:@"mail"];
    }
    else{
        NSManagedObject *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"ContactsData" inManagedObjectContext:context];
        
        [newContact setValue:_nomeText.text forKey:@"name"];
        [newContact setValue:_telText.text forKey:@"phoneNumber"];
        [newContact setValue:_endText.text forKey:@"address"];
        [newContact setValue:_emailText.text forKey:@"mail"];
    }
    
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"%@ %@", error, [error localizedDescription]);
    }
    
//    [self.navigationController popToViewController:home animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
