//
//  DetailViewController.m
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 2/16/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import "DetailViewController.h"
#import "AddViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize contact;

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"editContact"]){
        AddViewController *nextView = [segue destinationViewController];
        [nextView setContact:self.contact];
    }
}

-(IBAction)callContact:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _telText.text]]];
}

-(IBAction)sendSMS:(id)sender{
    
}

-(IBAction)sendMail:(id)sender{
    
}

@end
