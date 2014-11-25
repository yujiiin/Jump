//
//  Game.m
//  Jump
//
//  Created by Yuji Shimizu on 3/2/14.
//  Copyright (c) 2014 Yuji Shimizu. All rights reserved.
//

#import "Game.h"
#import <CoreMotion/CoreMotion.h>

@interface Game ()
@property (nonatomic, retain) CMMotionManager *manager;
@end

@implementation Game
@synthesize manager = _manager;

-(IBAction)InsertScore:(id)sender{
    NSString *strURL = [NSString stringWithFormat:@"http://54.215.215.248/jump/jump_insert_score.php?score=%d",ScoreNumber];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLConnection *Connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    
   }

- (void)startCMAccelerometerData:(int)frequency
{
// 現在、加速度センサー無しのデバイスは存在しないが念のための確認
if (self.manager.accelerometerAvailable) {
    // センサーの更新間隔の指定
    self.manager.accelerometerUpdateInterval = 0.01;  // 100Hz
    
    // ハンドラを指定
    CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error) {
   //     double timestamp = data.timestamp;  // 更新時刻
   //     double x = data.acceleration.x;  // X軸: 加速度G
   //     double y = data.acceleration.y;  // Y軸: 加速度G
   //     double z = data.acceleration.z;  // Z軸: 加速度G
 
        AccelValue = data.acceleration.x * 5;
        Accel.text = [NSString stringWithFormat:@"%f",AccelValue];
        // x, y, zの値を必要に応じて、ローパス・ハイパスなどのフィルタを適用する
    };

    
    // センサーの利用開始
    [self.manager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:handler];
    
}

}

-(void)GameOver{
    
    Ball.hidden = YES;
    Platform1.hidden = YES;
    Platform2.hidden = YES;
    Platform3.hidden = YES;
    Platform4.hidden = YES;
    Platform5.hidden = YES;
    Score.hidden = YES;
    GameOver.hidden = NO;
    Exit.hidden = NO;
    FinalScore.hidden = NO;
    
    FinalScore.text = [NSString stringWithFormat:@"Final Score: %i",ScoreNumber];
    
    [Movement invalidate];
    [self viewWillAppear:NO];
    
    if(ScoreNumber > HighScoreNumber){
        HighScoreNumber = ScoreNumber;
        [[NSUserDefaults standardUserDefaults] setInteger:HighScoreNumber forKey:@"HighScoreSaved"];
        HighScore.hidden = NO;
    }
}


-(void)Scoring{
    ScoreNumber = ScoreNumber + AddedScore;
    AddedScore = 0;
 
    Score.text = [NSString stringWithFormat:@"%i",ScoreNumber];

    if(ScoreNumber > 50 && ScoreNumber < 100){
        LevelNumber = 2;
    }
    if(ScoreNumber > 100 && ScoreNumber < 200){
        LevelNumber = 3;
    }
    if(ScoreNumber > 200 && ScoreNumber < 300){
        LevelNumber = 4;
    }
    if(ScoreNumber > 300 && ScoreNumber < 400){
        LevelNumber = 5;
    }
    if(ScoreNumber > 400){
        LevelNumber = 6;
    }
}


-(void)PlatformFall{
    if(Ball.center.y > 500){
        PlatformMoveDown = 1;
    }
    else if(Ball.center.y > 450){
        PlatformMoveDown = 2;
    }
    else if(Ball.center.y > 400){
        PlatformMoveDown = 4;
    }
    else if(Ball.center.y > 300){
        PlatformMoveDown = 5;
    }
    else if(Ball.center.y > 250){
        PlatformMoveDown = 6;
    }

}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    BallLeft = NO;
    BallRight = NO;
    StopSideMovement = YES;

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if(point.x < 160){
        BallLeft = YES;
    }
    else{
        BallRight = YES;
    }

}



