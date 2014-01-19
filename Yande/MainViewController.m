//
//  MainViewController.m
//  Yande
//
//  Created by 南 篤良 on 14-1-12.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import "MainViewController.h"
#import "YandeNavigationView.h"
#import "UIImageView+ImageDownloader.h"
#import "YandeCell.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UITableView *_lTableView;
    UITableView *_rTableView;
    NSMutableArray *imageDataSource;
    BOOL isSet;
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
    [super viewDidLoad];
    imageDataSource = [[NSMutableArray alloc]init];
    
    //创建导航条
    self.navigationController.navigationBarHidden = YES;
    YandeNavigationView *navigationView = [[YandeNavigationView alloc]initWithDoubleButtonTitle:@"All" LeftButtonIcon:Nil RightButtonIcon:Nil ButtonDelegate:self LeftButtonSelecter:@selector(menuButtonClick) RightButtonSelecter:@selector(settingButtonClick)];
    [self.view addSubview:navigationView];
    
    //创建TableView
    [self CreatTableViewY:navigationView.frame.size.height + navigationView.frame.origin.y H:[UIScreen mainScreen].bounds.size.height - navigationView.frame.origin.y - navigationView.frame.size.height];
    
    //加载
    [self getPicList:@"all" Page:1];
}

- (void)CreatTableViewY:(float)y H:(float)h{
    //tableView左空间
    NSInteger tableViewLeftSpace = 8;
    //tableView宽度
    NSInteger tableViewWidth = 142;
    //tableView间隔
    NSInteger tableViewSection = 6;
    
    //左侧TableView
    _lTableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewLeftSpace, y, tableViewWidth + tableViewSection, h) style:UITableViewStylePlain];
    [self ios7TableViewBugFix:_lTableView];
    _lTableView.delegate = self;
    _lTableView.dataSource = self;
    _lTableView.showsVerticalScrollIndicator = NO;
    _lTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_lTableView];
    
    //右侧TableView
    _rTableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewLeftSpace + tableViewWidth + tableViewSection, y, tableViewWidth + 10, h) style:UITableViewStylePlain];
    [self ios7TableViewBugFix:_rTableView];
    _rTableView.delegate = self;
    _rTableView.dataSource = self;
    _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_rTableView];
}

- (void)ios7TableViewBugFix:(UITableView *)tableView{
    if([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

//加载图片列表
- (void)getPicList:(NSString *)tag  Page:(NSInteger) page{
    NSString *url = [NSString stringWithFormat:@"%@GetPicInfo.php?tag=%@&page=%d",SERVERIP,tag,page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        isSet = NO;
        [imageDataSource addObjectsFromArray:[responseObject objectForKey:@"data"]];
        [_lTableView reloadData];
        [_rTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_lTableView == tableView)
    {
        return [imageDataSource count]%2 == 0?[imageDataSource count]/2:[imageDataSource count]/2+1;
    }
    return [imageDataSource count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"imageCell";
    YandeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell == nil)
    {
        cell = [[YandeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict;
    if(_lTableView == tableView)
    {
        dict = [imageDataSource objectAtIndex:indexPath.row*2];
    }
    else if (_rTableView == tableView)
    {
        dict = [imageDataSource objectAtIndex:indexPath.row*2+1];
    }
    [cell.thumb imageLoadFromUrl:[dict objectForKey:@"preview_url"] ImageID:[dict objectForKey:@"id"] Type:@"preview"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict;
    if (_lTableView == tableView)
    {
        dict = [imageDataSource objectAtIndex:indexPath.row*2];
    }
    if (_rTableView == tableView)
    {
        dict = [imageDataSource objectAtIndex:indexPath.row*2+1];
    }

    CGFloat height = [[dict objectForKey:@"preview_height"]floatValue]*142/[[dict objectForKey:@"preview_width"]floatValue];
    return height + 6;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menuButtonClick
{
    
}

- (void)settingButtonClick
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!isSet)
    {
        CGSize size;
        size.height = MAX(_lTableView.contentSize.height, _rTableView.contentSize.height);
        size.width = _lTableView.contentSize.width;
        _lTableView.contentSize = size;
        size.width = _rTableView.contentSize.width;
        _rTableView.contentSize = size;
        isSet = YES;
    }
    _lTableView.contentOffset = scrollView.contentOffset;
    _rTableView.contentOffset = scrollView.contentOffset;

}


@end
