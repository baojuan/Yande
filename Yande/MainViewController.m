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
	// Do any additional setup after loading the view.
    imageDataSource = [[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden = YES;
    YandeNavigationView *navigationView = [[YandeNavigationView alloc]initWithDoubleButtonTitle:@"All" MenuButtonIcon:nil SettingButtonIcon:nil ButtonDelegate:self MenuButtonSelecter:@selector(menuButtonClick) SettingButtonSelecter:@selector(settingButtonClick)];
    [self.view addSubview:navigationView];
    
    
    _lTableView = [[UITableView alloc]initWithFrame:CGRectMake(8, navigationView.frame.size.height + navigationView.frame.origin.y, 142+6, [UIScreen mainScreen].bounds.size.height - navigationView.frame.origin.y - navigationView.frame.size.height) style:UITableViewStylePlain];
    //ios7 table view bug fixed
    if([_lTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_lTableView setSeparatorInset:UIEdgeInsetsZero];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _lTableView.delegate = self;
    _lTableView.dataSource = self;
    _lTableView.showsVerticalScrollIndicator = NO;
    _lTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_lTableView];
    
    
    _rTableView = [[UITableView alloc]initWithFrame:CGRectMake(156, navigationView.frame.size.height + navigationView.frame.origin.y, 142+10, [UIScreen mainScreen].bounds.size.height - navigationView.frame.origin.y - navigationView.frame.size.height) style:UITableViewStylePlain];
    //ios7 table view bug fixed
    if([_rTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_rTableView setSeparatorInset:UIEdgeInsetsZero];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rTableView.delegate = self;
    _rTableView.dataSource = self;
    [self.view addSubview:_rTableView];

    
    //加载
    [self getPicList:@"all" Page:1];
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
    if (_lTableView == tableView)
    {
        NSDictionary *dict = [imageDataSource objectAtIndex:indexPath.row*2];
        [cell.thumb imageLoadFromUrl:[dict objectForKey:@"preview_url"] ImageID:[dict objectForKey:@"id"] Type:@"preview"];
    }
    if (_rTableView == tableView)
    {
        NSDictionary *dict = [imageDataSource objectAtIndex:indexPath.row*2+1];
        [cell.thumb imageLoadFromUrl:[dict objectForKey:@"preview_url"] ImageID:[dict objectForKey:@"id"] Type:@"preview"];
    }
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
