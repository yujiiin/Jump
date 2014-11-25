//
//  ViewController.m
//  Jump
//
//  Created by Yuji Shimizu on 3/2/14.
//  Copyright (c) 2014 Yuji Shimizu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    NSString *strURL = [NSString stringWithFormat:@"http://54.215.215.248/jump/jump_select_score.php"];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    HighScore.text = [NSString stringWithFormat:@"High Score : %@",result];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
