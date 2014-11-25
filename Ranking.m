//
//  Ranking.m
//  Jump
//
//  Created by Yuji Shimizu on 3/9/14.
//  Copyright (c) 2014 Yuji Shimizu. All rights reserved.
//

#import "Ranking.h"

@interface Ranking ()

@end

@implementation Ranking

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    NSString *strURL = [NSString stringWithFormat:@"http://54.215.215.248/jump/jump_get_ranking.php"];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
   
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *rank1 = [jsonArray valueForKey:@"Rank1"];
    NSArray *Score1 = [rank1 valueForKey:@"score"];
    NSString *str1 = [Score1 objectAtIndex:0];
    Rank1.text = [NSString stringWithFormat:@"Rank1 : %@",str1];
    
    NSDictionary *rank2 = [jsonArray valueForKey:@"Rank2"];
    NSArray *Score2 = [rank2 valueForKey:@"score"];
    NSString *str2 = [Score2 objectAtIndex:1];
    Rank2.text = [NSString stringWithFormat:@"Rank2 : %@",str2];

    NSDictionary *rank3 = [jsonArray valueForKey:@"Rank3"];
    NSArray *Score3 = [rank3 valueForKey:@"score"];
    NSString *str3 = [Score3 objectAtIndex:2];
    Rank3.text = [NSString stringWithFormat:@"Rank3 : %@",str3];
    
    NSDictionary *rank4 = [jsonArray valueForKey:@"Rank4"];
    NSArray *Score4 = [rank4 valueForKey:@"score"];
    NSString *str4 = [Score4 objectAtIndex:3];
    Rank4.text = [NSString stringWithFormat:@"Rank4 : %@",str4];
    
    NSDictionary *rank5 = [jsonArray valueForKey:@"Rank5"];
    NSArray *Score5 = [rank5 valueForKey:@"score"];
    NSString *str5 = [Score5 objectAtIndex:4];
    Rank5.text = [NSString stringWithFormat:@"Rank5 : %@",str5];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
