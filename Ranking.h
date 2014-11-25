//
//  Ranking.h
//  Jump
//
//  Created by Yuji Shimizu on 3/9/14.
//  Copyright (c) 2014 Yuji Shimizu. All rights reserved.
//

#import <UIKit/UIKit.h>

int score1;
int score2;
int score3;
int score4;
int score5;

@interface Ranking : UIViewController
{
    IBOutlet UILabel *Rank1;
    IBOutlet UILabel *Rank2;
    IBOutlet UILabel *Rank3;
    IBOutlet UILabel *Rank4;
    IBOutlet UILabel *Rank5;
    
    IBOutlet UIWebView *webView;
    
}
@end
