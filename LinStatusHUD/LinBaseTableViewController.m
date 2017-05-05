//
//  LinBaseTableViewController.m
//  LinStatusHUD
//
//  Created by 西乡流水 on 17/4/3.
//  Copyright © 2017年 西乡流水. All rights reserved.
//

#import "LinBaseTableViewController.h"
#import "LinStatusHUD.h"

@interface LinBaseTableViewController ()<LinStatusHUDDelegate>

@property(nonatomic,strong) LinStatusHUD *hud;


@end

@implementation LinBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

-(LinStatusHUD *)hud
{
    if (!_hud)
    {
        _hud = [LinStatusHUD statusHud];
        _hud.delegate = self;
    }
    
    return _hud;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
    NSLog(@"%@",[LinStatusHUD statusHud]);
    NSLog(@"%@",self.hud);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static  NSString *ID = @"cell";
  
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",(long)indexPath.row];
    
    cell.indentationLevel = indexPath.row;
    
    
    return cell;
}

static bool isSelct = YES;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (isSelct == NO) {return;}
  [self.hud showWranning:@"出现警告了" withType:navigationBarType];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    
}

-(void)linStatusHUDWillShowWithHud:(LinStatusHUD *)hud withHudHeight:(CGFloat)height
{
    [UIView animateWithDuration:0.25 animations:^{
     
        CGPoint contentOffset= self.tableView.contentOffset;
        contentOffset.y= contentOffset.y - height ;
        self.tableView.contentOffset = contentOffset;
        [self scrollViewDidScroll:self.tableView];
    }];
    
}

-(void)linStatusHUDWillHideWithHud:(LinStatusHUD *)hud withHudHeight:(CGFloat)height
{
    [UIView animateWithDuration:0.25 animations:^{
        
        CGPoint contentOffset= self.tableView.contentOffset;
        contentOffset.y= -64 ;
        self.tableView.contentOffset = contentOffset;
        [self scrollViewDidScroll:self.tableView];
        
    } completion:^(BOOL finished) {
        
        [hud hide];
    }];
    
    
}

-(void)linStatusHUDDidShowWithHud:(LinStatusHUD *)hud
{
    isSelct = false;
}

-(void)linStatusHUDDidHideWithHud:(LinStatusHUD *)hud
{
    isSelct = YES;
}

//在最后的时候,赢藏了
- (void)dealloc
{
    [self.hud hide];
}




@end
