//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by Ahaan Ugale on 11/1/13.
//  Copyright (c) 2013 Ahaan Ugale. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation HelloWorldViewController

CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSTimeInterval howRecent = [location.timestamp timeIntervalSinceNow];
    if (abs(howRecent) < 1)
    {
        NSString *output = [NSString stringWithFormat:
                            @"lat: %f, lon: %f, alt: %f\n",
                            location.coordinate.latitude,
                            location.coordinate.longitude,
                            location.altitude];
        if (self.textView.text.length > 0)
        {
            NSRange range = [self.textView.text rangeOfString:@"\nHello"];
            if (range.location != NSNotFound)
            {
                output = [output stringByAppendingString:
                          [self.textView.text substringFromIndex:
                           range.location]];
            }
        }
        self.textView.text = output;
    }
}

- (IBAction)textFieldEditingDidEnd:(UITextField *)sender
{
    int count = [sender.text intValue];
    NSString *output = self.textView.text;
    for (int i = 0; i < count; i++)
    {
        output = [output stringByAppendingString:@"\nHello World!"];
    }
    self.textView.text = output;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
