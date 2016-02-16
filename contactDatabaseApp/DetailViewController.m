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
    [_callBnt.layer setCornerRadius:7.5f];
    [_smsBnt.layer setCornerRadius:7.5f];
    [_mailBnt.layer setCornerRadius:7.5f];
}

-(void) viewWillAppear:(BOOL)animated{
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
    MFMessageComposeViewController *TextCompose = [[MFMessageComposeViewController alloc] init];
    [TextCompose setMessageComposeDelegate:self];
    
    if([MFMessageComposeViewController canSendText]){
        [TextCompose setRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", _telText.text], nil]];
        [TextCompose setBody:[NSString stringWithFormat:@"Hey"]];
        [self presentViewController:TextCompose animated:YES completion:NULL];
    }else{
        NSLog(@"Cant send sms");
    }
}

-(void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
     switch (result) {
         case MessageComposeResultCancelled:
              NSLog(@"Cancelled");
              break;
         case MessageComposeResultFailed:
              NSLog(@"Failed");
              break;
         case MessageComposeResultSent:
              NSLog(@"Sent");
              break;
    
         default:
              break;
        }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)sendMail:(id)sender{
    MFMailComposeViewController *TextCompose = [[MFMailComposeViewController alloc] init];
    //    [TextCompose setMessageComposeDelegate:self];
    [TextCompose setMailComposeDelegate:self];
    
    if ([MFMailComposeViewController canSendMail]) {
        [TextCompose setToRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", _emailText.text], nil]];
//        [TextCompose setSubject:[NSString stringWithFormat:@""];
        [TextCompose setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:TextCompose animated:YES completion:NULL];
        //        NSData *image = UIImageJPEGRepresentation(self.imageView.image, 1);
        //        [TextCompose addAttachmentData:image typeIdentifier:@"image/jpeg" filename:@"Nina5.jpg"];
        [self presentViewController:TextCompose animated:YES completion:NULL];
    }else{
        NSLog(@"Cant send mail");
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
        switch (result) {
            case MFMailComposeResultCancelled:
                NSLog(@"Cancelled");
                break;
            case MFMailComposeResultFailed:
                NSLog(@"Failed");
                break;
            case MFMailComposeResultSent:
                NSLog(@"Sent");
                break;
    
            default:
                break;
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