-(void)PlatformMovement{
    
    Platform1.center = CGPointMake(Platform1.center.x, Platform1.center.y + PlatformMoveDown);
    Platform2.center = CGPointMake(Platform2.center.x, Platform2.center.y + PlatformMoveDown);
    Platform3.center = CGPointMake(Platform3.center.x + Platform3SideMovement, Platform3.center.y + PlatformMoveDown);
    Platform4.center = CGPointMake(Platform4.center.x, Platform4.center.y + PlatformMoveDown);
    Platform5.center = CGPointMake(Platform5.center.x + Platform5SideMovement, Platform5.center.y + PlatformMoveDown);
    
    if(Platform3.center.x < 37){
        switch (LevelNumber) {
            case 1:
                Platform3SideMovement = 2;
                break;
            case 2:
                Platform3SideMovement = 3;
                break;
            case 3:
                Platform3SideMovement = 4;
                break;
            case 4:
                Platform3SideMovement = 5;
                break;
            case 5:
                Platform3SideMovement = 6;
                break;
            default:
                break;
        }
    }
    if(Platform3.center.x > 283){
        switch (LevelNumber) {
            case 1:
                Platform3SideMovement = -2;
                break;
            case 2:
                Platform3SideMovement = -3;
                break;
            case 3:
                Platform3SideMovement = -4;
                break;
            case 4:
                Platform3SideMovement = -5;
                break;
            case 5:
                Platform3SideMovement = -6;
                break;
            default:
                break;
        }
    }

    if(Platform5.center.x < 37){
        switch (LevelNumber) {
            case 1:
                Platform5SideMovement = 2;
                break;
            case 2:
                Platform5SideMovement = 3;
                break;
            case 3:
                Platform5SideMovement = 4;
                break;
            case 4:
                Platform5SideMovement = 5;
                break;
            case 5:
                Platform5SideMovement = 6;
                break;
            default:
                break;
        }
    }
    if(Platform5.center.x > 283){
        switch (LevelNumber) {
            case 1:
                Platform5SideMovement = -2;
                break;
            case 2:
                Platform5SideMovement = -3;
                break;
            case 3:
                Platform5SideMovement = -4;
                break;
            case 4:
                Platform5SideMovement = -5;
                break;
            case 5:
                Platform5SideMovement = -6;
                break;
            default:
                break;
        }
    }
    
    PlatformMoveDown = PlatformMoveDown - 0.1;
    if(PlatformMoveDown < 0){
        PlatformMoveDown = 0;
    }
    if(Platform1.center.y > 575){
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform1.center = CGPointMake(RandomPosition, -6);
        Platform1Used = NO;
    }
    if(Platform2.center.y > 575){
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform2.center = CGPointMake(RandomPosition, -6);
        Platform2Used = NO;
    }
    if(Platform3.center.y > 575){
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform3.center = CGPointMake(RandomPosition, -6);
        Platform3Used = NO;
    }
    if(Platform4.center.y > 575){
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform4.center = CGPointMake(RandomPosition, -6);
        Platform4Used = NO;
    }
    if(Platform5.center.y > 575){
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform5.center = CGPointMake(RandomPosition, -6);
        Platform5Used = NO;
    }
}

-(void)Bounce{
    Ball.animationImages = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"ball_bounce1.png"],
                            [UIImage imageNamed:@"ball_bounce2.png"],
                            [UIImage imageNamed:@"ball_bounce1.png"],
                            [UIImage imageNamed:@"ball.png"],nil];
    [Ball setAnimationRepeatCount:1];
    Ball.animationDuration = 0.2;
    [Ball startAnimating];
    
    if(Ball.center.y > 450){
        UpMovement = 5;
    }
    else if(Ball.center.y > 350){
        UpMovement = 4;
    }
    else if(Ball.center.y > 250){
        UpMovement = 3;
    }
}


