//
//  Game.h
//  Jump
//
//  Created by Yuji Shimizu on 3/2/14.
//  Copyright (c) 2014 Yuji Shimizu. All rights reserved.
//

#import <UIKit/UIKit.h>

float UpMovement;
float SideMovement;
int RandomPosition;
int Platform3SideMovement;
int Platform5SideMovement;

BOOL BallLeft;
BOOL BallRight;
BOOL StopSideMovement;

float PlatformMoveDown;

float AccelValue;
int ScoreNumber;
int HighScoreNumber;
int AddedScore;
int LevelNumber;

BOOL Platform1Used;
BOOL Platform2Used;
BOOL Platform3Used;
BOOL Platform4Used;
BOOL Platform5Used;

@interface Game : UIViewController <UIAccelerometerDelegate>
{
    UIAccelerationValue *speedX;
    
    IBOutlet UIButton *Start;
    IBOutlet UIImageView *Ball;
    IBOutlet UIImageView *Platform1;
    IBOutlet UIImageView *Platform2;
    IBOutlet UIImageView *Platform3;
    IBOutlet UIImageView *Platform4;
    IBOutlet UIImageView *Platform5;
    
    IBOutlet UILabel *Score;
    IBOutlet UILabel *GameOver;
    IBOutlet UILabel *FinalScore;
    IBOutlet UILabel *HighScore;
    IBOutlet UIButton *Exit;
    
    IBOutlet UILabel *Accel;
    
    IBOutlet UIWebView *WebView;
    
    NSTimer *Movement;

}

-(IBAction)StartGame:(id)sender;
-(IBAction)InsertScore:(id)sender;
-(void)Moving;
-(void)Bounce;
-(void)PlatformMovement;
-(void)PlatformFall;
-(void)Scoring;
-(void)GameOver;

@end