-(void)Moving{
    
    if(Ball.center.y > 575){
        [self GameOver];
    }
    
    [self Scoring];
    
    if(Ball.center.y < 250){
        Ball.center = CGPointMake(Ball.center.x, 250);
    }
    
    [self PlatformMovement];
    
    Ball.center = CGPointMake(Ball.center.x + SideMovement + AccelValue,Ball.center.y - UpMovement);
    
    if((CGRectIntersectsRect(Ball.frame, Platform1.frame)) && (UpMovement < -2)){
        [self Bounce];
        [self PlatformFall];
        if(Platform1Used == NO) {
            AddedScore = 10;
            Platform1Used = YES;
        }
    
    }
    if((CGRectIntersectsRect(Ball.frame, Platform2.frame)) && (UpMovement < -2)){
        [self Bounce];
        [self PlatformFall];
        if(Platform2Used == NO) {
            AddedScore = 10;
            Platform2Used = YES;
        }
    }
    if((CGRectIntersectsRect(Ball.frame, Platform3.frame)) && (UpMovement < -2)){
        [self Bounce];
        [self PlatformFall];
        if(Platform3Used == NO) {
            AddedScore = 10;
            Platform3Used = YES;
        }
    }
    if((CGRectIntersectsRect(Ball.frame, Platform4.frame)) && (UpMovement < -2)){
        [self Bounce];
        [self PlatformFall];
        if(Platform4Used == NO) {
            AddedScore = 10;
            Platform4Used = YES;
        }
    }
    if((CGRectIntersectsRect(Ball.frame, Platform5.frame)) && (UpMovement < -2)){
        [self Bounce];
        [self PlatformFall];
        if(Platform5Used == NO) {
            AddedScore = 10;
            Platform5Used = YES;
        }
    }
    UpMovement = UpMovement - 0.1;
    
    if(BallLeft == YES){
        SideMovement = SideMovement - 0.3;
        if(SideMovement < -5){
            SideMovement = -5;
        }
    }
    if(BallRight == YES){
        SideMovement = SideMovement + 0.3;
        if(SideMovement > 5){
            SideMovement = 5;
        }
    }
    
    if(StopSideMovement == YES && SideMovement > 0){
        SideMovement = SideMovement - 0.1;
        if(SideMovement < 0){
            SideMovement = 0;
            StopSideMovement = NO;
        }
    }
    if(StopSideMovement == YES && SideMovement < 0){
        SideMovement = SideMovement + 0.1;
        if(SideMovement >0){
            SideMovement = 0;
            StopSideMovement = NO;
        }
    }
    
    if(Ball.center.x < -11){
        Ball.center = CGPointMake(330, Ball.center.y);
    }
    if(Ball.center.x > 330){
        Ball.center = CGPointMake(-11, Ball.center.y);
    }
    
}



-(IBAction)StartGame:(id)sender{
    Start.hidden = YES;
    UpMovement = -5;
    
    Movement = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(Moving) userInfo:nil repeats:YES];

    Platform2.hidden = NO;
    Platform3.hidden = NO;
    Platform4.hidden = NO;
    Platform5.hidden = NO;
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform2.center = CGPointMake(RandomPosition,448);
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform3.center = CGPointMake(RandomPosition,336);
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform4.center = CGPointMake(RandomPosition,224);
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform5.center = CGPointMake(RandomPosition,112);
    
    Platform3SideMovement = -2;
    Platform5SideMovement = 2;
    
}

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
    Platform2.hidden = YES;
    Platform3.hidden = YES;
    Platform4.hidden = YES;
    Platform5.hidden = YES;
    
    GameOver.hidden = YES;
    FinalScore.hidden = YES;
    HighScore.hidden = YES;
    Exit.hidden = YES;
    
    WebView.hidden = YES;
    
    ScoreNumber = 0;
    AddedScore = 0;
    LevelNumber = 1;
    
    Platform1Used = NO;
    Platform2Used = NO;
    Platform3Used = NO;
    Platform4Used = NO;
    Platform5Used = NO;
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"High Score Saved"];
    UpMovement = 0;
    SideMovement = 0;
    
    // 周波数(Hz)
    int frequency = 50;
    // インスタンスの生成
    self.manager = [[CMMotionManager alloc] init];
    // CMAccelerometerDataの開始
    [self startCMAccelerometerData:frequency];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
